// *  Not needed as of now
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/config/config_provider.dart';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/home/home_provider.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/home/track.dart' as prefix0;
import 'package:flutter_devfest/home/track.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:sprintf/sprintf.dart';

import 'index.dart';

class MockClient implements IClient {
  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath,
      {bool customHeaders}) async {
    var resultClass;
    String rawString;
    final tag = ConfigBloc().devFestEvent?.tag;

    //? For Speakers Hardcoded Data
    if (resourcePath == HomeProvider.kConstGetSpeakersUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(SpeakersData(speakers: speakers));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.speakersAssetJsonCity, [tag])
              : Devfest.speakersAssetJson,
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Tracks Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetTracksUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(TracksData(tracks: tracks));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.tracksAssetJsonCity, [tag])
              : Devfest.tracksAssetJson,
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Sessions Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetSessionsUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(SessionsData(sessions: sessions));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.sessionsAssetJsonCity, [tag])
              : Devfest.sessionsAssetJson,
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Teams Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetTeamsUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(TeamsData(teams: teams));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.teamsAssetJsonCity, [tag])
              : Devfest.teamsAssetJson,
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Sponsors Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetSponsorsUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(SponsorsData(sponsors: sponsors));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.sponsorsAssetJsonCity, [tag])
              : Devfest.sponsorsAssetJson,
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For DevFestEvent Hardcoded Data
    else if (resourcePath == ConfigProvider.kConstGetDevFestEventUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(devFestEvent);
      } else {
        rawString = await rootBundle.loadString(Devfest.devFestEventAssetJson);
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For DevFestEvents Hardcoded Data
    else if (resourcePath == ConfigProvider.kConstGetDevFestEventsUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(devFestEvent);
      } else {
        rawString = await rootBundle.loadString(Devfest.devFestEventsAssetJson);
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    return MappedNetworkServiceResponse<T>(
        mappedResult: resultClass,
        networkServiceResponse: NetworkServiceResponse<T>(success: true));
  }

  @override
  Future<MappedNetworkServiceResponse<T>> postAsync<T>(
      String resourcePath, data,
      {bool customHeaders = false}) {
    return null;
  }

  // * JSON Decoding using Isolates
  static Map<String, dynamic> jsonParserIsolate(String res) {
    return jsonDecode(res);
  }
}
