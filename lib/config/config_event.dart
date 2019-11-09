import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/network/index.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/preferences.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import 'config_provider.dart';

@immutable
abstract class ConfigEvent {
  Future<ConfigState> applyAsync({ConfigState currentState, ConfigBloc bloc});
}

class DarkModeEvent extends ConfigEvent {
  final bool darkOn;

  DarkModeEvent(this.darkOn);

  @override
  String toString() => 'DarkModeEvent';

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      bloc.darkModeOn = darkOn;
      Preferences.setBool(Devfest.darkModePref, darkOn);
      return InConfigState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}

class LoadDevFestEvent extends ConfigEvent {
  final IConfigProvider _configProvider = ConfigProvider();

  @override
  String toString() => 'LoadDevFestEvent';

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      if (Injector().currentEventMode == EventMode.SINGLE)
        bloc.devFestEvent = await _configProvider.getDevFestEvent();
      else if (Injector().currentEventMode == EventMode.MULTI) {
        bloc.devFestEventsData = await _configProvider.getDevFestEventsData();
        bloc.devFestEventsData.devFestEvents.forEach((event) {
          DateFormat dateFormat = DateFormat('yyyy-MM-dd');
          DateTime date = dateFormat.parse(event.date);
          DateTime now = DateTime.now();
          if (now.isBefore(date.add(Duration(days: -2))) &&
              now.isAfter(date.add(Duration(days: -2)))) {
            bloc.firebaseMessaging.subscribeToTopic(event.tag);
          }
        });
      }
      return InConfigState(
        devFestEvent: bloc.devFestEvent,
        devFestEventsData: bloc.devFestEventsData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}

class LoadDevFestByFirebaseEvent extends ConfigEvent {
  final IConfigProvider _configProvider = ConfigProvider();

  @override
  String toString() => 'LoadDevFestEvent';

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      if (Injector().currentEventMode == EventMode.SINGLE)
        bloc.devFestEvent = await _configProvider.getDevFestEvent();
      else if (Injector().currentEventMode == EventMode.MULTI) {
        String key = sprintf(Devfest.eventsPref, [ConfigBloc().languageCode]);
        String cache = Preferences.getString(key, null);
        if (cache == null) {
          cache = await rootBundle.loadString(
            sprintf(
              Devfest.devFestEventsAssetJson,
              [ConfigBloc().languageCode],
            ),
          );
        }
        try {
          bloc.devFestEventsData = await _configProvider.getDevFestEventsData();
          debugPrint(bloc.devFestEventsData.devFestEvents[1].date);
        } on Exception catch (e) {
          bloc.devFestEventsData =
              DevFestEventsData.fromJson(jsonDecode(cache));
        } finally {
          Preferences.setString(
              key, jsonEncode(bloc.devFestEventsData.toJson()));
        }
        bloc.devFestEventsData.devFestEvents.forEach((event) {
          DateFormat dateFormat = DateFormat('yyyy-MM-dd');
          DateTime date = dateFormat.parse(event.date);
          DateTime now = DateTime.now();
          if (now.isBefore(date.add(Duration(days: -2))) &&
              now.isAfter(date.add(Duration(days: -2)))) {
            bloc.firebaseMessaging.subscribeToTopic(event.tag);
          }
        });
      }
      return InConfigState(
        devFestEvent: bloc.devFestEvent,
        devFestEventsData: bloc.devFestEventsData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}

class LocaleEvent extends ConfigEvent {
  final Locale locale;
  final IConfigProvider _configProvider = ConfigProvider();

  LocaleEvent(this.locale);

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      bloc.languageCode = locale.languageCode;
      Preferences.setString(Devfest.languagePref, locale.languageCode);
      if (Injector().currentEventMode == EventMode.SINGLE)
        bloc.devFestEvent = await _configProvider.getDevFestEvent();
      else if (Injector().currentEventMode == EventMode.MULTI)
        bloc.devFestEventsData = await _configProvider.getDevFestEventsData();
      if (bloc.devFestEvent != null) {
        bloc.devFestEventsData.devFestEvents.forEach((event) {
          if (bloc.devFestEvent.tag == event.tag) bloc.devFestEvent = event;
        });
      }
      return InConfigState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}

class DevFestChangeEvent extends ConfigEvent {
  final DevFestEvent devFestEvent;

  DevFestChangeEvent(this.devFestEvent);

  @override
  String toString() => 'DevFestChangeEvent';

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      bloc.devFestEvent = devFestEvent;
      return InConfigState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}

class LoadConfigEvent extends ConfigEvent {
  @override
  String toString() => 'LoadConfigEvent';

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));

      return new InConfigState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorConfigState(_?.toString());
    }
  }
}
