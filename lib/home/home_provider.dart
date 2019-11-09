import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/sponsor.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/home/track.dart';
import 'package:flutter_devfest/network/i_client.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';

abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();

  Future<TracksData> getTracks();

  Future<SessionsData> getSessions();

  Future<TeamsData> getTeams();

  Future<SponsorsData> getSponsors();

  Future<Map<String, dynamic>> getOneForAll();
}

class HomeProvider implements IHomeProvider {
  IClient _client;
  static final String kConstGetOneForAllUrl =
      "${Devfest.baseUrl}/one-for-all-kol.json";

  static final String kConstGetSpeakersUrl =
      "${Devfest.baseUrl}/speaker-kol.json";

  //! Not Working
  static final String kConstGetSessionsUrl =
      "${Devfest.baseUrl}/session-kol.json";

  //! Not Working
  static final String kConstGetTracksUrl = "${Devfest.baseUrl}/track-kol.json";

  //! Not Working
  static final String kConstGetTeamsUrl = "${Devfest.baseUrl}/team-kol.json";

  //! Not Working
  static final String kConstGetSponsorsUrl =
      "${Devfest.baseUrl}/sponsor-kol.json";

  HomeProvider() {
    _client = Injector().currentClient;
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    var result = await _client.getAsync(kConstGetSpeakersUrl);
    if (result.networkServiceResponse.success) {
      SpeakersData res = SpeakersData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<TracksData> getTracks() async {
    var result = await _client.getAsync(kConstGetTracksUrl);
    if (result.networkServiceResponse.success) {
      TracksData res = TracksData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SessionsData> getSessions() async {
    var result = await _client.getAsync(kConstGetSessionsUrl);
    if (result.networkServiceResponse.success) {
      SessionsData res = SessionsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<TeamsData> getTeams() async {
    var result = await _client.getAsync(kConstGetTeamsUrl);
    if (result.networkServiceResponse.success) {
      TeamsData res = TeamsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SponsorsData> getSponsors() async {
    var result = await _client.getAsync(kConstGetSponsorsUrl);
    if (result.networkServiceResponse.success) {
      SponsorsData res = SponsorsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<Map<String, dynamic>> getOneForAll() async {
    var result = await _client.getAsync(kConstGetOneForAllUrl);
    if (result.networkServiceResponse.success) {
      return result.mappedResult;
    }

    throw Exception(result.networkServiceResponse.message);
  }
}
