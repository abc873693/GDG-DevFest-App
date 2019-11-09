// *  Not needed as of now
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/config/config_provider.dart';
import 'package:flutter_devfest/home/home_provider.dart';

import 'index.dart';

class FirebaseClient implements IClient {
  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath,
      {bool customHeaders}) async {
    var resultClass;
    String rawString;
    String path = '';
    final cityTag = ConfigBloc().devFestEvent?.tag;

    //? For Speakers Hardcoded Data
    print(resourcePath);
    if (resourcePath == ConfigProvider.kConstGetDevFestEventsUrl) {
      path = "${ConfigBloc().languageCode}_events";
    } else if (resourcePath == HomeProvider.kConstGetOneForAllUrl) {
      path = "${ConfigBloc().languageCode}_${cityTag}_one_for_all";
    } else if (resourcePath == HomeProvider.kConstGetSpeakersUrl) {
      path = "${ConfigBloc().languageCode}_${cityTag}_speakers";
    } else if (resourcePath == HomeProvider.kConstGetSessionsUrl) {
      path = "${ConfigBloc().languageCode}_${cityTag}_sessions";
    } else if (resourcePath == HomeProvider.kConstGetTeamsUrl) {
      path = "${ConfigBloc().languageCode}_${cityTag}_teams";
    } else if (resourcePath == HomeProvider.kConstGetSponsorsUrl) {
      path = "${ConfigBloc().languageCode}_${cityTag}_sponsors";
    }
    print('path = ${path}');
    var start = DateTime.now();
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(seconds: 5));
    await remoteConfig.activateFetched();
    resultClass = jsonDecode(remoteConfig.getString(path));
    print(DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch);
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
