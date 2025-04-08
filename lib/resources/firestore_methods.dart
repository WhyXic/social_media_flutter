import 'dart:typed_data';
import 'package:instagram_clone/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

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
      String postId = const Uuid().v1();
      String photoUrl =
          await StorageMethods().uploadImageToStorage('postImage', file, true);
      Post post = Post(
        description: description,
        uid: uid,
        postId: postId,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'Success';
      return res;
    } catch (e) {
      return res;
    }
  }
}
