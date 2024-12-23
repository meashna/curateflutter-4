import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/app_constants.dart';
import '../../../data/manager/preferences_manager.dart';
import '../../../utils/routes/myNavigator.dart';
import '../../app_screens.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  int selectedIndex = 0;
  bool isPlanExpired = false;
  bool isAssementPending = false;
  bool isNotificationPermissionPending = false;
  final _preferences = GetIt.I<PreferencesManager>();
  RemoteMessage? message;
  BuildContext context;

  PageController? controller;
  MainScreenCubit(this.message, this.context)
      : super(MainScreenSelectedIndex(0)) {
    print("main page message");
    print(message);
    if (message != null) {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        String type = message!.data["type"];
        switch (int.parse(type)) {
          case 0:
            {
              print("oiuiygftghjkl;,");
              final Map<String, dynamic> data = {
                "isNotification": true,
                "questionType": AppConstants.wellbeingAssessmentQuestionType
              };
              RouteNavigator.pushNamed(context, AppScreens.wellBeingQuestions,
                  arguments: data);
              break;
            }
          case 1:
            {
              Map<String, dynamic> data = {
                "isNotification": true,
              };
              RouteNavigator.pushNamed(context, AppScreens.dayPlanScreen,
                  arguments: data);
              break;
            }
        }
      });
    }

    controller = PageController(initialPage: selectedIndex);
    if (Platform.isAndroid) {
      checkNotificationPermission();
    }
  }

  void checkNotificationPermission() {
    notificationPermissionGranted().then((value) async {
      if (!value) {
        final isNotificationPermissionAsked =
            await _preferences.isNotificationPermissionAsked();

        if (!(isNotificationPermissionAsked ?? false)) {
          isNotificationPermissionPending = true;
          emit(MainScreenSelectedIndex(selectedIndex));
        }
      } else {
        print("kjhjbjnkm");
      }
    });
  }

  setNotificationPermissionNotAskedAgain() {
    _preferences.setNotificationPermissionAsked(true);
    isNotificationPermissionPending = false;
    emit(MainScreenSelectedIndex(selectedIndex));
  }

  chnageNotipermission() {
    isNotificationPermissionPending = false;
    emit(MainScreenSelectedIndex(selectedIndex));
  }

  Future<void> setNAvigationIndex(int index) async {
    controller?.jumpToPage(index);
    selectedIndex = index;
    Future.delayed(Duration(milliseconds: 100), () {
      emit(MainScreenSelectedIndex(index));
    });
  }

  Future<bool> notificationPermissionGranted() async {
    const permission = Permission.notification;
    if (await permission.isGranted) return true;
    return false;
    //final result = await Permission.notification.request();
  }

  updateExpireView({bool isAssementPending = false}) {
    this.isAssementPending = isAssementPending;
    isPlanExpired = true;
    emit(MainScreenSelectedIndex(selectedIndex));
  }
}
