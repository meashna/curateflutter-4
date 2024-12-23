part of 'notification_list_cubit.dart';


@immutable
abstract class NotificationListState {}

class NotificationListInitial extends NotificationListState {}


class NotificationListLoading extends NotificationListState {
}

class NotificationListError extends NotificationListState {
  String? errorMessage;
  NotificationListError(this.errorMessage);
}

class NotificatioListnNoInternet extends NotificationListState {}

class NotificatioListNoPermission extends NotificationListState {}

class NotificationListEmpty extends NotificationListState {}

class CompleteTaskSuccess extends NotificationListState {}