import 'package:flutterhackathon_firecode/models/usermodel.dart';

abstract class DBBase{
  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userID);
}