import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'clipboard.dart';

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
                  drawer: Drawer(
                    child: ListView(children: [
                      OutlinedButton(
                        onPressed: () async => {
                          await FirebaseAuth.instance.signOut(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()),
                          )
                        },
                        child: const Text("Sign Out"),
                      ),
                      Text(FirebaseAuth.instance.currentUser!.uid)
                    ]),
                  ),
                  appBar: AppBar(
                    title: const Text("CrossClip"),
                  ),
                  body: const Clipboard(),
                )));
  }
}
