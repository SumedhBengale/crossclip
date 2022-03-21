import 'package:crossclip/about.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firedart.dart';
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
                  ]))),
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
                          return const ChangePassword();
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
                          Icons.password,
                          color: Colors.black,
                        ),
                        Text(
                          "Change Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ]))),
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
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => const About()))
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
                          Icons.info,
                          color: Colors.black,
                        ),
                        Text(
                          "About",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ]))),
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
                          return const DeleteAccount();
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
                          Icons.delete_forever,
                          color: Colors.black,
                        ),
                        Text(
                          "Delete Account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ]))),
      const Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Text(
            "Sign In with the same Account in all your devices",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      const Card(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Text(
            "Devices should be connected to the same WIFI/Local Network",
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
                              selectedDirectory = '/storage/emulated/0/Download'
                            },
                          Navigator.pop(context)
                        },
                    child: const Text("Change Directory",
                        style: TextStyle(color: Colors.black))))
          ],
        ));
  }
}

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text(
                      "Are you Sure?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Center(
                        child: Text(
                      "You cannot undo this",
                    ))),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () async => {
                              await Firestore('cross-clip-2714',
                                      auth: FirebaseAuth.instance)
                                  .collection('users')
                                  .document(FirebaseAuth.instance.userId)
                                  .delete(),
                              FirebaseAuth.instance.deleteAccount(),
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                              )
                            },
                        child: const Text("Delete Permanently",
                            style: TextStyle(color: Colors.black))))
              ],
            )));
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final newPassword = TextEditingController();
    final newPasswordConfirm = TextEditingController();

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

    String? confirmPassword(String? value) {
      // ignore: unrelated_type_equality_checks
      if (value != newPassword.text) {
        return 'Passwords do not match';
      } else {
        return null;
      }
    }

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 16,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Text(
                      "Change Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validatePassword,
                      controller: newPassword,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow)),
                        hintText: 'Enter new Password',
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: TextFormField(
                      controller: newPasswordConfirm,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: confirmPassword,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow)),
                        hintText: 'Confirm Password',
                      ),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow),
                        ),
                        onPressed: () => {
                              if (newPassword.text == newPasswordConfirm.text)
                                {
                                  FirebaseAuth.instance
                                      .changePassword(newPassword.text)
                                },
                              FirebaseAuth.instance.signOut(),
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
                                  'Password Changed',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn())),
                            },
                        child: const SizedBox(
                            height: 20,
                            width: double.infinity,
                            child: Text(
                              "Add to Clipboard",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ))))
              ],
            )));
  }
}
