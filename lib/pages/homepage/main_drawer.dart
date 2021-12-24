import 'package:firedart/auth/firebase_auth.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String? selectedDirectory = '';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(0.0), children: [
      const SizedBox(
          height: 118.0,
          child: DrawerHeader(
            decoration: BoxDecoration(color: Colors.yellow),
            padding: EdgeInsets.all(20),
            child: ListTile(
                leading: Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )),
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
                    FirebaseAuth.instance.signOut(),
                    Navigator.pushReplacement(
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
                    selectedDirectory =
                        await FilePicker.platform.getDirectoryPath(),
                    setState(() {}),
                    if (selectedDirectory == null) {}
                  },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                        Text(
                          "Change Download Path",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        selectedDirectory.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ]))),
      const Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Text(
            "Note:Make sure to Sign In with the same Email Id in all devices using Crossclip",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    ]);
  }
}
