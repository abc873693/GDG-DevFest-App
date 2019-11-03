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
    final cityTag = ConfigBloc().devFestEvent?.tag;

    //? For Speakers Hardcoded Data
    if (resourcePath == HomeProvider.kConstGetSpeakersUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(SpeakersData(speakers: speakers));
      } else {
        rawString = await rootBundle.loadString(
          Injector().currentEventMode == EventMode.MULTI
              ? sprintf(Devfest.speakersAssetJsonCity,
                  [ConfigBloc().languageCode, cityTag])
              : sprintf(Devfest.speakersAssetJson, [ConfigBloc().languageCode]),
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
              ? sprintf(Devfest.sessionsAssetJsonCity,
                  [ConfigBloc().languageCode, cityTag])
              : sprintf(Devfest.sessionsAssetJson, [ConfigBloc().languageCode]),
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
              ? sprintf(Devfest.teamsAssetJsonCity,
                  [ConfigBloc().languageCode, cityTag])
              : sprintf(Devfest.teamsAssetJson, [ConfigBloc().languageCode]),
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
              ? sprintf(Devfest.sponsorsAssetJsonCity,
                  [ConfigBloc().languageCode, cityTag])
              : sprintf(Devfest.sponsorsAssetJson, [ConfigBloc().languageCode]),
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For DevFestEvent Hardcoded Data
    else if (resourcePath == ConfigProvider.kConstGetDevFestEventUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(devFestEvent);
      } else {
        rawString = await rootBundle.loadString(
          sprintf(Devfest.devFestEventAssetJson, [ConfigBloc().languageCode]),
        );
      }
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For DevFestEvents Hardcoded Data
    else if (resourcePath == ConfigProvider.kConstGetDevFestEventsUrl) {
      if (Injector().currentDataMode == DataMode.DART) {
        rawString = jsonEncode(devFestEvent);
      } else {
        rawString = await rootBundle.loadString(
          sprintf(Devfest.devFestEventsAssetJson, [ConfigBloc().languageCode]),
        );
      }
      resultClass = jsonDecode(rawString);
    }

    return MappedNetworkServiceResponse<T>(
      mappedResult: resultClass,
      networkServiceResponse: NetworkServiceResponse<T>(success: true),
    );
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
