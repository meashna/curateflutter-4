part of 'workout_activity_cubit.dart';

@immutable
abstract class WorkoutActivityState {}

class WorkoutActivityInitial extends WorkoutActivityState {}

class WorkoutActivityLoading extends WorkoutActivityState {}


class WorkoutActivityErrorActivityLoading extends WorkoutActivityState {
}

class WorkoutActivityError extends WorkoutActivityState {
  String? errorMessage;
  WorkoutActivityError(this.errorMessage);
}


class WorkoutSubmitionTaskSuccess extends WorkoutActivityState {
  String? successMesaage;
  WorkoutSubmitionTaskSuccess(this.successMesaage);
}

class WorkoutActivityNoInternet extends WorkoutActivityState {}

class WorkoutDataInitialState extends WorkoutActivityState {
  String? message;
  WorkoutDataInitialState(this.message);
}

