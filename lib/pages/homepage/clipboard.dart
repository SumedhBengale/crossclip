import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clipboard/clipboard.dart';
import 'package:crossclip/main.dart';

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
          return const Loading();
        }
        var userDocument = snapshot.data!;
        return ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
            scrollDirection: Axis.vertical,
            itemCount: userDocument['text_clipboard'].length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    var val = [];
                    val.add(userDocument['text_clipboard'][index].toString());
                    documentReference.update(
                        {'text_clipboard': FieldValue.arrayRemove(val)});

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                        'Deleted from Clipboard',
                        style: TextStyle(color: Colors.black),
                      ),
                    ));
                  },
                  background: Container(color: Colors.white),
                  child: Card(
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
                                      onPressed: () => {
                                        FlutterClipboard.copy(
                                                userDocument['text_clipboard']
                                                        [index]
                                                    .toString())
                                            .then((value) => {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    behavior:
                                                        SnackBarBehavior.fixed,
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors.yellow),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    content: Text(
                                                      'Copied to Local Clipboard',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ))
                                                })
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        color: Colors.black,
                                      ),
                                    )
                                  ])))));
            });
      },
    );
  }
}
