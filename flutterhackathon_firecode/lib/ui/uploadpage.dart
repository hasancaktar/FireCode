import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/loginbutton.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _photo1;
  File _photo2;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Fotoğraf Yükle',
              style: Theme.of(context).textTheme.headline6),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.camera,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Fotoğraflar"),
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [
                      GestureDetector(
                        onTap: () => photoShot1(context),
                        child: Container(
                          color: Colors.black12,
                          child: _photo1 == null
                              ? Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.black,
                                )
                              : Image.file(_photo1,fit: BoxFit.fill,),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>photoShot2(context),
                        child: Container(
                            color: Colors.black12,
                            child: _photo2 == null
                                ? Icon(FontAwesomeIcons.plus,
                                    color: Theme.of(context).primaryColor)
                                : Image.file(_photo2,fit: BoxFit.fill,)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                            child: Text("Önce",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0))),
                        Center(
                            child: Text("Sonra",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)))
                      ],
                    ),
                  ),
                  SocialLoginButton(
                    buttonText: "Yükle",
                    buttonColor: Colors.orange,
                    onPressed: () {
                      if (_photo1 == null || _photo2 == null) {
                        PlatformAlertDialog(
                                title: "Geçersiz İşlem",
                                content: "Fotoğraf Boş Olamaz",
                                mainaction: "Tamam")
                            .show(context);
                      } else {
                        uploadFile(context);
                      }
                    },
                    buttonIcon: Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future photoShot1(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 160,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Kamera ile Çek"),
                    onTap: () {
                      _cameraPhotoTake1();
                    }),
              ],
            ),
          );
        });
  }

  void _cameraPhotoTake1() async {
    var _newPhoto = await _picker.getImage(source: ImageSource.camera);
    
   

    // var bytes =await _newPhoto.readAsBytes();
    
    // var tags = await readExifFromBytes(bytes);
    
    // tags.forEach((key, value) => print("$key : $value"));
    setState(() {
      _photo1 = File(_newPhoto.path);
      Navigator.of(context).pop();
    });
  }

  Future photoShot2(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 160,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Kamera ile Çek"),
                    onTap: () {
                      _cameraPhotoTake2();
                    }),
              ],
            ),
          );
        });
  }

  void _cameraPhotoTake2() async {
    var _newPhoto = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _photo2 = File(_newPhoto.path);
      Navigator.of(context).pop();
    });
  }

  void uploadFile(BuildContext context) async {
    List<File> images=[];
    final _userViewModel = Provider.of<ViewModel>(context, listen: false);
    if (_photo1 != null && _photo2 != null) {
      images.add(_photo1);
      images.add(_photo2);
      for (var i = 0; i < images.length; i++) {
        var url = await _userViewModel.uploadFile(
            _userViewModel.userModel.userID, "nature_photo_$i", images[i]);
      }
    }
  }

}
