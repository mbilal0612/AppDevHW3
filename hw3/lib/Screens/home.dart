import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("None"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text("Hey"), Text("Hamza Faisal")],
            ),
            Row(
              children: [Text("Start by exploring resources")],
            ),

            //search bar
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
