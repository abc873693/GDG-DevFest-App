import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/utils/devfest.dart';

import 'devfest_event.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  static final ConfigBloc _configBlocSingleton = ConfigBloc._internal();

  factory ConfigBloc() {
    return _configBlocSingleton;
  }

  ConfigBloc._internal();

  bool darkModeOn = false;

  DevFestEventsData devFestEventsData;

  DevFestEvent devFestEvent;

  FirebaseAnalytics analytics;

  FirebaseMessaging firebaseMessaging;

  ConfigState get initialState => new UnConfigState();

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    try {
      yield UnConfigState();
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }

  void initFCM() {
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onMessage: $message");
        //TODO local notification
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onResume: $message");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
      ),
    );
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    firebaseMessaging.getToken().then((String token) {
      if (token == null) return;
      if (Devfest.isDebugMode) {
        print("Push Messaging token: $token");
      }
    });
  }
}
