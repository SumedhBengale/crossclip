import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
                  backgroundColor: Colors.white,
                  drawer: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                    child: Drawer(
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
                  ),
                  appBar: AppBar(
                    centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.white),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    )),
                    backgroundColor: Colors.yellow,
                    title: const Text(
                      "CrossClip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  body: Clipboard(),
                )));
  }
}
