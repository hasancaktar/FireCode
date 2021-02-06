import 'dart:io';

import 'package:flutterhackathon_firecode/locator.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/services/auth/fakeauthservice.dart';
import 'package:flutterhackathon_firecode/services/auth/firebaseauthservice.dart';
import 'package:flutterhackathon_firecode/services/auth/authbase.dart';
import 'package:flutterhackathon_firecode/services/db/firestoredbservice.dart';
import 'package:flutterhackathon_firecode/services/storage/firebasestorage.dart';

enum AppMode { DEBUG, RELEASE }

class Repository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FireStoreDBService _fireStoreDBService = locator<FireStoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<UserModel> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      UserModel _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _fireStoreDBService.readUser(_user.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      UserModel _user = await _firebaseAuthService.signInWithGoogle();
      bool _result = await _fireStoreDBService.saveUser(_user);
      if (_result) {
        return await _fireStoreDBService.readUser(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmailandPassword(
          email, sifre);
    } else {
      return await _firebaseAuthService.createUserWithEmailandPassword(
          email, sifre);
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmailandPassword(email, sifre);
    } else {
      UserModel _user =
          await _firebaseAuthService.signInWithEmailandPassword(email, sifre);
      bool _result = await _fireStoreDBService.saveUser(_user);
      if (_result) {
        return await _fireStoreDBService.readUser(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthService.resetPassword(email);
    } else {
      return await _firebaseAuthService.resetPassword(email);
    }
  }

  Future<String> uploadFile(
      String userID, String fileType, File document) async {
    if (appMode == AppMode.DEBUG) {
      return "url";
    } else {
      var file = File(document.path);

      var url =
          await _firebaseStorageService.uploadFile(userID, fileType, file);
      return url;
    }
  }
}
