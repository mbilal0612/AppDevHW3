import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw3/Screens/home.dart';

class EditPost extends StatefulWidget {
  final UserCredential user;
  final data;
  const EditPost({super.key, required this.user, required this.data});

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    var snapshot = widget.data.data();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final TextEditingController nameController = TextEditingController();
    var titleController = TextEditingController(text: snapshot['title']);
    var descController = TextEditingController(text: snapshot['desc']);
    var _scaffoldKey = GlobalKey<ScaffoldState>();

    void _EditPost() async {
      print(widget.user);
      try {
        await firestore.collection('posts').doc(widget.data.id).update({
          'name': '${widget.user.user?.displayName}',
          'title': titleController.text,
          'desc': descController.text,
          'createdAt': DateTime.now(),
          'profilepic': '${widget.user.user?.photoURL}',
          'createdBy': '',
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Data editted Sucessfully"),
          backgroundColor: Colors.green,
        ));
        // _(
        //   const SnackBar(
        //     content: Text("Data added Sucessfully"),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        print('Data edited successfully!');

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home(user: widget.user)),
            (route) => false);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There was an error"),
          backgroundColor: Colors.red,
        ));
        print('Error adding data: $e');
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Edit Post"),
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
            ElevatedButton(onPressed: _EditPost, child: const Text("Submit")),
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
