import 'dart:io';
import 'package:crossclip/ad_helper.dart';
import 'package:crossclip/main.dart' as main;
import 'package:crossclip/pages/homepage/media/media_item_card.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:r_get_ip/r_get_ip.dart';
import 'pickServerIP.dart';
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
var fileNames = [];
var uid = FirebaseAuth.instance.userId;
var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
var documentStream = firestore.collection('users').document(uid).stream;
var documentRef = firestore.collection('users').document(uid);
List<NetworkInterface> interfaces = [];

void sendToClipboard(List fileNames, String ipAddress) {
  mediaArray.add({
    'fileName': fileNames,
    'ipAddress': ipAddress,
  });
  print(mediaArray);
  documentRef.update({'media_clipboard': mediaArray});
}

Future<void> recieveFile(String ipAddress, List fileNames, String downloadPath,
    index, context) async {
  print("Recieving");
  for (int i = 0; i < fileNames.length; i++) {
    await startClient(ipAddress, fileNames[i], downloadPath, index, context);
  }
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
            return userDocument['media_clipboard'].isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 20, bottom: 20),
                    scrollDirection: Axis.vertical,
                    controller: mediaScrollController,
                    itemCount: userDocument['media_clipboard'].length,
                    itemBuilder: (context, index) {
                      String ipAddress;
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
                          child: ItemCard(userDocument, index));
                    })
                : Center(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'assets/images/empty.png',
                          width: 200,
                          fit: BoxFit.contain,
                        )));
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
                fileNames = [];
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles(withReadStream: true, allowMultiple: true);
                if (result != null) {
                  final file = result.files;
                  print(file.length);
                  for (int i = 0; i < file.length; i++) {
                    fileNames.add(file[i].name);
                  }
                  print(fileNames);

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
                        sendToClipboard(fileNames, ipAddress);

                        for (int i = 0; i < fileNames.length; i++) {
                          startServer(file[i], fileNames, ipAddress);
                        }
                      }
                    } else {
                      ipAddress = interfaces[0].addresses[0].address;
                      startServer(file[0], fileNames, ipAddress);
                      sendToClipboard(fileNames, ipAddress);
                    }
                  } else if (Platform.isAndroid) {
                    ipAddress = (await RGetIp.internalIP)!;
                    sendToClipboard(fileNames, ipAddress);
                    print("Ad!!!");
                    print(main.isInterstitialAdReady);
                    if (main.isInterstitialAdReady) {
                      main.interstitialAd?.show();

                      for (int i = 0; i < fileNames.length; i++) {
                        startServer(file[i], fileNames, ipAddress);
                      }
                    }
                  } else {
                    // User canceled the picker
                  }
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
