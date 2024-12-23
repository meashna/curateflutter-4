part of 'mood_detail_cubit.dart';

@immutable
abstract class MoodDetailState {}

class MoodDetailInitial extends MoodDetailState {}

class MoodDetailLoading extends MoodDetailState {
}

class MoodDetailError extends MoodDetailState {
  String? errorMessage;
  MoodDetailError(this.errorMessage);
}

class MoodDetailnNoInternet extends MoodDetailState {}

class MoodDetailEmpty extends MoodDetailState {}