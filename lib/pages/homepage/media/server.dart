import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

void startServer(PlatformFile file, String ipAddress) async {
  final server = await ServerSocket.bind(ipAddress, 2714);
  print("Server hosted on port:2714");
  print(ipAddress);

  server.listen((client) {
    handleClient(client, file);
    print("Sending data");
    server.close();
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
  });
}
