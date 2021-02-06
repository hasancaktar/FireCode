import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/exceptions.dart';
import 'package:flutterhackathon_firecode/ui/rewardpage.dart';
import 'package:flutterhackathon_firecode/ui/uploadpage.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _userviewmodel = Provider.of<ViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(252, 242, 239, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Ana Sayfa", style: Theme.of(context).textTheme.headline6),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.medal,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>RewardPage()));
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              onPressed: () => _confirmExit(context),
            ),
          )
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userviewmodel.userModel.email.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold, fontSize: 15.0)),
            Divider(height: 5,),
            Text("Hoşgeldin!",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 35.0)),
            Divider(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              
                  child: Text(
                "Çevreni iyileştirmek ister misin?.\nHadi başlayalım!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.announcement, size: 30),
        onPressed: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>UploadPage()));
           
        },
      ),
    );
  }

  Future _confirmExit(BuildContext context) async {
    try {
      final _result = await PlatformAlertDialog(
        title: "Emin misin?",
        content: "Çıkış yapmak üzeresin...",
        mainaction: "Çık",
        secondaction: "İptal",
      ).show(context);
      if (_result == true) {
        _logOut(context);
      }
    } on FirebaseAuthException catch (e) {
      PlatformAlertDialog(
              title: "Kullanıcı Çıkışı Hata !!!",
              content: Exceptions.show(e.code),
              mainaction: "Tamam")
          .show(context);
    }
  }

  Future<bool> _logOut(BuildContext context) async {
    final _userviewmodel = Provider.of<ViewModel>(context, listen: false);
    bool sonuc = await _userviewmodel.signOut();
    return sonuc;
  }
}
