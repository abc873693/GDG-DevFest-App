import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devfest/agenda/agenda_page.dart';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/faq/faq_page.dart';
import 'package:flutter_devfest/find_devfest/find_devfest_page.dart';
import 'package:flutter_devfest/home/home_page.dart';
import 'package:flutter_devfest/map/map_page.dart';
import 'package:flutter_devfest/speakers/speaker_page.dart';
import 'package:flutter_devfest/sponsors/sponsor_page.dart';
import 'package:flutter_devfest/team/team_page.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';

class ConfigPage extends StatefulWidget {
  static const String routeName = "/";

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() async {
    configBloc = ConfigBloc();
    configBloc.darkModeOn =
        Devfest.prefs.getBool(Devfest.darkModePref) ?? false;
    configBloc.dispatch(LoadDevFestEvent());
    if (kIsWeb) {
    } else if (Platform.isAndroid || Platform.isIOS) {
      configBloc.analytics = FirebaseAnalytics();
      configBloc.firebaseMessaging = FirebaseMessaging();
      configBloc.initFCM();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => configBloc,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Google Devfest',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //* Custom Google Font
              fontFamily: Devfest.google_sans_family,
              primarySwatch: Colors.red,
              primaryColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              disabledColor: Colors.grey,
              cardColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              canvasColor:
                  configBloc.darkModeOn ? Colors.black : Colors.grey[50],
              brightness:
                  configBloc.darkModeOn ? Brightness.dark : Brightness.light,
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  colorScheme: configBloc.darkModeOn
                      ? ColorScheme.dark()
                      : ColorScheme.light()),
              appBarTheme: AppBarTheme(
                elevation: 0.0,
              ),
            ),
            home: Injector().currentEventMode == EventMode.SINGLE
                ? HomePage()
                : FindDevFestPage(),
            routes: {
              HomePage.routeName: (context) => HomePage(),
              SpeakerPage.routeName: (context) => SpeakerPage(),
              AgendaPage.routeName: (context) => AgendaPage(),
              SponsorPage.routeName: (context) => SponsorPage(),
              TeamPage.routeName: (context) => TeamPage(),
              FaqPage.routeName: (context) => FaqPage(),
              FindDevFestPage.routeName: (context) => FindDevFestPage(),
              MapPage.routeName: (context) => MapPage(),
            },
            navigatorObservers: (kIsWeb)
                ? []
                : (Platform.isIOS || Platform.isAndroid)
                    ? [
                        FirebaseAnalyticsObserver(
                          analytics: configBloc.analytics,
                        ),
                      ]
                    : [],
          );
        },
      ),
    );
  }
}
