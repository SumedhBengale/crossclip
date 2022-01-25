import 'dart:io';
import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firedart.dart';

void startServer(PlatformFile file, String ipAddress) async {
  final server =
      await ServerSocket.bind(ipAddress.toString(), 2714, shared: true);
  print("Server hosted on port:2714");
  print(ipAddress);

  server.listen((client) {
    print("listening");
    try {
      handleClient(
        client,
        file,
      );
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

void handleClient(
  Socket client,
  PlatformFile file,
) async {
  print("Connection from:"
      "${client.remoteAddress.address}:${client.remotePort}");
  client.listen((Uint8List data) async {
    final request = String.fromCharCodes(data);
    if (request == 'Send Data') {
      await file.readStream!.pipe(client);
    }
    client.close();
  });
}

void deleteFromClipboard(int index) {
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  var documentRef = firestore.collection('users').document(uid);
  mediaArray.removeAt(index);
  print(mediaArray);
  documentRef.update({'media_clipboard': mediaArray});
}

void clearClipboard() {
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  var documentRef = firestore.collection('users').document(uid);
  mediaArray = [];
  documentRef.update({'media_clipboard': mediaArray});
}
