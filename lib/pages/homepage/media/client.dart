import 'dart:io';
import 'dart:typed_data';

int size = 0;
BytesBuilder builder = BytesBuilder(copy: false);
void startClient(String ipAddress, String fileName, String downloadPath) async {
  var socket = await Socket.connect(ipAddress, 2714);
  try {
    print(
        "Connected to:" '${socket.remoteAddress.address}:${socket.remotePort}');
    socket.write('Send Data');

    var file = File('$downloadPath/$fileName').openWrite();
    try {
      await socket.map(toIntList).pipe(file);
      print(downloadPath);
      print("File written");
    } finally {
      file.close();
    }
  } finally {
    socket.destroy();
  }
}

List<int> toIntList(Uint8List source) {
  return List.from(source);
}
