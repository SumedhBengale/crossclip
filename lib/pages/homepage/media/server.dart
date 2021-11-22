import 'dart:io';
import 'dart:typed_data';
import 'package:network_info_plus/network_info_plus.dart';

void startServer(String path) async {
  var wifiIP = await NetworkInfo().getWifiIP();
  final server = await ServerSocket.bind(wifiIP, 2714);
  print("Server hosted on port:2714");
  print(wifiIP);

  server.listen((client) {
    handleClient(client, path);
    server.close();
  });
}

void handleClient(Socket client, String path) async {
  File file = File(path);
  Uint8List bytes = file.readAsBytesSync();
  print("Connection from:"
      "${client.remoteAddress.address}:${client.remotePort}");
  client.listen((Uint8List data) async {
    await Future.delayed(const Duration(seconds: 1));
    final request = String.fromCharCodes(data);
    if (request == 'Send Data') {
      client.add(bytes);
    }
    client.close();
  });
}
