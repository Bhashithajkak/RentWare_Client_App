import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/firebase_service.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  String? _email;
  String? get email => _email;
  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  String? _password;
  String? get password => _password;
  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> loginUser() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    if (_email == null || _password == null) {
      _errorMessage = "Email and password cannot be empty!";
      notifyListeners();
      return false;
    }

    _isLoggingIn = true;
    _errorMessage = null;
    notifyListeners();

    bool result =
        await _firebaseService.loginUser(email: _email!, password: _password!);
    _isLoggingIn = false;
    if (result) {
      _email = null;
      _password = null;
      emailController.clear();
      passwordController.clear();
      formKey.currentState!.reset();
    } else {
      _errorMessage = "Invalid email or password!";
    }

    notifyListeners();
    return result;
  }
}
