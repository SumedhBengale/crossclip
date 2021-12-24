import 'dart:io';

import 'package:firedart/firedart.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:hive/hive.dart';
import 'hive_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TokenAdapter());
  FirebaseAuth.initialize(
      'AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM', await HiveStore.create());

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.isSignedIn) {
      return const HomePage();
    } else {
      return const SignIn();
    }
  }
}

class SomethingWentWrong extends StatefulWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  _SomethingWentWrongState createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Something Went Wrong",
      textDirection: TextDirection.ltr,
    ));
  }
}

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            body: Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.yellow)))));
  }
}
