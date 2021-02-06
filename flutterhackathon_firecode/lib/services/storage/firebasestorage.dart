import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterhackathon_firecode/services/storage/storagebase.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference _storageReference;
  @override
  Future<String> uploadFile(
      String userID, String fileType, File document) async {
    _storageReference = _firebaseStorage
        .ref()
        .child(userID)
        .child(fileType)
        .child("nature_photo");
    UploadTask uploadTask = _storageReference.putFile(document);
    var url = await uploadTask.then((a) => a.ref.getDownloadURL());
    return url;
  }
}
