import 'dart:io';
import 'dart:typed_data';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

int size = 0;
BytesBuilder builder = BytesBuilder(copy: false);
void startClient(String ipAddress, String fileName, String downloadPath,
    int index, context) async {
  try {
    var socket = await Socket.connect(ipAddress, 2714);
    print("Connected");
    socket.write('Send Data');
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await File('$downloadPath/$fileName').create(recursive: true);
    }
    var file = File('$downloadPath/$fileName').openWrite();
    await socket.map(toIntList).pipe(file);
    print(downloadPath);
    print("File written");
    file.close();
    deleteFromClipboard(index);
    socket.destroy();
  } on SocketException {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        'Error: Sender has disconnected, please send again',
        style: TextStyle(color: Colors.black),
      ),
    ));
    deleteFromClipboard(index);
  }
}

List<int> toIntList(Uint8List source) {
  return List.from(source);
}
