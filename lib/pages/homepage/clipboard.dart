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
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
            scrollDirection: Axis.vertical,
            itemCount: userDocument['text_clipboard'].length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                      child: ListTile(
                          minVerticalPadding: 40,
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    userDocument['text_clipboard'][index]
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis),
                              ]),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.yellow),
                                  ),
                                  onPressed: () => {},
                                  child: const Icon(Icons.copy),
                                )
                              ]))));
            });
      },
    );
  }
}
