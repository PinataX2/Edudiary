import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:my_project/Methods/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Upload Posts
  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username, //email
      String profImage,
      String Yearbookid) async {
    String res = '';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();

      _firestore.collection('posts').doc(postId).set({
        'description': description,
        'uid': uid,
        'username': username,
        'postId': postId,
        'datepublised': DateTime.now(),
        'postUrl': photoUrl,
        'profImage': profImage,
        'likes': [],
        'yearbookId': Yearbookid,
      });
    } catch (e) {
      res = e.toString();
      print(e);
    }
    return res;
  }
}
