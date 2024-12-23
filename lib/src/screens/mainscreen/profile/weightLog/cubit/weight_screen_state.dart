part of 'weight_screen_cubit.dart';

@immutable
abstract class WeightScreenState {}

class WeightScreenInitial extends WeightScreenState {}

class WeightScreenLoading extends WeightScreenState{}

class WeightScreenSuccess extends WeightScreenState{}

class WeightScreenError extends WeightScreenState {
  String? errorMessage;
  WeightScreenError(this.errorMessage);
}

class WeightScreenNoInternet extends WeightScreenState {}

class WeightScreenEmpty extends WeightScreenState {}

class SaveWeightDataLoading extends WeightScreenState{}

class SaveWeightDataSuccess extends WeightScreenState{}