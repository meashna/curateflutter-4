part of 'choose_package_cubit.dart';

@immutable
abstract class ChoosePackageState {}

class ChoosePackageInitial extends ChoosePackageState {}


class ChoosePackageLoading extends ChoosePackageState {
}

class ChoosePackageError extends ChoosePackageState {
  final String? errorMessage;
  ChoosePackageError(this.errorMessage);
}

class ChoosePackageNoInternet extends ChoosePackageState {}

class ChoosePackageEmpty extends ChoosePackageState {}

class CompleteTaskSuccess extends ChoosePackageState {}