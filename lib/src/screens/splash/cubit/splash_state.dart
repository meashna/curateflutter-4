part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState{}

class SplashAppUpdateStatus extends SplashState{}

class SplashError extends SplashState {
  String? errorMessage;
  SplashError(this.errorMessage);
}

class SplashNoInternet extends SplashState {}

class SplashEmpty extends SplashState {}
class SplashNotification extends SplashState {}
