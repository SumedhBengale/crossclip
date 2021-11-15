import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:crossclip/pages/authenticate/auth_services.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<ScaffoldState>();
    return Builder(
        builder: (context) => Scaffold(
            key: _key,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )
                      ],
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[300],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validateEmail,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          hintText: 'Enter your Email',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: validatePassword,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          hintText: 'Enter your Password',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: confirmPassword,
                        controller: passwordController1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          hintText: 'Confirm your Password',
                        ),
                      )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow),
                        ),
                        onPressed: () {
                          if (passwordController.text ==
                              passwordController1.text) {
                            print(emailController.text);
                            print(passwordController.text);
                            emailSignUp(emailController.text,
                                passwordController.text, _key);
                          }
                          FirebaseAuth.instance.authStateChanges().listen(
                            (User? user) {
                              if (user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('users');
                                users
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set(
                                      {'text_clipboard': []},
                                      SetOptions(merge: true),
                                    )
                                    .then((value) =>
                                        print("Clipboard sucessfully created"))
                                    .catchError((error) => print(
                                        "Failed to create clipboard: $error"));
                              }
                            },
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  )),
                ]))));
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validatePassword(String? value) {
    if (value != null) {
      if (value.length > 5 &&
          (value.contains(RegExp(r'[A-Z]')) ||
              value.contains(RegExp(r'[a-z]'))) &&
          value.contains(RegExp(r'[0-9]'))) {
        return null;
      }
      return 'Use a combination of letters and numbers';
    }
  }

  String? confirmPassword(String? value) {
    // ignore: unrelated_type_equality_checks
    if (value != passwordController.text) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }
}
