import 'package:crossclip/pages/authnticate/auth_services.dart';
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
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
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
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Email',
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Password',
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            controller: passwordController1,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Confirm your Password',
                            ),
                          )),
                      OutlinedButton(
                        onPressed: () {
                          if (passwordController.text ==
                              passwordController1.text) {
                            print(emailController.text);
                            print(passwordController.text);
                            emailSignUp(
                                emailController.text, passwordController.text);
                          }
                          FirebaseAuth.instance.authStateChanges().listen(
                            (User? user) {
                              if (user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              }
                            },
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  )),
                )));
  }
}
