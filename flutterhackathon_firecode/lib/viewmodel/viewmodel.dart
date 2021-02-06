import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/locator.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/repository/repository.dart';
import 'package:flutterhackathon_firecode/services/auth/authbase.dart';

enum ViewState { Idle, Busy }

class ViewModel with ChangeNotifier implements AuthBase {
  ViewState _viewState = ViewState.Idle;
  Repository _userRepository = locator<Repository>();
  UserModel _userModel;
  String passwordErrorMessage;
  String emailErrorMessage;

  UserModel get userModel => _userModel;

  ViewState get viewState => _viewState;
  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  ViewModel() {
    currentUser();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      viewState = ViewState.Busy;
      _userModel = await _userRepository.currentUser();
      if(_userModel!=null){
        return _userModel;
      }else{
        return null;
      }
      
    } catch (e) {
      debugPrint("USER_VİEW_MODEL_CURRENT_USER HATA" + e.toString());
      return null;
    } finally {
      viewState = ViewState.Idle;
    }
  }


  @override
  Future<bool> signOut() async {
    try {
      viewState = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _userModel = null;
      return sonuc;
    } catch (e) {
      debugPrint("USER_VİEW_MODEL_SIGN_OUT HATA" + e.toString());
      return false;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      viewState = ViewState.Busy;
      _userModel = await _userRepository.signInWithGoogle();
      return _userModel;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String sifre) async {
         try {
    if (_emailPasswordCheck(email, sifre)) {
     
        viewState = ViewState.Busy;
        _userModel =
            await _userRepository.createUserWithEmailandPassword(email, sifre);
        return _userModel;
      }else
      return null;
    } finally {
        viewState = ViewState.Idle;
      }
       
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String sifre) async {
    try {
      if (_emailPasswordCheck(email, sifre)) {
        viewState = ViewState.Busy;
        _userModel =
            await _userRepository.signInWithEmailandPassword(email, sifre);
        return _userModel;
      } else
        return null;
    } finally {
      viewState = ViewState.Idle;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      viewState = ViewState.Busy;
      await _userRepository.resetPassword(email);
    } finally {
      viewState = ViewState.Idle;
    }
  }

  //Check Section
  bool _emailPasswordCheck(String email, String sifre) {
    var result = true;
    if (sifre.length < 6) {
      passwordErrorMessage = "En az 6 karakter olmalı";
      result = false;
    } else
      passwordErrorMessage = null;
    if (!email.contains("@")) {
      emailErrorMessage = "Geçersiz e-mail adresi";
      result = false;
    } else
      emailErrorMessage = null;
    return result;
  }
    Future<String> uploadFile(String userID, String fileType, File document)async {
    var result = await _userRepository.uploadFile(userID,fileType,document);
    return result;
  }
}