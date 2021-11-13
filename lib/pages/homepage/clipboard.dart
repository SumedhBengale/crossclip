import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clipboard extends StatefulWidget {
  const Clipboard({Key? key}) : super(key: key);

  @override
  _ClipboardState createState() => _ClipboardState();
}

class _ClipboardState extends State<Clipboard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: documentStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text("Loading");
        }
        var userDocument = snapshot.data!;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: userDocument['text_clipboard'].length,
            itemBuilder: (context, index) {
              return ListTile(
                  title:
                      Text(userDocument['text_clipboard'][index].toString()));
            });
      },
    );
  }
}
