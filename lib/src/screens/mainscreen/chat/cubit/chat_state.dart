part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {}

class ChatError extends ChatState {
  String? errorMessage;
  ChatError(this.errorMessage);
}

class ChatNoInternet extends ChatState {}

class ChatEmpty extends ChatState {}