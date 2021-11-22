import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextClipboardAddPage extends StatefulWidget {
  const TextClipboardAddPage({Key? key}) : super(key: key);

  @override
  _TextClipboardAddPageState createState() => _TextClipboardAddPageState();
}

class _TextClipboardAddPageState extends State<TextClipboardAddPage> {
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    final addToClipboard = TextEditingController();
    var list = [];
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                child: TextField(
                  controller: addToClipboard,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                    hintText: 'Enter your Email',
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow),
                    ),
                    onPressed: () => {
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
                              'Added to Clipboard',
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                          list.add(addToClipboard.text),
                          documentReference.update(
                              {'text_clipboard': FieldValue.arrayUnion(list)}),
                          Navigator.pop(context),
                        },
                    child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Add to Clipboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ))))
          ],
        ));
  }
}
