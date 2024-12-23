part of 'plan_screen_cubit.dart';


@immutable
abstract class PlanScreenState {}

class PlanScreenInitial extends PlanScreenState {}

class PlanSkeletonLoading extends PlanScreenState {
  bool isEmptyScreen=true;
  PlanSkeletonLoading(this.isEmptyScreen);
}

class PlanScreenError extends PlanScreenState {
  String? errorMessage;
  PlanScreenError(this.errorMessage);
}

class PlanScreenNoInternet extends PlanScreenState {}

class PlanScreenLock extends PlanScreenState {}

class PlanScreenEmpty extends PlanScreenState {}