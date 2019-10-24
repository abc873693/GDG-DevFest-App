import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/network/i_client.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';

abstract class IConfigProvider {
  Future<DevFestEvent> getDevFestEvent();

  Future<DevFestEventsData> getDevFestEventsData();
}

class ConfigProvider implements IConfigProvider {
  IClient _client;

  static final String kConstGetDevFestEventUrl =
      "${Devfest.baseUrl}/devfest-event-kol.json";

  static final String kConstGetDevFestEventsUrl =
      "${Devfest.baseUrl}/devfest-events.json";

  ConfigProvider() {
    _client = Injector().currentClient;
  }

  @override
  Future<DevFestEvent> getDevFestEvent() async {
    var result = await _client.getAsync(kConstGetDevFestEventUrl);
    if (result.networkServiceResponse.success) {
      DevFestEvent res = DevFestEvent.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<DevFestEventsData> getDevFestEventsData() async {
    var result = await _client.getAsync(kConstGetDevFestEventsUrl);
    if (result.networkServiceResponse.success) {
      DevFestEventsData res = DevFestEventsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }
}
