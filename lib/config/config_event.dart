import 'dart:async';
import 'dart:ui';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/config/index.dart';
import 'package:flutter_devfest/utils/dependency_injection.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:meta/meta.dart';

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
      Devfest.prefs.setBool(Devfest.darkModePref, darkOn);
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
      print(Injector().currentEventMode);
      if (Injector().currentEventMode == EventMode.SINGLE)
        bloc.devFestEvent = await _configProvider.getDevFestEvent();
      else if (Injector().currentEventMode == EventMode.MULTI)
        bloc.devFestEventsData = await _configProvider.getDevFestEventsData();
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

  LocaleEvent(this.locale);

  @override
  Future<ConfigState> applyAsync(
      {ConfigState currentState, ConfigBloc bloc}) async {
    try {
      bloc.languageCode = locale.languageCode;
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
