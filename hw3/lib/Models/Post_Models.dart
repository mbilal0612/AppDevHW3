import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String name;
  final String profilepic;

  final String title;
  final String desc;
  final DateTime createdAt;

  Post(
      {required this.id,
      required this.name,
      required this.title,
      required this.desc,
      required this.createdAt,
      required this.profilepic});

  // static fromQuerySnapshot2(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  //   return Post(
  //       id: doc.id,
  //       name: doc['name'] as String,
  //       title: doc['title'] as String,
  //       desc: doc['desc'] as String,
  //       profilepic: doc['profilepic'] as String,
  //       createdAt: doc['createdAt'] as DateTime);
  // }

  static Post fromQuerySnapshot(QueryDocumentSnapshot doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Post(
        id: doc.id,
        name: json['name'] as String,
        title: json['title'] as String,
        desc: json['desc'] as String,
        profilepic: json['profilepic'] as String,
        createdAt: (json['createdAt'] as Timestamp).toDate());
  }
}
