import 'package:r_get_ip/r_get_ip.dart';
import 'package:crossclip/main.dart';
import 'package:firedart/firedart.dart';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:crossclip/pages/homepage/main_drawer.dart' as drawer;
import 'client.dart';
import 'server.dart';

var mediaArray = [];

class MediaClipboard extends StatefulWidget {
  const MediaClipboard({Key? key}) : super(key: key);

  @override
  _MediaClipboardState createState() => _MediaClipboardState();
}

class _MediaClipboardState extends State<MediaClipboard> {
  var auth =
      FirebaseAuth('AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM', VolatileStore());
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);

  String? get downloadPath => drawer.selectedDirectory;

  @override
  Widget build(BuildContext context) {
    var documentStream = firestore.collection('users').document(uid).stream;
    var documentRef = firestore.collection('users').document(uid);
    void sendToClipboard(String fileName, String ipAddress) {
      mediaArray.add({
        'fileName': fileName,
        'ipAddress': ipAddress,
      });
      documentRef.update({'media_clipboard': mediaArray});
    }

    void fetchFile() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withReadStream: true);
      if (result != null) {
        final file = result.files.first;
        print(file.name);
        print(file.size);
        print(file.extension);
        final ipAddress = await RGetIp.internalIP;
        print(ipAddress);
        startServer(file, ipAddress!);
        sendToClipboard(file.name, ipAddress);
      } else {
        // User canceled the picker
      }
    }

    void recieveFile(
        String ipAddress, String fileName, String downloadPath) async {
      startClient(ipAddress, fileName, downloadPath);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: documentStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              print(snapshot);
              return const Loading();
            }
            var userDocument = snapshot.data!;
            mediaArray = userDocument['media_clipboard'].toList();
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
                                        userDocument['media_clipboard'][0]
                                                ['fileName']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            'Shared on port- ' +
                                                userDocument['media_clipboard']
                                                        [0]['ipAddress']
                                                    .toString() +
                                                ':2714',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                            overflow: TextOverflow.ellipsis))
                                  ]),
                              trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                      onPressed: () {
                                        ipAddress =
                                            userDocument['media_clipboard'][0]
                                                    ['ipAddress']
                                                .toString();
                                        fileName =
                                            userDocument['media_clipboard'][0]
                                                    ['fileName']
                                                .toString();
                                        if (ipAddress ==
                                            RGetIp.internalIP.toString()) {
                                          recieveFile(ipAddress, fileName,
                                              downloadPath!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.fixed,
                                            backgroundColor: Color.fromARGB(
                                                255, 236, 213, 213),
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.fixed,
                                            backgroundColor: Color.fromARGB(
                                                255, 236, 213, 213),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.yellow),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                            ),
                                            content: Text(
                                              'Sender and Recever are not on the same network',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ));
                                        }
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
