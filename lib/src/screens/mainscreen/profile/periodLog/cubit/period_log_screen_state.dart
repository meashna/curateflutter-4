part of 'period_log_screen_cubit.dart';

@immutable
abstract class PeriodLogScreenState {}

class PeriodLogScreenInitial extends PeriodLogScreenState {}

class PeriodLogScreenLoading extends PeriodLogScreenState {}

class PeriodLogScreenSuccess extends PeriodLogScreenState{}

class PeriodLogScreenError extends PeriodLogScreenState {
  String? errorMessage;
  PeriodLogScreenError(this.errorMessage);
}

class PeriodLogScreenNoInternet extends PeriodLogScreenState {}

class PeriodLogScreenEmpty extends PeriodLogScreenState {}