import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/agenda/session_detail.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/home/home_page.dart';
import 'package:flutter_devfest/home/home_provider.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import 'devfest_event.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  static final ConfigBloc _configBlocSingleton = ConfigBloc._internal();

  factory ConfigBloc() {
    return _configBlocSingleton;
  }

  ConfigBloc._internal();

  bool darkModeOn = false;

  String languageCode;

  DevFestEventsData devFestEventsData;

  DevFestEvent devFestEvent;

  FirebaseAnalytics analytics;

  FirebaseMessaging firebaseMessaging;

  RemoteConfig remoteConfig;

  ConfigState get initialState => new UnConfigState();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

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
    //TODO need comment in release
    firebaseMessaging.subscribeToTopic('dev');
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onMessage: $message");
        //TODO local notification
//        if (Platform.isAndroid)
//          _navigateToItemDetail(message['data']);
//        else if (Platform.isIOS) _navigateToItemDetail(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onLaunch: $message");
        while (ConfigBloc().navigatorKey.currentState == null) {
          await Future.delayed(Duration(seconds: 1));
          print('isNull');
        }
        if (Platform.isAndroid)
          navigateToItemDetail(message['data']);
        else if (Platform.isIOS) navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        if (Devfest.isDebugMode) print("onResume: $message");
        if (Platform.isAndroid)
          await navigateToItemDetail(message['data']);
        else if (Platform.isIOS) await navigateToItemDetail(message);
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

  Future<void> navigateToItemDetail(message) async {
    if (message['type'] == "1" || message['type'] == "3") {
      String key = sprintf(
        Devfest.onForAllPref,
        [
          ConfigBloc().languageCode,
          message['tag'],
        ],
      );
      String cache = Preferences.getString(key, null);
      if (cache == null) {
        cache = await rootBundle.loadString(
          sprintf(
            Devfest.oneForAllAssetJsonCity,
            [
              ConfigBloc().languageCode,
              message['tag'],
            ],
          ),
        );
      }
      if (cache == null) return;
      var json = jsonDecode(cache);
      try {
        ConfigBloc().devFestEvent = DevFestEvent(tag: message['tag']);
        json = await HomeProvider().getOneForAll();
        SpeakersData.fromJson(json);
        SessionsData.fromJson(json);
        TeamsData.fromJson(json);
        SponsorsData.fromJson(json);
      } on Exception catch (e) {
        json = jsonDecode(cache);
      } finally {
        Preferences.setString(key, jsonEncode(json));
      }
      var speakersData = SpeakersData.fromJson(json);
      var sessionsData = SessionsData.fromJson(json);
      var teamsData = TeamsData.fromJson(json);
      var sponsorsData = SponsorsData.fromJson(json);
      if (message['type'] == "1") {
        Session target;
        sessionsData.sessions?.forEach((session) {
          session.setSpeaker(speakersData.speakers);
          if (message['id'] == session.sessionId) {
            target = session;
          }
        });
        if (target != null)
          ConfigBloc().navigateTo(
            SessionDetail.routeName,
            arguments: target,
          );
      }
    } else if (message['type'] == "2") {
      launch(message['url']);
    }
  }
}
