import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/post.dart'; // imports posts model (contains class post) which allows us to add it to db.
import 'package:cloud_firestore/cloud_firestore.dart'; // imports cloud firestore.
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart'; // for generating uuids for new posts.

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String description,
    String uid,
    Uint8List file,
    String username,
    String profImage,
  ) async {
    String res = 'Some error occoured';
    try {
      String postId = const Uuid().v1(); // makes post id.
      String photoUrl =
          await StorageMethods().uploadImageToStorage('postImage', file, true); // uploads to firebase storage and returns its link.
      Post post = Post(
        description: description,
        uid: uid,
        postId: postId,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      ); // makes a post instance with variables from where the function is called.
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'Success';
      return res;
    } catch (e) {
      return res;
    }
  }

  Future<void> likePost(String postId, String uid, List likes) async { // adds/removes uid of current user to likes array in db.
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
// posts a comment, with random uid, on a post matching the same uid we pass as a parameter. 
  // posts/[postId]/comments/[commentId]; 
  Future<void> postComment(String postId, String text, String uid, String name, 
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'text': text,
          'uid': uid,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        // comment is empty
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async { // detes post by grabbing the post via post id.
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async { // adds user to follow list / removes the user from follow list.
    try { 
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
