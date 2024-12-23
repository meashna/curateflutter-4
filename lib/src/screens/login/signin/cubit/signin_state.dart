part of 'signin_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {

}

class SignInLoading extends SignInState {
}

class SignInSuccess extends SignInState {

  String? message;
  SignInSuccess(this.message);
}

class SignInError extends SignInState {
  String? errorMessage;
  SignInError(this.errorMessage);
}

class SignInNoInternet extends SignInState {}

class SignInEmpty extends SignInState {}