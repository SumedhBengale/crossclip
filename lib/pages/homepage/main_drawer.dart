import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!.email;
    return ListView(padding: const EdgeInsets.all(0.0), children: [
      SizedBox(
          height: 114.0,
          child: DrawerHeader(
            decoration: const BoxDecoration(color: Colors.yellow),
            child: ListTile(leading: Text('$user')),
          )),
      Card(
          margin: const EdgeInsets.all(10),
          elevation: 0.0,
          color: Colors.white,
          child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(15))),
                overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async => {
                    await FirebaseAuth.instance.signOut(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    )
                  },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  Text(
                    "Sign Out",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )
                ],
              ))),
      const Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Text(
            "Note:Make sure to Sign In with the same Id in all devices using Crossclip",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    ]);
  }
}
