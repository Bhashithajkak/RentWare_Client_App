import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/firebase_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();

  String get profileImage => _firebaseService.currentUser?["image"] ?? "";
  String get name => _firebaseService.currentUser?["name"] ?? "";
  String get email => _firebaseService.currentUser?["email"] ?? "";
}
