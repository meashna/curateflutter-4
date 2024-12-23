part of 'personal_detail_cubit.dart';

@immutable
abstract class PersonalDetailState {}

class PersonalDetailInitial extends PersonalDetailState {}


class PersonalDetailLoading extends PersonalDetailState {
}

class PersonalDetailSuccess extends PersonalDetailState {
  String? message;
  PersonalDetailSuccess(this.message);
}

class PersonalDetailError extends PersonalDetailState {
  String? errorMessage;
  PersonalDetailError(this.errorMessage);
}

class PersonalDetailNoInternet extends PersonalDetailState {}

