import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentware/models/firebase_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService =
      GetIt.instance.get<FirebaseService>();

  String get profileImage => _firebaseService.currentUser?["image"] ?? "";
  String get name => _firebaseService.currentUser?["name"] ?? "";
  String get email => _firebaseService.currentUser?["email"] ?? "";

  Future<String?> changeProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        File image = File(result.files.first.path!);
        bool success = await _firebaseService.changeProfileImage(image);
        if (success) {
          notifyListeners();
          return "Profile picture changed successfully!";
        } else {
          return "Profile picture changing failed!";
        }
      } else {
        return "No file selected!";
      }
    } catch (e) {
      return "Error in file uploading: $e";
    }
  }
}
