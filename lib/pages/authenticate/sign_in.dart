import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crossclip/pages/authenticate/sign_up.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return MaterialApp(
          home: Builder(
              builder: (context) => Scaffold(
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
                              height: 350,
                              width: 350,
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
                                    controller: passwordController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: validatePassword,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.yellow)),
                                      hintText: 'Enter your Password',
                                    ),
                                  ))),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                            ),
                            onPressed: () async {
                              var status = 'yes';
                              print(emailController.text);
                              print(passwordController.text);
                              try {
                                await FirebaseAuth.instance.signIn(
                                    emailController.text.trim(),
                                    passwordController.text);
                              } catch (e) {
                                print(e);
                                print(emailController.text);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 1),
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
                                    'Sign In Error: Something went wrong, please check your network and credentials',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ));
                                status = 'no';
                              }
                              if (status == 'yes') {
                                print("Signed in");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              } else {}
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()),
                                );
                              },
                              child: const Text("Don't have an Account"))
                        ],
                      )),
                    )
                  ]))));
    } else {
      return MaterialApp(
          home: Builder(
              builder: (context) => Scaffold(
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
                                  controller: passwordController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: validatePassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.yellow)),
                                    hintText: 'Enter your Password',
                                  ),
                                ))),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            overlayColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.yellow),
                          ),
                          onPressed: () async {
                            var status = 'yes';
                            print(emailController.text);
                            print(passwordController.text);
                            try {
                              await FirebaseAuth.instance.signIn(
                                  emailController.text.trim(),
                                  passwordController.text);
                            } catch (e) {
                              print(e);
                              print(emailController.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
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
                                  'Sign In Error: Something went wrong, please check your network and credentials',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ));
                              status = 'no';
                            }
                            if (status == 'yes') {
                              print("Signed in");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            } else {}
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
                              );
                            },
                            child: const Text("Don't have an Account"))
                      ],
                    )),
                  ))));
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

  String? confirmEmail(String? value) {
    return null;
  }
}
