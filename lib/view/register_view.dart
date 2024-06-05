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
                    _registrationForm(
                        context, viewModel, deviceWidth, deviceHeight),
                  ],
                ),
              ),
            ),
          ),
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
            color: Colors.black26,
          ),
        ],
      ),
    );
  }

  Widget _registrationForm(BuildContext context, RegisterViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return SizedBox(
      height: deviceHeight * 0.50,
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
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            _registerButton(context, viewModel, deviceWidth, deviceHeight),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField(BuildContext context, RegisterViewModel viewModel) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Name",
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
      onChanged: (value) => viewModel.name = value,
      validator: (value) =>
          value!.isNotEmpty ? null : "Please enter a name before register.",
    );
  }

  Widget _emailTextField(BuildContext context, RegisterViewModel viewModel) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
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
      validator: (value) => value!.length > 6
          ? null
          : "Password should contain at least 6 characters",
    );
  }

  Widget _registerButton(BuildContext context, RegisterViewModel viewModel,
      double deviceWidth, double deviceHeight) {
    return ElevatedButton(
      onPressed: () async {
        if (viewModel.formKey.currentState!.validate()) {
          bool result = await viewModel.registerUser();
          if (result) {
            Navigator.pop(context);
          }
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
        "Register",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
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
