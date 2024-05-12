import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hw3/Screens/addPost.dart';
import 'package:hw3/Screens/home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _show = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home(user: authResult)),
          (route) => false,
        );
        return authResult.user;
      } else {
        return null;
      }
    } catch (error) {
      print("Error Signingin in with google $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _signInWithGoogle,
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
