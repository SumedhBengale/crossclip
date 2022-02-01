import 'dart:io';
import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firedart.dart';

void startServer(PlatformFile file, List fileNames, String ipAddress) async {
  final server =
      await ServerSocket.bind(ipAddress.toString(), 2714, shared: true);
  print("Server hosted on port:2714");
  print(ipAddress);

  server.listen((client) {
    print("listening");
    try {
      handleClient(client, file, fileNames);
      print("Sending data");
      server.close();
    } catch (e) {
      print(e);
    }
  }, onError: (error) {
    print("Server Error");
    clearClipboard();
    server.close();
  });
}

void handleClient(Socket client, PlatformFile file, List fileNames) async {
  print("Connection from:"
      "${client.remoteAddress.address}:${client.remotePort}");
  print(fileNames);
  client.listen((Uint8List data) async {
    final request = String.fromCharCodes(data);
    print(request);
    print(fileNames[0]);
    for (int i = 0; i < fileNames.length; i++) {
      if (request == fileNames[i]) {
        print("Name Correct");
        await file.readStream!.pipe(client);
      }
    }
    client.close();
  });
}

void deleteFromClipboard(int index) {
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  var documentRef = firestore.collection('users').document(uid);
  try {
    mediaArray.removeAt(index);
    print(mediaArray);
    documentRef.update({'media_clipboard': mediaArray});
    // ignore: empty_catches
  } on RangeError {}
}

void clearClipboard() {
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  var documentRef = firestore.collection('users').document(uid);
  mediaArray = [];
  documentRef.update({'media_clipboard': mediaArray});
}
