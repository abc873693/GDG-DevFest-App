import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_devfest/config/index.dart';

import 'devfest_event.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  static final ConfigBloc _configBlocSingleton = ConfigBloc._internal();
  factory ConfigBloc() {
    return _configBlocSingleton;
  }
  ConfigBloc._internal();

  bool darkModeOn = false;

  DevFestEvent devFestEvent;

  ConfigState get initialState => new UnConfigState();

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    try {
      yield UnConfigState();
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
