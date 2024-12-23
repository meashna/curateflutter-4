import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/asset_path.dart';
import '../../data/models/NotificationListModel.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import '../../utils/app_utils.dart';
import '../../utils/routes/myNavigator.dart';
import '../../widgets/app_button.dart';
import '../../widgets/fetch_more_widget.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/refresh_indicator_widget.dart';
import 'cubit/notification_list_cubit.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => NotificationListCubit(),
        child: const NotificationListScreen());
  }

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  List<Notifications> notificationList = [];
  bool _hasOpenedNotificationsSettings = false;
  bool _hasOpenedLocationSettings = false;

  @override
  Widget build(BuildContext context) {
    //return notificationPermission();
    return Scaffold(
      body: BlocConsumer<NotificationListCubit, NotificationListState>(
        listener: (context, state) {
          if (state is NotificationListLoading) {
            context.loaderOverlay.show();
          }
          if (state is NotificationListInitial) {
            context.loaderOverlay.hide();
          }
          if (state is NotificationListError) {
            context.loaderOverlay.hide();
            AppUtils.showToast(state.errorMessage);
          }
          if (state is NotificatioListnNoInternet) {
            context.loaderOverlay.hide();
          }
          if (state is NotificatioListNoPermission) {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<NotificationListCubit>(context);

          if (state is NotificationListInitial) {
            return mainContent();
          }
          if (state is NotificatioListNoPermission) {
            return notificationPermission();
          } else if (state is NotificationListLoading) {
            return Scaffold(
              appBar: appBar,
              body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.sps, vertical: 8.sps),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.sps),
                                  child: ShimmerWidget.rectangular(
                                    height: 20.sps,
                                    width: 20.sps,
                                  )),
                              Expanded(
                                  child: ShimmerWidget.rectangular(
                                      height: 20.sps)),
                            ],
                          ),
                          SizedBox(
                            height: 4.sps,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20.sps,
                                width: 20.sps,
                                margin:
                                    EdgeInsets.symmetric(horizontal: 20.sps),
                              ),
                              Expanded(
                                  child: ShimmerWidget.rectangular(
                                height: 18.sps,
                                width: 35.sps,
                              )),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          } else if (state is NotificatioListnNoInternet) {
            return Scaffold(
              body: NoInternetWidget(() {
                cubit.getNotificationData();
              }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSettingsChanges();
    }
  }

  void _checkSettingsChanges() async {
    if (_hasOpenedNotificationsSettings) {
      _hasOpenedLocationSettings = false;
      if (!await Permission.notification.isGranted) {
        return;
      }
      var cubit = BlocProvider.of<NotificationListCubit>(context);
      cubit.getNotificationData();
    }
  }

  Future<void> _handleOpenSettings(Permission permission) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: permission == Permission.notification
              ? const Text(
                  "Enable push notifications to stay in the loop, appointments with experts, support, get reminders to keep your practice going")
              : const Text("Your rationale message for location permission"),
          actions: <Widget>[
            TextButton(
              child: const Text("Settings"),
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openAppSettings(type: AppSettingsType.notification);

                // Declare _hasOpenedNotificationsSettings = false && _hasOpenedLocationSettings = false
                // at the top of your class

                if (permission == Permission.notification) {
                  _hasOpenedNotificationsSettings = true;
                }
                if (permission == Permission.locationWhenInUse) {
                  _hasOpenedLocationSettings = true;
                }
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _ensureNotificationsPermission() async {
    const permission = Permission.notification;
    if (await permission.isGranted) return true;

    if (await permission.isDenied) {
      await _handleOpenSettings(permission);
      return false;
    }
    print("permission");
    print(permission);
    if (await permission.isPermanentlyDenied) {
      print("jihugyftdrfcgvhbjk");
      await _handleOpenSettings(permission);
      return false;
    }

    if (await permission.shouldShowRequestRationale) {
      print("kpojihougiyvjhb");
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your title here"),
            content: Text("Your rationale message here"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Ok"),
              ),
            ],
          );
        },
      );

      return await permission.request().isGranted;
    }

    final granted = await permission.request();

    return granted.isGranted;
  }
/*
  Widget notificationPermission(){
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(image: AssetImage(ImageAssetPath.icSplashBackground)),
                        ],
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.only(top: 75.sps,right: 0.sps),
                            child: Text("Notifications", style: $styles.text.h6.copyWith(color: AppColors.blackColor))),
                      )
                    ],
                  ),
                  Center(child: Image.asset(ImageAssetPath.icOnboarding2)),
                  SizedBox(height: 50.sps),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.sps),
                    child: Text(
                      "Curate users who receive our notifications are more likely to stick to new habits",
                      textAlign: TextAlign.center,
                      style: $styles.text.h6.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  SizedBox(height: 16.sps),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.sps),
                    child: Text(
                      "Enable push notifications to stay in the loop, appointments with experts, support, get reminders to keep your practice going",
                      textAlign: TextAlign.center,
                      style: $styles.text.body2.copyWith(color: AppColors.darkGreyColor),
                    ),
                  ),
                  SizedBox(height: 16.sps)
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 16.sps,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:16.sps),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Turn on notifications",
                  onClicked: () async {
                    var cubit = BlocProvider.of<NotificationListCubit>(context);
                    if(Platform.isAndroid){
                      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                      var result = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
                      print("result");
                      print(result);
                      if(result != null){
                        if(result){
                          cubit.loadNotificationWithSkelton();
                        }else{
                          var permissionResult = await _ensureNotificationsPermission();
                          if(permissionResult){
                            cubit.loadNotificationWithSkelton();
                          }/*else{
                          var permissionResult = await _ensureNotificationsPermission();
                          if(permissionResult){
                            cubit.loadNotificationWithSkelton();
                          }
                        }*/
                        }
                      }
                    }else{
                      AppSettings.openAppSettings(type: AppSettingsType.notification);
                    }
                  },
                ),
              ),
              SizedBox(height: 8.sps,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:16.sps),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("May be later",style: $styles.text.h9.copyWith(color: AppColors.blackColor),),
                  ),
                ),
              ),
              SizedBox(height: 16.sps)
            ],
          )
        ],
      ),
    );
  }*/

  Widget notificationPermission() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              image: AssetImage(
                                  ImageAssetPath.icSplashBackground)),
                        ],
                      ),
                      Center(
                        child: Container(
                            padding: EdgeInsets.only(top: 75.sps, right: 0.sps),
                            child: Text("Notifications",
                                style: $styles.text.h6
                                    .copyWith(color: AppColors.blackColor))),
                      )
                    ],
                  ),
                  Center(child: Image.asset(ImageAssetPath.icOnboarding2)),
                  SizedBox(height: 50.sps),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.sps),
                    child: Text(
                      "Curate users who receive our notifications are more likely to stick to new habits",
                      textAlign: TextAlign.center,
                      style:
                          $styles.text.h6.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  SizedBox(height: 16.sps),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.sps),
                    child: Text(
                      "Enable push notifications to stay in the loop, appointments with experts, support, get reminders to keep your practice going",
                      textAlign: TextAlign.center,
                      style: $styles.text.body2
                          .copyWith(color: AppColors.darkGreyColor),
                    ),
                  ),
                  SizedBox(height: 16.sps)
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 16.sps),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Turn on notifications",
                  onClicked: () async {
                    var cubit = BlocProvider.of<NotificationListCubit>(context);

                    if (Platform.isAndroid) {
                      // Request notification permission using permission_handler
                      var status = await Permission.notification.request();
                      print("Notification Permission Status: $status");

                      if (status.isGranted) {
                        cubit.loadNotificationWithSkelton();
                      } else if (status.isDenied) {
                        // Optionally, show rationale or handle denial
                        var permissionResult =
                            await _ensureNotificationsPermission();
                        if (permissionResult) {
                          cubit.loadNotificationWithSkelton();
                        }
                      } else if (status.isPermanentlyDenied) {
                        // Open app settings for the user to manually enable permissions
                        await _handleOpenSettings(Permission.notification);
                      }
                    } else {
                      // For iOS, open app settings or handle accordingly
                      AppSettings.openAppSettings(
                          type: AppSettingsType.notification);
                    }
                  },
                ),
              ),
              SizedBox(height: 8.sps),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "May be later",
                      style:
                          $styles.text.h9.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.sps),
            ],
          ),
        ],
      ),
    );
  }

  Widget mainContent() {
    var cubit = BlocProvider.of<NotificationListCubit>(context);
    var response =
        BlocProvider.of<NotificationListCubit>(context).notificationListModel;

    if (response != null && response.notifications != null) {
      if (cubit.isRefresh) {
        notificationList = response.notifications!;
      } else {
        notificationList.addAll(response.notifications ?? []);
      }
    }
    if (notificationList.isEmpty) {
      return Scaffold(
        appBar: appBar,
        body: NoDataWidget(
            image: ImageAssetPath.icEmptyNotification,
            title: "No notifications"),
      );
    }
    return Scaffold(
      appBar: appBar,
      body: CustomRefresIndicator(
        onRefresh: () => cubit.getNotificationData(isRefresh: true),
        child: FetchMoreIndicator(
          isLastPage: cubit.isLastPage,
          onAction: cubit.getNotificationData,
          child: Container(
            color: AppColors.screenBackground,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20.sps),
                itemCount: notificationList.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: AppColors.lightestGrey1,
                  );
                },
                itemBuilder: (context, index) {
                  String? createdDate = notificationList[index].createdAt;
                  String beforeTime =
                      DateTimeUtils.timeAgoSinceDateApi(createdDate);
                  return GestureDetector(
                    onTap: () {
                      var notificationType =
                          notificationList[index].historyNotification?.type;
                      if (notificationType ==
                          AppConstants.assessmentNotificationType) {
                        final Map<String, dynamic> data = {
                          "isNotification": true,
                          "questionType":
                              AppConstants.wellbeingAssessmentQuestionType
                        };
                        Navigator.pushNamed(
                            context, AppScreens.wellBeingQuestions,
                            arguments: data);
                      } else if (notificationType ==
                          AppConstants.taskNotificationType) {
                        Map<String, dynamic> data = {
                          "isNotification": true,
                          "todoOrderId":
                              notificationList[index].data?.todoOrderId,
                          "taskId":
                              notificationList[index].data?.todoListTaskId,
                        };
                        Navigator.pushNamed(context, AppScreens.dayPlanScreen,
                            arguments: data);
                      }
                    },
                    child: Container(
                      color: AppColors.screenBackground,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.sps),
                                  child: SvgPicture.asset(
                                    "assets/svg/notification.svg",
                                    height: 20.sps,
                                    width: 20.sps,
                                  )),
                              notificationList[index]
                                          .historyNotification!
                                          .description ==
                                      null
                                  ? Container()
                                  : Text(
                                      notificationList[index]
                                              .historyNotification!
                                              .description ??
                                          "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: $styles.text.noti_title.copyWith(
                                          color: AppColors.blackColor)),
                            ],
                          ),
                          SizedBox(
                            height: 4.sps,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20.sps,
                                width: 20.sps,
                                margin:
                                    EdgeInsets.symmetric(horizontal: 20.sps),
                              ),
                              Text(beforeTime,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: $styles.text.body2.copyWith(
                                      color: AppColors.lightGreyColor)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

AppBar appBar = AppBar(
  backgroundColor: AppColors.screenBackground,
  elevation: 0,
  leading: GestureDetector(
    onTap: () {
      RouteNavigator.goBack();
    },
    child: Container(
      width: 50.sps,
      height: 50.sps,
      margin: EdgeInsets.only(left: 16.sps),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
      ),
      child: Image.asset(ImageAssetPath.icBack, width: 20.sps, height: 20.sps),
    ),
  ),
  title: Text("Notifications",
      style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
  centerTitle: true,
  actions: [],
);
