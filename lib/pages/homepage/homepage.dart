import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'package:crossclip/pages/homepage/main_drawer.dart';
import 'package:flutter/material.dart';
import 'text/text_clipboard.dart';

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
            builder: (context) => DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  drawer: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                      ),
                      child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Drawer(
                          child: MainDrawer(),
                        ),
                      )),
                  appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(110),
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.white,
                        ),
                        child: AppBar(
                          elevation: 0,
                          centerTitle: true,
                          iconTheme: const IconThemeData(color: Colors.black),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          )),
                          backgroundColor: Colors.yellow,
                          title: const Text(
                            "CrossClip",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          bottom: const TabBar(
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Text",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text("Media and Files",
                                      style: TextStyle(color: Colors.black)),
                                )
                              ]),
                        ),
                      )),
                  body: const TabBarView(children: [
                    TextClipboard(),
                    MediaClipboard(),
                  ]),
                ))));
  }
}
