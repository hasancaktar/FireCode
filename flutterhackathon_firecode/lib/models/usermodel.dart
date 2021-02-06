import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel{
  final String userID;
  String email;
  String userName;
  String profileURL;
  DateTime createdAt;

UserModel({@required this.userID,@required this.email});

Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'email' : email,
      'userName': userName ?? email.substring(0,email.indexOf('@'))+randomIntCreate(),
      'profileURL': profileURL ?? 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
      //'updatedAt' : updatedAt ?? FieldValue.serverTimestamp(),
    };
  }
  UserModel.fromMap(Map<String,dynamic> map): 
    userID= map['userID'],
    email= map['email'],
    userName= map['userName'],
    profileURL= map['profileURL'],
    createdAt= (map['createdAt'] as Timestamp).toDate();
    //updatedAt= (map['updatedAt'] as Timestamp).toDate();
   @override
  String toString() {
   return 'UserModel{userID:$userID,email:$email,userName:$userName,profileURL:$profileURL,createdAt:$createdAt}';
  }
  String randomIntCreate(){
    int _randomInt=Random().nextInt(999999);
    return _randomInt.toString();
  }
}