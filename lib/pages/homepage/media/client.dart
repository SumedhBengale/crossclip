import 'dart:io';
import 'dart:typed_data';

int size = 0;
BytesBuilder builder = BytesBuilder(copy: false);
void main() async {
  final socket = await Socket.connect('localhost', 2714);
  print("Connected to:" '${socket.remoteAddress.address}:${socket.remotePort}');
  socket.write('Send Data');
  socket.listen((Uint8List data) async {
    await Future.delayed(const Duration(seconds: 1));
    dataHandler(data);
    size = size + data.lengthInBytes;
    print(size);
  });
  await Future.delayed(const Duration(seconds: 10));
  await writeToFile('1(recieved).mkv');
  print("File Written");
  socket.close();
  socket.destroy();
}

void dataHandler(Uint8List data) {
  builder.add(data);
}

Future<void> writeToFile(String path) {
  return File(path).writeAsBytes(builder.toBytes());
}
