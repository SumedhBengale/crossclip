import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(110),
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.white,
                  ),
                  child: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      // Status bar color
                      statusBarColor: Colors.yellow,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    elevation: 0,
                    centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.black),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical()),
                    backgroundColor: Colors.yellow,
                    title: const Text(
                      "CrossClip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                )),
            body: Center(
                child: SizedBox(
                    width: 800,
                    child: ListView(children: [
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        color: Colors.yellow,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Container(
                              //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                              child: const Center(
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "FAQ",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )),
                          ))),
                      Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                                  child: const ListTile(
                                      title: Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "What is Crossclip?",
                                            // textAlign: TextAlign.center,
                                            // overflow: TextOverflow.ellipsis
                                          )),
                                      subtitle: Text(
                                        "CrossClip is a tool with which you can share Text(over the Internet) and Files(over your Local Network/Wifi Network) with the click of a single button.",
                                        // textAlign: TextAlign.center,
                                        // overflow: TextOverflow.ellipsis
                                      ))))),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 20, right: 5, left: 5),
                          child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                                  child: ListTile(
                                      title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "How to use Crossclip?",
                                            // textAlign: TextAlign.center,
                                            // overflow: TextOverflow.ellipsis
                                          )),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "First make sure you are logged in with the same Email and Password in all your devices.",
                                            ),
                                            Text(
                                                "Text can be shared over the Internet, no Local/Wifi network is required"),
                                            Text(
                                                "To share Files/Media, both the sender and the reciever need to be on the same Local/Wifi Network")
                                          ]))))),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 20, right: 5, left: 5),
                          child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                                  child: ListTile(
                                      title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Common Errors:",
                                            // textAlign: TextAlign.center,
                                            // overflow: TextOverflow.ellipsis
                                          )),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        "Progress Icon keeps rotating and process ends with a Server Error.",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "Both the devices are not on the same local network, make sure they are connected to the same network and the Internet."),
                                                      Text(
                                                          "It may also occur if CrossClip is not allowed through the Windows Firewall, make sure to allow network access in the Firewall permission dialog.")
                                                    ]
                                                    // textAlign: TextAlign.center,
                                                    // overflow: TextOverflow.ellipsis
                                                    )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        "Server Error:Sender has disconnected, please send again",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "Sender app has been closed before completing the download on the client side."),
                                                      Text(
                                                          "Send the file again and make sure the sender app is not closed till the download is completed on the client side.")
                                                    ]
                                                    // textAlign: TextAlign.center,
                                                    // overflow: TextOverflow.ellipsis
                                                    )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        "FileSystem Error: Please change the download location or restart your device",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "Occurs most probably on Android when trying to downloading a file that has been recently deleted from the client device."),
                                                      Text(
                                                          "This is caused due to how the Android file system works, Android does not seem to remember the file being deleted, but cannot find the file to be overwritten while downloading, which causes the error. We could'nt find a workaround yet."),
                                                      Text(
                                                          "A simple device restart on the client side should fix the problem.")
                                                    ]
                                                    // textAlign: TextAlign.center,
                                                    // overflow: TextOverflow.ellipsis
                                                    )),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        "Sign In Error: Something went wrong, please check your network and credentials",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "Either you are not connected to the Internet or no Account with the provided credentials exist with CrossClip."),
                                                      Text(
                                                          "Make sure you are properly connected to the Internet."),
                                                      Text(
                                                          "Check your credentials once again or create a new Account with your preferred credentials.")
                                                    ]
                                                    // textAlign: TextAlign.center,
                                                    // overflow: TextOverflow.ellipsis
                                                    )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        "Sign Up Error: Something went wrong, please check your network",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "You are not connected to the Internet."),
                                                      Text(
                                                          "Make sure you are properly connected to the Internet."),
                                                      Text(
                                                          "Make sure all the conditions for the Email and Password are satisfied.")
                                                    ]
                                                    // textAlign: TextAlign.center,
                                                    // overflow: TextOverflow.ellipsis
                                                    ))
                                          ]))))),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 5, left: 5),
                          child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  //The Container Here is necessary for constraints. Without it the Widget library gives an error.
                                  child: ListTile(
                                      title: const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "What's up with the Banner at the Top?",
                                            // textAlign: TextAlign.center,
                                            // overflow: TextOverflow.ellipsis
                                          )),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Made it on a whim and my Mom thought it looked very cool, so here it is.",
                                            ),
                                          ]))))),
                    ])))));
  }
}
