import 'dart:io';
import 'package:r_get_ip/r_get_ip.dart';

import 'pickServerIP.dart';
import 'package:crossclip/main.dart' as main;
import 'package:firedart/firedart.dart';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../main.dart';
import 'client.dart';
import 'server.dart';

var mediaArray = [];
int networks = 0;
String ipAddress = "x";
String fileName = "";
var uid = FirebaseAuth.instance.userId;
var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
var documentStream = firestore.collection('users').document(uid).stream;
var documentRef = firestore.collection('users').document(uid);
List<NetworkInterface> interfaces = [];

void sendToClipboard(String fileName, String ipAddress) {
  mediaArray.add({
    'fileName': fileName,
    'ipAddress': ipAddress,
  });
  print(mediaArray);
  documentRef.update({'media_clipboard': mediaArray});
}

void recieveFile(String ipAddress, String fileName, String downloadPath, index,
    context) async {
  print("Recieving");
  startClient(ipAddress, fileName, downloadPath, index, context);
}

class MediaClipboard extends StatefulWidget {
  const MediaClipboard({Key? key}) : super(key: key);

  @override
  _MediaClipboardState createState() => _MediaClipboardState();
}

class _MediaClipboardState extends State<MediaClipboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ScrollController mediaScrollController = ScrollController();

  String? get downloadPath => main.selectedDirectory;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                controller: mediaScrollController,
                itemCount: userDocument['media_clipboard'].length,
                itemBuilder: (context, index) {
                  String ipAddress;
                  String fileName;
                  return Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 14, 13, 11)),
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

                        deleteFromClipboard(index);
                      },
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
                                            userDocument['media_clipboard']
                                                    [index]['fileName']
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis),
                                      ]),
                                  trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                          onPressed: () async {
                                            ipAddress =
                                                userDocument['media_clipboard']
                                                        [index]['ipAddress']
                                                    .toString();
                                            fileName =
                                                userDocument['media_clipboard']
                                                        [index]['fileName']
                                                    .toString();
                                            recieveFile(ipAddress, fileName,
                                                downloadPath!, index, context);
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
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ));
                                          },
                                          child: const Icon(
                                            Icons.download,
                                            color: Colors.black,
                                          ),
                                        )
                                      ])))));
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: FloatingActionButton.extended(
              heroTag: 'add_media',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.yellow,
              hoverColor: Colors.white,
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(withReadStream: true);
                if (result != null) {
                  final file = result.files.first;
                  fileName = file.name;
                  print(file.name);
                  print(file.size);
                  print(file.extension);

                  if (Platform.isWindows) {
                    interfaces = await NetworkInterface.list(
                        type: InternetAddressType.IPv4);
                    if (interfaces.length != 1) {
                      networks = interfaces.length;
                      var ip = await showDialog(
                          context: context,
                          builder: (context) {
                            return PickServerIP();
                          });
                      print(ip);
                      print(ipAddress);
                      if (ip == 'selected') {
                        startServer(file, ipAddress);
                        sendToClipboard(file.name, ipAddress);
                      }
                    } else {
                      ipAddress = interfaces[0].addresses[0].address;
                      startServer(file, ipAddress);
                      sendToClipboard(file.name, ipAddress);
                    }
                  } else if (Platform.isAndroid) {
                    ipAddress = (await RGetIp.internalIP)!;
                    startServer(file, ipAddress);
                    sendToClipboard(file.name, ipAddress);
                  }
                } else {
                  // User canceled the picker
                }
              },
              label: const Text(
                'Add Media',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.black),
            )));
  }
}
