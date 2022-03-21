import 'dart:async';
import 'dart:io';

import 'package:crossclip/ad_helper.dart';
import 'package:crossclip/pages/homepage/media/media_clipboard.dart';
import 'package:crossclip/pages/homepage/media/server.dart';
import 'package:firedart/firedart.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:r_get_ip/r_get_ip.dart';
import 'hive_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

String? selectedDirectory = '';
InterstitialAd? interstitialAd;

bool isInterstitialAdReady = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(500, 800));
  }
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  if (!Hive.isAdapterRegistered(42)) {
    Hive.registerAdapter(TokenAdapter());
  }
  FirebaseAuth.initialize(
      'AIzaSyBV4BfSgK9fHO5b7hJwvcn2PbE4EGwYYWM', await HiveStore.create());

  if (Platform.isAndroid) {
    MobileAds.instance.initialize();
    loadInterstitialAd();
    selectedDirectory = '/storage/emulated/0/Download';
  } else if (Platform.isWindows) {
    Directory? downloadDirectory = await path_provider.getDownloadsDirectory();
    selectedDirectory = downloadDirectory!.path;
  }

  runApp(const App());
}

Future<void> loadInterstitialAd() async {
  InterstitialAd.load(
    adUnitId: AdHelper.interstitialAdUnitId,
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        interstitialAd = ad;
        print("Ad Loaded");
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            loadInterstitialAd();
          },
        );

        isInterstitialAdReady = true;
      },
      onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
        isInterstitialAdReady = false;
      },
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late StreamSubscription _intentDataStreamSubscription;
  late List<SharedMediaFile> _sharedFiles;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      // For sharing images coming from outside the app while the app is in the memory
      _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
          .listen((List<SharedMediaFile> value) async {
        _sharedFiles = value;
        fileNames = [];
        for (int i = 0; i < _sharedFiles.length; i++) {
          var path = (_sharedFiles.map((f) => f.path).elementAt(i));
          print(path);
          String fileName = File(path).uri.pathSegments.last;
          print(fileName);
          fileNames.add(fileName);
        }
        ipAddress = (await RGetIp.internalIP)!;
        if (fileNames.isNotEmpty) {
          sendToClipboard(fileNames, ipAddress);
          for (int i = 0; i < _sharedFiles.length; i++) {
            var path = (_sharedFiles.map((f) => f.path).elementAt(i));
            _sharedFiles = value;
            var file = File(path);

            print("Ad!!!");
            print(isInterstitialAdReady);
            if (isInterstitialAdReady) {
              interstitialAd?.show();
            }
            for (int i = 0; i < fileNames.length; i++) {
              startServer(file.path, fileNames, ipAddress);
            }
          }
        }
        setState(() {});
      }, onError: (err) {
        print("getIntentDataStream error: $err");
      });

      // For sharing images coming from outside the app while the app is closed
      ReceiveSharingIntent.getInitialMedia()
          .then((List<SharedMediaFile> value) async {
        MobileAds.instance.initialize();
        await loadInterstitialAd();
        _sharedFiles = value;
        fileNames = [];
        for (int i = 0; i < _sharedFiles.length; i++) {
          var path = (_sharedFiles.map((f) => f.path).elementAt(i));
          print(path);
          String fileName = File(path).uri.pathSegments.last;
          print(fileName);
          fileNames.add(fileName);
        }
        ipAddress = (await RGetIp.internalIP)!;
        if (fileNames.isNotEmpty) {
          print("Sending");
          sendToClipboard(fileNames, ipAddress);
          for (int i = 0; i < _sharedFiles.length; i++) {
            var path = (_sharedFiles.map((f) => f.path).elementAt(i));
            _sharedFiles = value;
            var file = File(path);

            for (int i = 0; i < fileNames.length; i++) {
              startServer(file.path, fileNames, ipAddress);
            }
          }
          await Future.delayed(const Duration(seconds: 2));

          print("Ad!!!");
          print(isInterstitialAdReady);
          if (isInterstitialAdReady) {
            interstitialAd?.show();
          }
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

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
