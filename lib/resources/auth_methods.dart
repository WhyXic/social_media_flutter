import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart'; // import the firestore database package.
import 'package:firebase_auth/firebase_auth.dart'; // import firebase auth package.
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart'; // import the storage methods, we made earlier.
import 'package:instagram_clone/models/user.dart' as model; // contains the user class. 

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance; // saves, the auth instance to _auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // same with firestore instance. 
  // sign up
  Future<model.User> getUserDetails() async { // for returns user model we created, as a future. 
    User currentUser = _auth.currentUser!; // user is nullable as user may or may not be signed in.

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get(); // await the user from the firebase collection. 

    return model.User.fromSnap(snap); 
  }

  Future<String> signUpUser({ // take the email, passowrd, username, bio, image and pass it into the function it returns the resolution of firebase.
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occoured!'; // if res is not set again, then error
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) { // not nullable values. 
        UserCredential cred = await _auth.createUserWithEmailAndPassword( 
            email: email, password: password); // use firebase method to make a user. 

        debugPrint(cred.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false); // upload profile picture to storage, and take the photourl to store in db.
        // add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        ); // make the user model

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(), 
            ); // put the user model in the db.
        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email address is not valid.';
      } else if (err.code == 'email-already-in-use') {
        res = 'The email address is already in use by another account.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
 
  Future<String> signInUser( // same as signup but better
      {required String email, required String password}) async {
    String res = 'Some error occoured!';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async { // signs out using firebase method. 
    await _auth.signOut();
  }
}
