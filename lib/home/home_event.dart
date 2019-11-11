import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/home/home_provider.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/preferences.dart';
import 'package:meta/meta.dart';
import 'package:sprintf/sprintf.dart';

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
      var sessionsData = await _homeProvider.getSessions();
      var teamsData = await _homeProvider.getTeams();
      var sponsorsData = await _homeProvider.getSponsors();
      sessionsData.sessions.forEach((session) {
        session.setSpeaker(speakersData.speakers);
      });
      return InHomeState(
        speakersData: speakersData,
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

class LoadHomeByOnForAllEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();

  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      String key = sprintf(
        Devfest.onForAllPref,
        [
          ConfigBloc().languageCode,
          ConfigBloc().devFestEvent.tag,
        ],
      );
      String cache = Preferences.getString(key, null);
      if (cache == null) {
        cache = await rootBundle.loadString(
          sprintf(
            Devfest.oneForAllAssetJsonCity,
            [
              ConfigBloc().languageCode,
              ConfigBloc().devFestEvent.tag,
            ],
          ),
        );
      }
      var json;
      try {
        json = await _homeProvider.getOneForAll();
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
      sessionsData.sessions?.forEach((session) {
        session.setSpeaker(speakersData.speakers);
      });
      return InHomeState(
        speakersData: speakersData,
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
