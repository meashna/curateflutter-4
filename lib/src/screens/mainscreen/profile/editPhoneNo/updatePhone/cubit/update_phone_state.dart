part of 'update_phone_cubit.dart';

@immutable
abstract class UpdatePhoneState {}

class UpdatePhoneInitial extends UpdatePhoneState {

}

class UpdatePhoneLoading extends UpdatePhoneState {
}

class UpdatePhoneSuccess extends UpdatePhoneState {

  String? message;
  UpdatePhoneSuccess(this.message);
}

class UpdatePhoneError extends UpdatePhoneState {
  String? errorMessage;
  UpdatePhoneError(this.errorMessage);
}

class UpdatePhoneNoInternet extends UpdatePhoneState {}

class UpdatePhoneEmpty extends UpdatePhoneState {}