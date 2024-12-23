part of 'expert_talk_cubit.dart';

@immutable
abstract class ExpertTalkState {}

class ExpertTalkStateInitial extends ExpertTalkState {}

class ExpertTalkStateLoading extends ExpertTalkState {}

class ExpertTalkStateSuccess extends ExpertTalkState {}

class ExpertTalkStateError extends ExpertTalkState {
  String? errorMessage;
  ExpertTalkStateError(this.errorMessage);
}

class ExpertTalkStateNoInternet extends ExpertTalkState {}

class ExpertTalkStateEmpty extends ExpertTalkState {}