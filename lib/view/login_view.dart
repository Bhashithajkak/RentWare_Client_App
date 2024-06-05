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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _backgroundImage(),
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

  Widget _backgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          colorFilter: ColorFilter.mode(
            Colors.white70,
            BlendMode.dstATop,
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "RentWare",
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(2, 2),
            blurRadius: 3,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context, LoginViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.40,
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
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            _loginButton(context, viewModel, deviceWidth, deviceHeight),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context, LoginViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return ElevatedButton(
      onPressed: () async {
        bool result = await viewModel.loginUser();
        if (result) {
          Navigator.pushNamed(context, "landing");
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        minimumSize: Size(deviceWidth * 0.7, deviceHeight * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _emailTextField(BuildContext context, LoginViewModel viewModel) {
    return TextFormField(
      controller: viewModel.emailController,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
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
      controller: viewModel.passwordController,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
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
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
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
