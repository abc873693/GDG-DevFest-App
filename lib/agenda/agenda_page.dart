import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/cloud_screen.dart';
import 'package:flutter_devfest/agenda/mobile_screen.dart';
import 'package:flutter_devfest/agenda/web_screen.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'agenda_screen.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var tracks = state.tracksData.tracks;
    return DefaultTabController(
      length: tracks.length,
      child: DevScaffold(
        title: AppLocalizations.of(context).agenda,
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[Random().nextInt(4)],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: tracks.map(
            (track) {
              return Tab(
                child: Text(track.title),
                icon: Icon(
                  FontAwesomeIcons.laptop,
                  size: 12,
                ),
              );
            },
          ).toList(),
        ),
        body: TabBarView(
          children: tracks.map(
            (track) {
              return AgendaScreen(
                track: track,
                homeBloc: _homeBloc,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
