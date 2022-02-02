import 'package:crossclip/main.dart' as main;
import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  var userDocument;
  int index;
  ItemCard(this.userDocument, this.index, {Key? key}) : super(key: key);
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  bool working = false;
  String? get downloadPath => main.selectedDirectory;
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            //The Container Here is necessary for constraints. Without it the Widget library gives an error.
            child: ListTile(
                minVerticalPadding: 40,
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.userDocument['media_clipboard'][widget.index]
                                  ['fileName']
                              .toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ]),
                trailing:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow),
                      ),
                      onPressed: () async {
                        setState(() {
                          working = true;
                        });
                        ipAddress = widget.userDocument['media_clipboard']
                                [widget.index]['ipAddress']
                            .toString();
                        fileNames = widget.userDocument['media_clipboard']
                            [widget.index]['fileName'];
                        await recieveFile(ipAddress, fileNames, downloadPath!,
                            widget.index, context);
                        setState(() {
                          working = false;
                        });
                        deleteFromClipboard(widget.index);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                            'Download Complete',
                            style: TextStyle(color: Colors.black),
                          ),
                        ));
                      },
                      child: (working == false)
                          ? const Icon(
                              Icons.download,
                              color: Colors.black,
                            )
                          : const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black))))
                ]))));
  }
}
