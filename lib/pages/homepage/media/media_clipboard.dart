import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MediaClipboard extends StatefulWidget {
  const MediaClipboard({Key? key}) : super(key: key);

  @override
  _MediaClipboardState createState() => _MediaClipboardState();
}

class _MediaClipboardState extends State<MediaClipboard> {
  void getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.first;
      print(file.bytes);
      startServer(file.path.toString());
    } else {
      // User canceled the picker
    }
  }

  String? selectedDirectory = '';
  void getDownloadpath() async {
    selectedDirectory = await FilePicker.platform.getDirectoryPath();
    setState(() {});
    if (selectedDirectory == null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            OutlinedButton(
                onPressed: () => {
                      getDownloadpath(),
                    },
                child: const Text("Set Download Path")),
            Text(selectedDirectory!),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.yellow,
          onPressed: () => {getFile()},
          label: const Text(
            'Add to Clipboard',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.black),
        ));
  }
}
