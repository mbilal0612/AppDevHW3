import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hw3/models/Post_Models.dart';

// class PostService {
//   Future<List<Post>> fetchPosts() async {
//     final query = FirebaseFirestore.instance.collection("posts");

//     final snapshots = await query.get();

//     //mapping

//     final posts = snapshots.docs.map((e) => fromQuerySnapshot2(e)).toList();

//     return null;
//   }
// }

class PostService {
  Future<List<Post>> fetchPostsByEmail(String email) async {
    final query = FirebaseFirestore.instance
        .collection("tiles-hw3")
        .where("email", isEqualTo: email);

    final snapshots = await query.get();

    final List<Post> posts = snapshots.docs
        .map((e) => Post(
            id: e.id,
            name: e.data()['name'] as String,
            title: e.data()['title'] as String,
            desc: e.data()['desc'] as String,
            profilepic: e.data()['profilepic'] as String,
            createdAt: e.data()['createdAt'] as DateTime))
        .toList();
    // final List<Post> posts =
    //     snapshots.docs.map((e) => Post.fromQuerySnapshot(e)).toList();
    return posts;
  }
}
