import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> emailSignUp(email, password, key) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      key.currentState.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        content: Text(
          'Your password is too weak',
          style: TextStyle(color: Colors.black),
        ),
      ));
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      key.currentState.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        content: Text(
          'Account already exists for that Email',
          style: TextStyle(color: Colors.black),
        ),
      ));
    }
  } catch (e) {
    const Errors();
  }
}

Future<void> emailSignIn(email, password, key) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      key.currentState.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        content: Text(
          'User not found',
          style: TextStyle(color: Colors.black),
        ),
      ));
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      key.currentState.showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        content: Text(
          'Wrong password',
          style: TextStyle(color: Colors.black),
        ),
      ));
    }
  }
}

class Errors extends StatefulWidget {
  const Errors({Key? key}) : super(key: key);

  @override
  _ErrorsState createState() => _ErrorsState();
}

class _ErrorsState extends State<Errors> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(),
    ));
  }
}
