part of 'add_flow_cubit.dart';

@immutable
abstract class AddFlowState {}

class AddFlowInitial extends AddFlowState {}


class AddFlowLoading extends AddFlowState {}

class AddFlowSuccess extends AddFlowState{}

class SubmitFlowSuccess extends AddFlowState{}

class AddFlowError extends AddFlowState {
  String? errorMessage;
  AddFlowError(this.errorMessage);
}

class AddFlowNoInternet extends AddFlowState {}

class AddFlowEmpty extends AddFlowState {}