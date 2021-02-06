import 'package:flutterhackathon_firecode/models/usermodel.dart';

abstract class AuthBase{
Future<UserModel> currentUser();
Future<bool> signOut();
Future<UserModel> signInWithGoogle();
Future<UserModel> signInWithEmailandPassword(String email, String password);
Future<UserModel> createUserWithEmailandPassword(String email, String password);
Future<void> resetPassword(String email);
}