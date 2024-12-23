part of 'waist_log_screen_cubit.dart';

@immutable
abstract class WaistLogScreenState {}

class WaistLogScreenInitial extends WaistLogScreenState {}


class WaistLogScreenLoading extends WaistLogScreenState {}

class WaistLogScreenSuccess extends WaistLogScreenState{}

class WaistLogScreenError extends WaistLogScreenState {
  String? errorMessage;
  WaistLogScreenError(this.errorMessage);
}

class WaistLogScreenNoInternet extends WaistLogScreenState {}

class WaistLogScreenEmpty extends WaistLogScreenState {}

class SaveWaistDataSuccess extends WaistLogScreenState {}

class SaveWaistDataLoading extends WaistLogScreenState {}
