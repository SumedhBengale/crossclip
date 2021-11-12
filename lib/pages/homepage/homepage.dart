import 'package:crossclip/pages/authnticate/auth_services.dart';
import 'package:crossclip/pages/authnticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("CrossClip"),
        ),
        body: OutlinedButton(
          onPressed: () async => {
            await FirebaseAuth.instance.signOut(),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            )
          },
          child: const Text("Sign Out"),
        ),
      ),
    ));
  }
}
