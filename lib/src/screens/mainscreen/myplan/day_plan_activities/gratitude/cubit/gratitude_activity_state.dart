part of 'gratitude_activity_cubit.dart';

@immutable
abstract class GratitudeActivityState {}

class GratitudeActivityInitial extends GratitudeActivityState {
  String? message;
  GratitudeActivityInitial(this.message);
}


class GratitudeActivityLoading extends GratitudeActivityState {
}

class GratitudeActivityError extends GratitudeActivityState {
  String? errorMessage;
  GratitudeActivityError(this.errorMessage);
}

class GratitudeDataInitialState extends GratitudeActivityState {}

class GratitudeActivityNoInternet extends GratitudeActivityState {}

class GratitudeActivityEmpty extends GratitudeActivityState {}

class GratitudeSaveCompletionState extends GratitudeActivityState {
  String? successMessage;
  GratitudeSaveCompletionState(this.successMessage);
}