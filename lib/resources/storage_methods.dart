import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/*

The class has two instance variables: _storage and _auth, which are instances of FirebaseStorage and FirebaseAuth, respectively.
The class has one method:
uploadImageToStorage: Uploads an image to Firebase Storage and returns the download URL of the uploaded image. It takes three parameters: childName (the name of the storage location), file (the image file to upload), and isPost (a boolean flag whose purpose is not clear from this code snippet).


 */
class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance; // initalize a variable that can look at the firebase storage's instance. 
  final FirebaseAuth _auth = FirebaseAuth.instance; // initalize a variable that can look at the firebase auth's instance. 

  Future<String> uploadImageToStorage( // A Future is returned that has a primitve of String inside of it.
      String childName, Uint8List file, bool isPost) async { // it passes an image (Uint8List, isPost, and its name which is its location.).
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid); // reference to where the image should be stored which is,  
    /*
    Suppose if it is a post, then posts/[userid]/ 
    otherwise, it will be in 
    profImg/[userid]/
    */
    if (isPost) {
      String id = const Uuid().v1(); // create a random uid for the post and make that the ref.
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file); // upload the file, 

    TaskSnapshot snap = await uploadTask; // snapshot awaits the upload task, once done snap will tell us the metadata of the file.
    String downloadUrl = await snap.ref.getDownloadURL(); // get the url, of the image, which will let us use NetworkImage(), widget to display it in the ui.

    return downloadUrl;
  }
}
