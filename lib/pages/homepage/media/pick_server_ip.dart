import 'package:flutter/material.dart';
import 'media_clipboard.dart' as media_cliboard;

class PickServerIP extends StatefulWidget {
  @override
  _PickServerIPState createState() => _PickServerIPState();
}

class _PickServerIPState extends State<PickServerIP> {
  @override
  Widget build(BuildContext context) {
    final ScrollController mediaScrollController = ScrollController();
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 16,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Text(
                      " Select the Sender's IP Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 20, bottom: 20),
                      itemCount: media_cliboard.networks,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: mediaScrollController,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.yellow),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                                onTap: () {
                                  print("tapped");
                                  media_cliboard.ipAddress = media_cliboard
                                      .interfaces[index].addresses[0].address
                                      .toString();
                                  Navigator.pop(context, 'selected');
                                },
                                child: ListTile(
                                  minVerticalPadding: 20,
                                  title: Text(
                                    media_cliboard.interfaces[index].name
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(media_cliboard
                                      .interfaces[index].addresses[0].address),
                                )));
                      }),
                )
              ],
            )));
  }
}
