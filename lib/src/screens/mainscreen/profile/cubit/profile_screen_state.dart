part of 'profile_screen_cubit.dart';

@immutable
abstract class ProfileScreenState {}

class ProfileScreenInitial extends ProfileScreenState {}

class ProfileScreenLoading extends ProfileScreenState {}

class ProfileScreenSuccess extends ProfileScreenState{}


class ProfileScreenError extends ProfileScreenState {
  String? errorMessage;
  ProfileScreenError(this.errorMessage);
}

class ProfileScreenNoInternet extends ProfileScreenState {}

class ProfileScreenEmpty extends ProfileScreenState {}
