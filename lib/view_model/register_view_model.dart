import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/firebase_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _name;
  String? get name => _name;

  get nameController => null;
  set name(String? value) {
    _name = value;
    notifyListeners();
  }

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

  Future<bool> registerUser() async {
    if (_name == null || _email == null || _password == null) {
      _errorMessage = "All fields are required!";
      notifyListeners();
      return false;
    }

    bool result = await _firebaseService.registerUser(
        name: _name!, email: _email!, password: _password!);

    if (!result) {
      _errorMessage = "Registration failed. Please try again.";
      notifyListeners();
    }

    return result;
  }
}
