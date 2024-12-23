part of 'day_plan_cubit.dart';

@immutable
abstract class DayPlanState {}

class DayPlanInitial extends DayPlanState {}


class DayPlanLoading extends DayPlanState {
}

class DayPlanError extends DayPlanState {
  String? errorMessage;
  DayPlanError(this.errorMessage);
}

class DayPlanNoInternet extends DayPlanState {}

class DayPlanEmpty extends DayPlanState {}

class CompleteTaskSuccess extends DayPlanState {}


class DayPlanSuccess extends DayPlanState {}