import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/helper/posts.dart';

class AddPostRepo {
  AddPostRepo();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addPost(Post post) async {
    await firestore.collection('posts').add(post.toJSON());
  }
}
