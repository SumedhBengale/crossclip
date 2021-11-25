import 'package:crossclip/pages/homepage/text/text_clipboard_add_page.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:clipboard/clipboard.dart';
import 'package:crossclip/main.dart';

var val = [];

class TextClipboard extends StatefulWidget {
  const TextClipboard({Key? key}) : super(key: key);

  @override
  _TextClipboardState createState() => _TextClipboardState();
}

class _TextClipboardState extends State<TextClipboard> {
  var auth =
      FirebaseAuth('AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM', VolatileStore());
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    var documentStream = firestore.collection('users').document(uid).stream;
    var documentRef = firestore.collection('users').document(uid);
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: documentStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              print(snapshot);
              print('UID:$uid');
              print(auth.apiKey);
              return const Loading();
            }
            var userDocument = snapshot.data!;
            val = userDocument['text_clipboard'].toList();
            return ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 20, bottom: 20),
                scrollDirection: Axis.vertical,
                itemCount: userDocument['text_clipboard'].length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
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
                            'Deleted from Clipboard',
                            style: TextStyle(color: Colors.black),
                          ),
                        ));

                        val.remove(
                            userDocument['text_clipboard'][index].toString());
                        documentRef.update({'text_clipboard': val});
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            userDocument['text_clipboard']
                                                    [index]
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis),
                                      ]),
                                  trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.yellow),
                                          ),
                                          onPressed: () => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              duration: Duration(seconds: 1),
                                              behavior: SnackBarBehavior.fixed,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.yellow),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              content: Text(
                                                'Copied to Clipboard',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            )),
                                            FlutterClipboard.copy(userDocument[
                                                        'text_clipboard'][index]
                                                    .toString())
                                                .then((value) => {})
                                          },
                                          child: const Icon(
                                            Icons.copy,
                                            color: Colors.black,
                                          ),
                                        )
                                      ])))));
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.yellow,
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return const TextClipboardAddPage();
              }),
          label: const Text(
            'Add to Clipboard',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.black),
        ));
  }
}
