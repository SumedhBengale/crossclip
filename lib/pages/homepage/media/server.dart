import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firedart.dart';

void startServer(PlatformFile file, String ipAddress) async {
  final server = await ServerSocket.bind(ipAddress, 2714);
  print("Server hosted on port:2714");
  print(ipAddress);

  server.listen((client) {
    try {
      handleClient(client, file);
      print("Sending data");
      server.close();
    } catch (e) {
      print(e);
    }
  });
}

void handleClient(Socket client, PlatformFile file) async {
  print("Connection from:"
      "${client.remoteAddress.address}:${client.remotePort}");
  client.listen((Uint8List data) async {
    final request = String.fromCharCodes(data);
    if (request == 'Send Data') {
      await file.readStream!.pipe(client);
    }
    client.close();
    deleteFromClipboard();
  });
}

void deleteFromClipboard() {
  var uid = FirebaseAuth.instance.userId;
  var firestore = Firestore('cross-clip-2714', auth: FirebaseAuth.instance);
  var documentRef = firestore.collection('users').document(uid);
  mediaArray = [];
  documentRef.update({'media_clipboard': mediaArray});
}
