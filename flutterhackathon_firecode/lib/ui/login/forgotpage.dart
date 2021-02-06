import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/loginbutton.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/exceptions.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  String _email;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<ViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifremi Unuttum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    errorText: _userviewmodel.emailErrorMessage != null
                        ? _userviewmodel.emailErrorMessage
                        : null,
                    prefixIcon: Icon(FontAwesomeIcons.envelope),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 8.0,
              ),
              SocialLoginButton(
                  buttonText: "Gönder",
                  buttonColor: Theme.of(context).primaryColor,
                  radius: 10,
                  onPressed: () async {
                    _formKey.currentState.save();
                    debugPrint(_email);
                    try {
                      if (_email != null) {
                        await _userviewmodel.resetPassword(_email);

                        Future.delayed(Duration(milliseconds: 10), () {
                          Navigator.of(context).pop();
                          PlatformAlertDialog(
                              title: "Şifre Sıfırlama !!!",
                              content: "E-posta adresinize şifre sıfırlama talimatı yönlendirildi",
                              mainaction: "Tamam")
                          .show(context);
                         
                        });
                      } else {
                        PlatformAlertDialog(
                              title: "Şifre Sıfırlama !!!",
                              content: "Bir adres girmediniz",
                              mainaction: "Tamam")
                          .show(context);
                      }
                    } on FirebaseAuthException catch (e) {
                      debugPrint(
                          "FORGET_PASSWORD HATA : " + Exceptions.show(e.code));
                      PlatformAlertDialog(
                              title: "Şifre Sıfırlanırken Hata !!!",
                              content: Exceptions.show(e.code),
                              mainaction: "Tamam")
                          .show(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}