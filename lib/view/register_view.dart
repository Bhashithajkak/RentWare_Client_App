// register_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentware/view_model/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const _RegisterPageContent(),
    );
  }
}

class _RegisterPageContent extends StatelessWidget {
  const _RegisterPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _registrationForm(context, viewModel, deviceHeight),
                _registerButton(context, viewModel, deviceWidth, deviceHeight),
              ],
            ),
          ),
        ),
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

  Widget _registrationForm(
      BuildContext context, RegisterViewModel viewModel, double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.30,
      child: Form(
        key: viewModel.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameTextField(context, viewModel),
            _emailTextField(context, viewModel),
            _passwordTextField(context, viewModel),
            if (viewModel.errorMessage != null) _errorText(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField(BuildContext context, RegisterViewModel viewModel) {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Name"),
      onChanged: (value) => viewModel.name = value,
      validator: (value) =>
          value!.isNotEmpty ? null : "Please enter a name before register.",
    );
  }

  Widget _emailTextField(BuildContext context, RegisterViewModel viewModel) {
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

  Widget _passwordTextField(BuildContext context, RegisterViewModel viewModel) {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Password"),
      onChanged: (value) => viewModel.password = value,
      validator: (value) => value!.length > 6 ? null : "Invalid password",
    );
  }

  Widget _registerButton(BuildContext context, RegisterViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return MaterialButton(
      onPressed: () async {
        if (viewModel.formKey.currentState!.validate()) {
          bool result = await viewModel.registerUser();
          if (result) {
            Navigator.pop(context);
          }
        }
      },
      minWidth: deviceWidth * 0.7,
      height: deviceHeight * 0.06,
      color: Colors.blue,
      child: const Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _errorText(RegisterViewModel viewModel) {
    return Text(
      viewModel.errorMessage ?? '',
      style: const TextStyle(
        color: Color.fromARGB(255, 172, 41, 41),
        fontSize: 15,
      ),
    );
  }
}
