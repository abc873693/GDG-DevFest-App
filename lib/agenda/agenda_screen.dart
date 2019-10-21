import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_list.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/track.dart';

class AgendaScreen extends StatelessWidget {
  final Track track;
  final HomeBloc homeBloc;

  const AgendaScreen({Key key, this.track, this.homeBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var sessions = state.sessionsData.sessions;
    var webSessions = sessions.where((s) => s.track == track.id).toList();
    return SessionList(
      allSessions: webSessions,
    );
  }
}
