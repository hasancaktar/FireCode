import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/services/auth/authbase.dart';

class FakeAuthService implements AuthBase{

  String userID="123123123";
  String email= 'fakeuser@fake.com';

  @override
  Future<UserModel> currentUser() async{ 
    return await Future.value(UserModel(userID: userID,email:email));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<UserModel> signInWithGoogle() async{
   return await Future.delayed(Duration(seconds: 2), ()=> UserModel(userID: "Google userID",email:email));
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(String email, String sifre) async{
     return await Future.delayed(Duration(seconds: 2), ()=> UserModel(userID: "Created userID",email:email));
    }
  
    @override
    Future<UserModel> signInWithEmailandPassword(String email, String sifre) async{
    return await Future.delayed(Duration(seconds: 2), ()=> UserModel(userID: "SignIn userID",email:email));
  }

  @override
  Future<void> resetPassword(String email) {
    return null;
  }

}