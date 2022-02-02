import 'dart:io';

import 'package:crossclip/ad_helper.dart';
import 'package:firedart/firedart.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:crossclip/pages/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:crossclip/pages/homepage/homepage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'hive_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
  Hive.registerAdapter(TokenAdapter());
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

void loadInterstitialAd() {
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
