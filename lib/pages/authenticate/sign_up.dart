import 'package:crossclip/pages/authenticate/auth_services.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
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
                        onPressed: () async {
                          if (passwordController.text ==
                              passwordController1.text) {
                            print(emailController.text);
                            print(passwordController.text);
                            await emailSignUp(
                                emailController.text, passwordController.text);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                          var auth = FirebaseAuth(
                              'AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM',
                              VolatileStore());
                          var firestore = Firestore('cross-clip-2714',
                              auth: FirebaseAuth.instance);
                          var users = firestore.collection('users');
                          users
                              .document(FirebaseAuth.instance.userId)
                              .set(
                                  {'text_clipboard': [], 'media_clipboard': []})
                              .then((value) =>
                                  print("Clipboard sucessfully created"))
                              .catchError((error) =>
                                  print("Failed to create clipboard: $error"));
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
