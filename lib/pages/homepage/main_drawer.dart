import 'package:firedart/auth/firebase_auth.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:crossclip/main.dart';

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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const ChangeDirectory();
                        }),
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
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: Text(
                    //     selectedDirectory.toString(),
                    //     style: const TextStyle(color: Colors.black),
                    //   ),
                    // ),
                  ]))),
      const Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Text(
            "Note:Make sure to Sign In with the same Account in all devices using Crossclip",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
    ]);
  }
}

class ChangeDirectory extends StatefulWidget {
  const ChangeDirectory({Key? key}) : super(key: key);

  @override
  _ChangeDirectoryState createState() => _ChangeDirectoryState();
}

class _ChangeDirectoryState extends State<ChangeDirectory> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  "Current Directory",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(selectedDirectory.toString())),
            Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 15),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow),
                    ),
                    onPressed: () async => {
                          selectedDirectory =
                              await FilePicker.platform.getDirectoryPath(),
                          setState(() {}),
                          if (selectedDirectory == null)
                            {
                              selectedDirectory =
                                  '/storage/emulated/0/CrossClip'
                            },
                          Navigator.pop(context)
                        },
                    child: const Text("Change Directory",
                        style: TextStyle(color: Colors.black))))
          ],
        ));
  }
}
