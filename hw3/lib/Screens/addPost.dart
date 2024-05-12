import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw3/Screens/home.dart';

class AddPost extends StatefulWidget {
  final UserCredential user;
  const AddPost({super.key, required this.user});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  void _addPost() async {
    print(widget.user);
    try {
      await firestore.collection('posts').add({
        'name': '${widget.user.user?.displayName}',
        'title': titleController.text,
        'desc': descController.text,
        'createdAt': DateTime.now(),
        'profilepic': '${widget.user.user?.photoURL}',
      });
      print('Data added successfully!');
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 200,
              width: 150,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 12.0, left: 10.0, right: 10.0),
              child: TextField(
                  controller: titleController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 90.0, left: 10.0, right: 10.0),
                child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ))),
            // Padding(
            //     padding:
            //         const EdgeInsets.only(bottom: 90.0, left: 10.0, right: 10.0),
            //     child: TextField(
            //         controller: descController,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           labelText: 'Description',
            //         ))),
            ElevatedButton(onPressed: _addPost, child: const Text("Submit")),
          ],
        ),
      ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(user: widget.user)),
              (route) => false);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
