import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/services/auth/authbase.dart';
import 'package:google_sign_in/google_sign_in.dart';



class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> currentUser() async {
    try {
      User user = await Future.value(_firebaseAuth.currentUser);
      return _userFromFirebase(user);
    } catch (e) {
      print("CURRENT USER HATA" + e.toString());
      return null;
    }
  }

  UserModel _userFromFirebase(User user) {
    if (user == null){
      return null;
    } else{
      return UserModel(userID: user.uid, email: user.email);
    }
    
  }


  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("SIGN OUT HATA" + e.toString());
      return false;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
        UserCredential authResult =
            await _firebaseAuth.signInWithCredential(credential);
        User user = authResult.user;
        return _userFromFirebase(user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await credential.user.sendEmailVerification();
    return null;
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (credential.user.emailVerified) {
      return _userFromFirebase(credential.user);
    } else
      return null;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}