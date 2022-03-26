import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

int size = 0;
BytesBuilder builder = BytesBuilder(copy: false);

Future<void> startClient(String ipAddress, String fileName, String downloadPath,
    int index, context) async {
  print("Trying");
  try {
    var socket = await Socket.connect(ipAddress, 2714);
    print("Connected");
    socket.write(fileName);
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      print(fileName);
      await File('$downloadPath/$fileName').create();
    }
    var file = File('$downloadPath/$fileName').openWrite();
    await socket.map(toIntList).pipe(file);
    print(downloadPath);
    print("File written");
    file.close();
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
        'Server Error: Sender has disconnected, please send again',
        style: TextStyle(color: Colors.black),
      ),
    ));
  } on FileSystemException {
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
        'FileSystem Error: Please change the download location or restart your device',
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}

List<int> toIntList(Uint8List source) {
  return List.from(source);
}
