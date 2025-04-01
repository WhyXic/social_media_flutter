import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/*

The class has two instance variables: _storage and _auth, which are instances of FirebaseStorage and FirebaseAuth, respectively.
The class has one method:
uploadImageToStorage: Uploads an image to Firebase Storage and returns the download URL of the uploaded image. It takes three parameters: childName (the name of the storage location), file (the image file to upload), and isPost (a boolean flag whose purpose is not clear from this code snippet).


 */
class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
