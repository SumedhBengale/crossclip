import 'package:crossclip/pages/authenticate/sign_up.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_services.dart';

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
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In",
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
                      OutlinedButton(
                        onPressed: () {
                          print(emailController.text);
                          print(passwordController.text);
                          emailSignIn(
                              emailController.text, passwordController.text);
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
                        child: const Text('Sign In'),
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
                )));
  }
}
