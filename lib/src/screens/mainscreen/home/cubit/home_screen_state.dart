part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {
  int? intialStateType;
  HomeScreenInitial(this.intialStateType);
}

class HomeScreenLoading extends HomeScreenState {
}

class TaskSubmitLoading extends HomeScreenState {
}

class HomeScreenError extends HomeScreenState {
  String? errorMessage;
  HomeScreenError(this.errorMessage);
}

class HomeScreenNoInternet extends HomeScreenState {}

class HomeScreenEmpty extends HomeScreenState {}

class CompleteTaskSuccess extends HomeScreenState {}