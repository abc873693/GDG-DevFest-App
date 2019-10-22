import 'package:equatable/equatable.dart';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigState extends Equatable {
  ConfigState([Iterable props]) : super(props);

  /// Copy object for use in action
  ConfigState getStateCopy();
}

/// UnInitialized
class UnConfigState extends ConfigState {
  @override
  String toString() => 'UnConfigState';

  @override
  ConfigState getStateCopy() {
    return UnConfigState();
  }
}

/// Initialized
class InConfigState extends ConfigState {
  final DevFestEvent devFestEvent;

  InConfigState({this.devFestEvent}) : super([devFestEvent]);

  @override
  String toString() => 'InConfigState';

  @override
  ConfigState getStateCopy() {
    return InConfigState(devFestEvent: this.devFestEvent);
  }
}

class ErrorConfigState extends ConfigState {
  final String errorMessage;

  ErrorConfigState(this.errorMessage);

  @override
  String toString() => 'ErrorConfigState';

  @override
  ConfigState getStateCopy() {
    return ErrorConfigState(this.errorMessage);
  }
}
