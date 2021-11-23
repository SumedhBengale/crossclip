import 'package:r_get_ip/r_get_ip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossclip/main.dart';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:crossclip/pages/homepage/main_drawer.dart' as drawer;
import 'client.dart';
import 'server.dart';

class MediaClipboard extends StatefulWidget {
  const MediaClipboard({Key? key}) : super(key: key);

  @override
  _MediaClipboardState createState() => _MediaClipboardState();
}

class _MediaClipboardState extends State<MediaClipboard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  String? get downloadPath => drawer.selectedDirectory;
  void fetchFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withReadStream: true);
    if (result != null) {
      final file = result.files.first;
      print(file.name);
      print(file.size);
      print(file.extension);
      final ipAddress = await RGetIp.internalIP;
      print(await ipAddress);
      startServer(file, ipAddress!);
      sendToClipboard(file.name);
    } else {
      // User canceled the picker
    }
  }

  void recieveFile(
      String ipAddress, String fileName, String downloadPath) async {
    startClient(ipAddress, fileName, downloadPath);
  }

  void sendToClipboard(String fileName) async {
    var list = [];
    list.add({
      'file_name': fileName,
    });
    documentReference.update({'media_clipboard': FieldValue.arrayUnion(list)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<DocumentSnapshot>(
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
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 20, bottom: 20),
                scrollDirection: Axis.vertical,
                itemCount: userDocument['media_clipboard'].length,
                itemBuilder: (context, index) {
                  String ipAddress;
                  String fileName;
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
                                        userDocument['media_clipboard'][index]
                                                ['file_name']
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
                                        ipAddress =
                                            userDocument['media_clipboard']
                                                    [index]['ip_address']
                                                .toString(),
                                        fileName =
                                            userDocument['media_clipboard']
                                                    [index]['file_name']
                                                .toString(),
                                        recieveFile(
                                            ipAddress, fileName, downloadPath!),
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
                                            'Downloading File',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )),
                                      },
                                      child: const Icon(
                                        Icons.download,
                                        color: Colors.black,
                                      ),
                                    )
                                  ]))));
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.yellow,
          onPressed: () => {fetchFile()},
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

Widget _buildIpWidget(BuildContext context, AsyncSnapshot<String?> snapshot) {
  return Text(
    '${snapshot.hasData ? snapshot.data : "0.0.0.0"}',
    style: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
  );
}
