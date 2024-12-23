part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState{}

class EditProfileSuccess extends EditProfileState{}

class EditProfileError extends EditProfileState {
  String? errorMessage;
  EditProfileError(this.errorMessage);
}

class EditProfileNoInternet extends EditProfileState {}

class EditProfileEmpty extends EditProfileState {}