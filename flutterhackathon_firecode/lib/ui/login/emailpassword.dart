import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/loginbutton.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/exceptions.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/ui/login/forgotpage.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum FormType { Register, LogIn }

class EmailandPassword extends StatefulWidget {
  @override
  _EmailandPasswordState createState() => _EmailandPasswordState();
}

class _EmailandPasswordState extends State<EmailandPassword> {

  String _email, _sifre;
  String _buttonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    _buttonText = _formType == FormType.LogIn ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LogIn
        ? "Hesabınız Yok Mu? Hemen Kayıt Olun!"
        : "Hesabınız Var Mı? Giriş Yapın!";

    final _userviewmodel = Provider.of<ViewModel>(context);

    if (_userviewmodel.userModel != null) {
      Future.delayed(Duration(milliseconds: 10), () {
        Navigator.of(context).popUntil(ModalRoute.withName("/"));
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text("Giriş/Kayıt")),
        body: _userviewmodel.viewState == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) => _email = value.trim(),
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
                    TextFormField(
                        obscureText: true,
                        onSaved: (String value) => _sifre = value.trim(),
                        decoration: InputDecoration(
                          errorText: _userviewmodel.passwordErrorMessage != null
                              ? _userviewmodel.passwordErrorMessage
                              : null,
                          prefixIcon: Icon(FontAwesomeIcons.key),
                          hintText: "Şifre",
                          labelText: "Şifre",
                          border: OutlineInputBorder(),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    SocialLoginButton(
                      buttonText: _buttonText,
                      buttonColor: Theme.of(context).primaryColor,
                      radius: 10,
                      onPressed: () => _formSubmit(),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _formType == FormType.LogIn
                                ? Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ForgotPasswordPage()));
                                            },
                                            child: Text(
                                              "Şifremi Unuttum",
                                              style: TextStyle(
                                                  color: Colors.red),
                                            )),
                                      ],
                                    ),
                                  )
                                : Container(),
                            TextButton(
                                onPressed: () => _changeState(),
                                child: Text(_linkText,style: TextStyle(color:Colors.green[700]),)),
                          ]),
                    ),
                  ]),
                ),
              ))
            : Center(
                child: CircularProgressIndicator(),
              )
    );
  }
  void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("e_mail: " + _email + " şifre: " + _sifre);
    final _userviewmodel = Provider.of<ViewModel>(context, listen: false);
    if (_formType == FormType.LogIn) {
      try {
        UserModel _loggeduser =
            await _userviewmodel.signInWithEmailandPassword(_email, _sifre).catchError((onError){
              FirebaseAuthException e=onError;
              return PlatformAlertDialog(
                title: "Kullanıcı Girişi Hatası",
                content: Exceptions.show(e.code),
                mainaction: "Tamam")
            .show(context);
            });
        if (_loggeduser != null) {
          print('Oturum açan user id: ' + _loggeduser.userID.toString());
        }
      } on FirebaseAuthException catch (e) {
        debugPrint("SIGN_IN_EMAIL HATA : " + Exceptions.show(e.code));
        PlatformAlertDialog(
                title: "Kullanıcı Girişi Hatası",
                content: Exceptions.show(e.code),
                mainaction: "Tamam")
            .show(context);
      }
    } else {
      try {
        UserModel _createduser = await _userviewmodel
            .createUserWithEmailandPassword(_email, _sifre);
            
        if (_createduser != null) {
          print("Oturum açan user id" + _createduser.userID.toString());
        }
        PlatformAlertDialog(
                  title: "E-postanızı kontrol edin!",
                  content: "E-postanıza onay maili gönderildi.",
                  mainaction: "Tamam").show(context);
      } on FirebaseAuthException catch (e) {
        print("CREATE_USER HATA :  " + Exceptions.show(e.code));
        PlatformAlertDialog(
                title: "Kullanıcı Kayıt Hata !!!",
                content: Exceptions.show(e.code),
                mainaction: "Tamam")
            .show(context);
      }
    }
  }

  void _changeState() {
    setState(() {
      _formType =
          _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    });
  }
}