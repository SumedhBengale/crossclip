import 'package:crossclip/pages/homepage/clipboard_add_page.dart';
import 'package:crossclip/pages/homepage/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'clipboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.white,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.yellow,
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return const ClipboardAddPage();
                        }),
                    label: const Text(
                      'Add to Cipboard',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.black),
                  ),
                  drawer: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors
                            .white, //This will change the drawer background to blue.
                        //other styles
                      ),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            bottomRight: Radius.circular(35)),
                        child: Drawer(
                          child: MainDrawer(),
                        ),
                      )),
                  appBar: AppBar(
                    centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.black),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    )),
                    backgroundColor: Colors.yellow,
                    title: const Text(
                      "CrossClip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  body: const Clipboard(),
                )));
  }
}
