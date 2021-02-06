import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/loginbutton.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/exceptions.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/ui/login/emailpassword.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: size.width,
        height: size.height,
        // padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
           /* Positioned(
                child: Container(
              child: 
              
              FlareActor(
                "assets/Moody.flr",
                fit: BoxFit.cover,
                isPaused: false,
                shouldClip: true,
                animation: "mood",
              ),
            )),*/
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Oturum Açın",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black)
                    ),
                    SizedBox(height: 8),
                    SocialLoginButton(
                      buttonText: "E-posta ile Giriş Yap",
                      buttonColor: Colors.orange,
                      onPressed: () => _emailandpassword(context),
                      buttonIcon: Icon(Icons.mail),
                    ),
                    SocialLoginButton(
                      buttonText: "Gmail ile Giriş Yap",
                      buttonColor: Colors.teal,
                      onPressed: () => _googleSign(context),
                      buttonIcon: Icon(FontAwesomeIcons.google),
                    ),
                   // Text("${window.devicePixelRatio}")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _googleSign(BuildContext context) async {
    try{
      final _userviewmodel = Provider.of<ViewModel>(context, listen: false);
    UserModel _user = await _userviewmodel.signInWithGoogle();
    if (_user != null) {
      print('Oturum açan user id: ' + _user.userID.toString());
    }
    }on FirebaseAuthException catch (e){
      print("GOOGLE_SIGN_IN HATA :  " + Exceptions.show(e.code));
        PlatformAlertDialog(
                title: "Google Hatası !!!",
                content: Exceptions.show(e.code),
                mainaction: "Tamam")
            .show(context);
    }
    
  }

  void _emailandpassword(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(fullscreenDialog: true, builder: (context) => EmailandPassword()));
  }
}