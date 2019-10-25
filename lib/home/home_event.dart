import 'dart:async';
import 'package:flutter_devfest/home/home_provider.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();

  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      var speakersData = await _homeProvider.getSpeakers();
      var tracksData = await _homeProvider.getTracks();
      var sessionsData = await _homeProvider.getSessions();
      var teamsData = await _homeProvider.getTeams();
      var sponsorsData = await _homeProvider.getSponsors();
      sessionsData.sessions.forEach((session) {
        session.setSpeaker(speakersData.speakers);
      });
      return InHomeState(
        speakersData: speakersData,
        tracksData: tracksData,
        sessionsData: sessionsData,
        teamsData: teamsData,
        sponsorsData: sponsorsData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
  }
}
