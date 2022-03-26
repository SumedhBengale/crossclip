import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'package:crossclip/pages/homepage/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text/text_clipboard.dart';
import 'dart:io' show Platform;

const borderColor = Color(0xFF805306);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
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
                          child: SafeArea(
                            child: Drawer(
                              child: MainDrawer(),
                            ),
                          ),
                        )),
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
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
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
    } else {
      return MaterialApp(
          home: Builder(
              builder: (context) => DefaultTabController(
                  length: 2,
                  child: SafeArea(
                      child: Scaffold(
                    backgroundColor: Colors.white,
                    drawer: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.white,
                        ),
                        child: const ClipRRect(
                          child: Drawer(
                            child: MainDrawer(),
                          ),
                        )),
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(110),
                        child: Theme(
                            data: ThemeData(
                              splashColor: Colors.yellow,
                              hoverColor: Colors.yellow,
                            ),
                            child: Column(children: [
                              WindowTitleBarBox(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.yellow),
                                      child: WindowBorder(
                                          color: Colors.yellow,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MoveWindow(),
                                              ),
                                              const WindowButtons()
                                            ],
                                          )))),
                              Expanded(
                                child: AppBar(
                                  elevation: 0,
                                  centerTitle: true,
                                  iconTheme:
                                      const IconThemeData(color: Colors.black),
                                  backgroundColor: Colors.yellow,
                                  title: const Text(
                                    "CrossClip",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  bottom: TabBar(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.yellow),
                                      indicator: const BoxDecoration(
                                          color: Colors.yellow),
                                      tabs: const [
                                        Tab(
                                          child: Text(
                                            "Text",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        Tab(
                                          child: Text("Media and Files",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        )
                                      ]),
                                ),
                              )
                            ]))),
                    body: Row(children: const [
                      Expanded(
                        child: TextClipboard(),
                      ),
                      VerticalDivider(
                        indent: 30,
                        endIndent: 50,
                        color: Colors.yellow,
                      ),
                      Expanded(child: MediaClipboard()),
                    ]),
                  )))));
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton()
      ],
    );
  }
}
