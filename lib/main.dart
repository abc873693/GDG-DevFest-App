import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/preferences.dart';
import 'package:flutter_devfest/utils/simple_bloc.dart';

import 'config/config_page.dart';

Future<void> main() async {
  // If you're running an application and need to access the binary messenger before `runApp()`
// has been called (for example, during plugin initialization), then you need to explicitly
// call the `WidgetsFlutterBinding.ensureInitialized()` first.
// If you're running a test, you can call the `TestWidgetsFlutterBinding.ensureInitialized()`
//  as the first line in your test's `main()` method to initialize the binding.)

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // * Get Shared Preference Instance for whole app
  if (!false) {
    Preferences.init();
  }

  //* To check the app is running in debug and set some variables for that
  Devfest.checkDebug();

  //* Time travel debugging to check app states
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // * Set flavor for your app. For eg - MOCK for offline, REST for some random server calls to your backend, FIREBASE for firebase calls
  //* Set DataMode.DART to use Dart hardcoded data and DataMode.JSON to use json file for hardcoded data.
  Injector.configure(Flavor.FIREBASE, DataMode.JSON, EventMode.MULTI);

  if (false) {
  } else if (Platform.isIOS || Platform.isAndroid) {
    Crashlytics.instance.enableInDevMode = false;
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
    var analytics = FirebaseAnalytics();
    // if in develop value use dev
    await analytics?.setUserProperty(name: 'mode', value: 'dev');
  }

  runApp(ConfigPage());
}
