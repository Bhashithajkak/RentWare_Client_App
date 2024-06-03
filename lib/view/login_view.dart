// login_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/view_model/login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginPageContent(),
    );
  }
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _titleWidget(),
                    _loginForm(context, viewModel, deviceWidth, deviceHeight),
                    _registerPageLink(context),
                  ],
                ),
              ),
            ),
          ),
          if (viewModel.isLoggingIn) _loadingIndicator(deviceHeight),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "RentWare",
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _loginForm(BuildContext context, LoginViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.30,
      child: Form(
        key: viewModel.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailTextField(context, viewModel),
            _passwordTextField(context, viewModel),
            if (viewModel.errorMessage != null) _errorText(viewModel),
            _loginButton(context, viewModel, deviceWidth, deviceHeight),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context, LoginViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return MaterialButton(
      onPressed: () async {
        bool result = await viewModel.loginUser();
        if (result) {
          Navigator.pushNamed(context, "landing");
        }
      },
      minWidth: deviceWidth * 0.7,
      height: deviceHeight * 0.06,
      color: Colors.blue,
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _emailTextField(BuildContext context, LoginViewModel viewModel) {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email"),
      onChanged: (value) => viewModel.email = value,
      validator: (value) {
        bool result = value!.contains(
            RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"));
        return result ? null : "Invalid email";
      },
    );
  }

  Widget _passwordTextField(BuildContext context, LoginViewModel viewModel) {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Password"),
      onChanged: (value) => viewModel.password = value,
      validator: (value) => value!.length > 6 ? null : "Invalid password",
    );
  }

  Widget _registerPageLink(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loadingIndicator(double deviceHeight) {
    return Container(
      height: deviceHeight,
      color: Colors.black54,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text("Logging in...",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _errorText(LoginViewModel viewModel) {
    return Text(
      viewModel.errorMessage ?? '',
      style: const TextStyle(
        color: Color.fromARGB(255, 172, 41, 41),
        fontSize: 15,
      ),
    );
  }
}
