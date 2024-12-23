import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/network_check.dart';
import '../../../data/models/NotificationListModel.dart';
import '../../../data/models/apis/UIResponse.dart';
import '../../../data/repository/user_repo/user_repository.dart';
import '../../../utils/notification/notification_count_bloc/notification_count_cubit.dart';
import '../../../utils/routes/myNavigator.dart';
part 'notification_list_state.dart';

class NotificationListCubit extends Cubit<NotificationListState> {
  int pageNumber = 1;
  bool isLastPage = false;
  bool isRefresh = false;
  bool isLoading = false;
  final _userRepository = GetIt.I<UserRepository>();
  NotificationListModel? notificationListModel;

  NotificationListCubit() : super(NotificationListLoading()) {
    emit(NotificationListLoading());
    if (Platform.isAndroid) {
      notificationPermissionGranted().then((value) {
        if (value) {
          getNotificationData();
        } else {
          emit(NotificatioListNoPermission());
        }
      });
    } else {
      checkIOSPermission();
    }
  }

  checkIOSPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        provisional: true,
        criticalAlert: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      getNotificationData();
      print("ios permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("ios permission provisoonal granted");
      getNotificationData();
    } else {
      print("ios permission denied");
      emit(NotificatioListNoPermission());
    }
  }

  Future<bool> notificationPermissionGranted() async {
    const permission = Permission.notification;
    if (await permission.isGranted) return true;
    return false;
    //final result = await Permission.notification.request();
  }

  void loadNotificationWithSkelton() {
    emit(NotificationListLoading());
    getNotificationData();
  }

  Future<void> getNotificationData({bool isRefresh = false}) async {
    const permission = Permission.notification;
    if (!await permission.isGranted) {
      emit(NotificationListInitial());
      return;
    }
    if (isLoading) {
      return;
    }
    isLoading = true;
    // Future.delayed(Duration(milliseconds: 100),(){emit(NotificationListLoading());});
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        this.isRefresh = isRefresh;
        if (isRefresh) {
          pageNumber = 1;
          isLastPage = false;
        }
        Map<String, dynamic> queryData = {"perPage": 10, "page": pageNumber};
        var response =
            await _userRepository.getNotification(queryData: queryData);
        if (response.status == Status.COMPLETED) {
          notificationListModel = response.data;
          if (pageNumber < notificationListModel!.totalPage!) {
            pageNumber++;
          } else {
            isLastPage = true;
          }
          BlocProvider.of<NotificationCountCubit>(
                  RouteNavigator.navigatorKey.currentState!.context)
              .updateCount(0);
          emit(NotificationListInitial());
        } else {
          emit(NotificationListError(
            response.message,
          ));
        }
      } catch (e) {
        emit(NotificationListError(e.toString()));
      }
    } else {
      emit(NotificationListInitial());
    }
    isLoading = false;
  }
}
