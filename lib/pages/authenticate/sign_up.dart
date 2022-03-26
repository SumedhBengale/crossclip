import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:crossclip/hive_store.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';

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
    if (Platform.isWindows) {
      return Builder(
          builder: (context) => Scaffold(
              key: _key,
              body: Column(children: [
                WindowTitleBarBox(
                    child: Row(
                  children: [
                    Expanded(
                      child: MoveWindow(),
                    ),
                    const WindowButtons()
                  ],
                )),
                Expanded(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          )),
                      Text(
                        "Cross Clip",
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
                      SizedBox(
                          width: 800,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validateEmail,
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow)),
                                  hintText: 'Enter your Email',
                                ),
                              ))),
                      SizedBox(
                          width: 800,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validatePassword,
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow)),
                                  hintText: 'Enter your Password',
                                ),
                              ))),
                      SizedBox(
                          width: 800,
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: confirmPassword,
                                controller: passwordController1,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow)),
                                  hintText: 'Confirm your Password',
                                ),
                              ))),
                      Container(
                        child: SizedBox(
                            width: 800,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.yellow),
                                  ),
                                  onPressed: () async {
                                    if (passwordController.text ==
                                        passwordController1.text) {
                                      var status = 'yes';
                                      print(emailController.text);
                                      print(passwordController.text);
                                      try {
                                        await FirebaseAuth.instance.signUp(
                                            emailController.text.trim(),
                                            passwordController.text);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.fixed,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.yellow),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                          content: Text(
                                            'Sign Up Error: Something went wrong, please check your network',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ));
                                        status = 'no';
                                      }
                                      if (status == 'yes') {
                                        print("Signed in");
                                        var auth = FirebaseAuth(
                                            'AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM',
                                            await HiveStore.create());
                                        var firestore = Firestore(
                                            'cross-clip-2714',
                                            auth: FirebaseAuth.instance);
                                        var users =
                                            firestore.collection('users');
                                        users
                                            .document(
                                                FirebaseAuth.instance.userId)
                                            .set({
                                              'text_clipboard': [],
                                              'media_clipboard': []
                                            })
                                            .then((value) => print(
                                                "Clipboard sucessfully created"))
                                            .catchError((error) => print(
                                                "Failed to create clipboard: $error"));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()),
                                        );
                                      } else {}
                                    }
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
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
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
                      )
                    ])))
              ])));
    } else {
      return Builder(
          builder: (context) => Scaffold(
              key: _key,
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        )),
                    Text(
                      "Cross Clip",
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
                    SizedBox(
                        width: 800,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.yellow)),
                                hintText: 'Enter your Email',
                              ),
                            ))),
                    SizedBox(
                        width: 800,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validatePassword,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.yellow)),
                                hintText: 'Enter your Password',
                              ),
                            ))),
                    SizedBox(
                        width: 800,
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: confirmPassword,
                              controller: passwordController1,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.yellow)),
                                hintText: 'Confirm your Password',
                              ),
                            ))),
                    Container(
                      child: SizedBox(
                          width: 800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.yellow),
                                ),
                                onPressed: () async {
                                  if (passwordController.text ==
                                      passwordController1.text) {
                                    var status = 'yes';
                                    print(emailController.text);
                                    print(passwordController.text);
                                    try {
                                      await FirebaseAuth.instance.signUp(
                                          emailController.text.trim(),
                                          passwordController.text);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side:
                                              BorderSide(color: Colors.yellow),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        content: Text(
                                          'Sign Up Error: Something went wrong, please check your network',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ));
                                      status = 'no';
                                    }
                                    if (status == 'yes') {
                                      print("Signed in");
                                      var auth = FirebaseAuth(
                                          'AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM',
                                          await HiveStore.create());
                                      var firestore = Firestore(
                                          'cross-clip-2714',
                                          auth: FirebaseAuth.instance);
                                      var users = firestore.collection('users');
                                      users
                                          .document(
                                              FirebaseAuth.instance.userId)
                                          .set({
                                            'text_clipboard': [],
                                            'media_clipboard': []
                                          })
                                          .then((value) => print(
                                              "Clipboard sucessfully created"))
                                          .catchError((error) => print(
                                              "Failed to create clipboard: $error"));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                      );
                                    } else {}
                                  }
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
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
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
                    )
                  ])))));
    }
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
    return null;
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
    return null;
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
