import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw3/Screens/addPost.dart';
import 'package:hw3/Screens/editPosts.dart';

class Home extends StatefulWidget {
  final UserCredential user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Home"),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // SafeArea(

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Hey ",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.user.user?.displayName}',
                        style: const TextStyle(
                            fontSize: 32,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Start by exploring resources",
                            style: TextStyle(fontSize: 16, color: Colors.grey))
                      ],
                    )),

                //search bar
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 8,
                        child: SearchBar(
                          leading: Icon(Icons.search),
                          hintText: 'Search by name',
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Card(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.filter_alt))))

                      // Expanded(
                      //   child: SearchBar(
                      //     leading: const Icon(Icons.search),
                      //     hintText: "Search by name",
                      //     trailing: [const Icon(Icons.close)],
                      //     elevation: MaterialStateProperty.all(1),
                      //     shape: MaterialStateProperty.all<OutlinedBorder>(
                      //       RoundedRectangleBorder(
                      //         side: const BorderSide(
                      //           color: Colors.transparent,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),

                const Row(
                  children: [
                    Text("Latest Uploads"),
                    Icon(Icons.electric_bolt_outlined),
                  ],
                ),

                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (BuildContext context, int index) {
                          return PostDetails(
                              data: snapshot.data!.docs[index],
                              user: widget.user);
                        }))
              ],
              // ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("No data found"));
          } else {
            return const Center(child: Text("Something's wrong"));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPost(user: widget.user)),
              (route) => false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostDetails extends StatelessWidget {
  final data;
  final user;
  const PostDetails({super.key, required this.data, required this.user});

  static String? time(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 0) return "just now";

    final seconds = difference.inSeconds;
    if (seconds < 60) {
      return '${seconds} seconds ago';
    }

    final minutes = difference.inMinutes;
    if (minutes < 60) {
      return '${minutes} minutes ago';
    }

    final hours = difference.inHours;
    if (hours < 24) {
      return '${hours} hours ago';
    }

    final days = difference.inDays;
    if (days < 7) {
      return '${days} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    var snapshot = data.data();
    return GestureDetector(
      onTap: () {
        print('data: ${data.id}');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => EditPost(user: user, data: data)),
            (route) => false);
      },
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(snapshot['profilepic']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot['name']),
                        ),
                        const Spacer(),
                        Text(time(
                            (snapshot['createdAt'] as Timestamp).toDate())!)
                      ],
                    ),
                    Text(
                      snapshot["title"],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot["desc"],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                    // Column(children: )
                  ]),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_rounded)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.heart_broken)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.comment_rounded)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
