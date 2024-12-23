import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/mainscreen/chat/chat_screen.dart';

import 'package:curate/src/screens/mainscreen/home/home_screen.dart';
import 'package:curate/src/screens/mainscreen/mainCubit/main_screen_cubit.dart';
import 'package:curate/src/screens/mainscreen/myplan/my_plan_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/editProfile/edit_profile_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/profile_screen.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/app_constants.dart';
import '../../data/manager/preferences_manager.dart';
import '../../data/repository/user_repo/user_repository.dart';
import '../../utils/order_socket/order_socket_cubit.dart';
import '../../utils/order_socket/order_socket_state.dart';
import '../../utils/routes/myNavigator.dart';
import '../../widgets/app_button.dart';
import '../app_screens.dart';
import '../notification_list/cubit/notification_list_cubit.dart';

class MainScreen extends StatefulWidget {
  final RemoteMessage? message;
  const MainScreen({super.key, this.message});

  @override
  State<MainScreen> createState() => _MainScreenState();

  static Widget create(RemoteMessage? message) {
    return BlocProvider(
        create: (BuildContext context) => MainScreenCubit(message, context),
        child: MainScreen(
          message: message,
        ));
  }
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenCubit cubit;
  List<Widget> bottomBarItems = [];
  bool _hasOpenedNotificationsSettings = false;
  bool _hasOpenedLocationSettings = false;

  @override
  void initState() {
    super.initState();

    var chatScreen = ChatScreen.create();
    var profileScreen = ProfileScreen.create();
    bottomBarItems.add(HomeScreen.create());
    bottomBarItems.add(MyPlanScreen.create());
    bottomBarItems.add(chatScreen);
    bottomBarItems.add(profileScreen);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSettingsChanges();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OrderSocketCubit, OrderSocketState>(
        builder: (socketContext, socketState) {
          return BlocConsumer<MainScreenCubit, MainScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              cubit = BlocProvider.of<MainScreenCubit>(context);
              // currentIndex= (state as MainScreenSelectedIndex).index;
              int currentIndex = (state as MainScreenSelectedIndex).index;
              bool isPlanExpired = cubit.isPlanExpired;
              if (cubit.isNotificationPermissionPending) {
                return notificationPermission();
              }
              if (isPlanExpired) {
                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              24.sps, 16.sps, 16.sps, 16.sps),
                          child: GestureDetector(
                              onTap: () async {
                                await showLogoutDialog();
                              },
                              child: SvgPicture.asset(ImageAssetPath.icLogout,
                                  height: 20.sps, width: 20.sps)))
                    ],
                  ),
                  body: Center(
                    child: Card(
                      surfaceTintColor: AppColors.white,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(ImageAssetPath.icPlanExpired),
                            SizedBox(
                              height: 20.sps,
                            ),
                            Text(
                                "Your plan has expired.Please renew you plan."),
                            SizedBox(
                              height: 20.sps,
                            ),
                            SizedBox(
                              height: 45.sps,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    //side: BorderSide(color: Colors.red)
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppScreens.choosePlan);
                                },
                                child: Text(
                                  "Choose plan",
                                  style: $styles.text.h9
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.sps,
                            ),
                            Visibility(
                              visible: (cubit.isAssementPending),
                              //visible: (true),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Wellbeing Assessment",
                                      style: $styles.text.h6.copyWith(
                                          color: AppColors.blackColor)),
                                  SizedBox(height: 16.sps),
                                  getWellBeingAssessment()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Scaffold(
                bottomNavigationBar: getMainContent(),
                body: SafeArea(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: cubit.controller,
                    children: bottomBarItems,
                  ),
                ),
              );
            },
          );
        },
        listener: (socketContext, socketState) {
          if (socketState.isDataLoaded) {
            context.loaderOverlay.hide();
            print("socketState.data");
            print(socketState.data);
            showAlertDialog(socketContext, socketState.data!);
          }
        },
      ),
    );
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
        context: context,
        //barrierDismissible:false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Logout",
              style: $styles.text.h10.copyWith(color: AppColors.blackColor),
            ),
            content: Text("Are you sure you want to log out?",
                style:
                    $styles.text.title2.copyWith(color: AppColors.blackColor)),
            actions: [
              TextButton(
                  onPressed: () {
                    RouteNavigator.goBack();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("No",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
              TextButton(
                  onPressed: () {
                    /*835023032832*/ /*4353217896*/
                    final userRepository = GetIt.I<UserRepository>();
                    final preferences = GetIt.I<PreferencesManager>();
                    RouteNavigator.goBack();
                    userRepository.logout();
                    preferences.logout();

                    RouteNavigator.popAllAndToReStart(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("Yes",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
            ],
            insetPadding: EdgeInsets.symmetric(horizontal: 16.sps),
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        });
  }

  /*Widget notificationPermission() {
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
              SizedBox(
                height: 16.sps,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Turn on notifications",
                  onClicked: () async {
                    var cubit = BlocProvider.of<MainScreenCubit>(context);
                    if (Platform.isAndroid) {
                      final FlutterLocalNotificationsPlugin
                          flutterLocalNotificationsPlugin =
                          FlutterLocalNotificationsPlugin();
                      var result = await flutterLocalNotificationsPlugin
                          .resolvePlatformSpecificImplementation<
                              AndroidFlutterLocalNotificationsPlugin>()
                          ?.requestPermission();
                      print("result");
                      print(result);
                      if (result != null) {
                        if (result) {
                          cubit.setNotificationPermissionNotAskedAgain();
                        } else {
                          var permissionResult =
                              await _ensureNotificationsPermission();
                          if (permissionResult) {
                            cubit.setNotificationPermissionNotAskedAgain();
                          } /*else{
                          var permissionResult = await _ensureNotificationsPermission();
                          if(permissionResult){
                            cubit.loadNotificationWithSkelton();
                          }
                        }*/
                        }
                      }
                    } else {
                      AppSettings.openAppSettings(
                          type: AppSettingsType.notification);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8.sps,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      var cubit = BlocProvider.of<MainScreenCubit>(context);
                      cubit.setNotificationPermissionNotAskedAgain();
                    },
                    //child: Text("May be later",style: $styles.text.h9.copyWith(color: AppColors.blackColor),),
                    //change color to while
                    child: Text(
                      "May be later",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
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
                    var cubit = BlocProvider.of<MainScreenCubit>(context);

                    if (Platform.isAndroid) {
                      // Request notification permission using permission_handler
                      var status = await Permission.notification.request();
                      print("Notification Permission Status: $status");

                      if (status.isGranted) {
                        cubit.setNotificationPermissionNotAskedAgain();
                      } else if (status.isDenied) {
                        // Optionally, show rationale or handle denial
                        var permissionResult =
                            await _ensureNotificationsPermission();
                        if (permissionResult) {
                          cubit.setNotificationPermissionNotAskedAgain();
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
                      var cubit = BlocProvider.of<MainScreenCubit>(context);
                      cubit.setNotificationPermissionNotAskedAgain();
                    },
                    child: Text(
                      "May be later",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
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

  void _checkSettingsChanges() async {
    if (_hasOpenedNotificationsSettings) {
      _hasOpenedLocationSettings = false;
      if (!await Permission.notification.isGranted) {
        return;
      }
      var cubit = BlocProvider.of<MainScreenCubit>(context);
      cubit.setNotificationPermissionNotAskedAgain();
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

  showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment status"),
      content: Text(
          data["status"] == 6 ? "Payment successfull." : "Payment failed."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget getMainContent() {
    return Padding(
      padding: EdgeInsets.only(right: 8.sps, left: 8.sps, bottom: 8.sps),
      child: Container(
        height: 64.sps,
        color: AppColors.screenBackground,
        child: CustomNavigationBar(
            selectedColor: AppColors.primary,
            unSelectedColor: AppColors.secondaryGreyColor,
            backgroundColor: AppColors.lightGreyColor1,
            borderRadius: const Radius.circular(40),
            strokeColor: AppColors.primary,
            currentIndex: cubit.selectedIndex,
            onTap: (index) {
              cubit.setNAvigationIndex(index);
              //_controller.jumpToPage(index);
            },
            items: [
              CustomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssetPath.ivHomeUnselected),
                selectedIcon: SvgPicture.asset(ImageAssetPath.ivHomeSelected),
                selectedTitle: Text(
                  "Home",
                  style: $styles.text.title5.copyWith(color: AppColors.primary),
                ),
                title: Text(
                  "Home",
                  style: $styles.text.body4
                      .copyWith(color: AppColors.secondaryGreyColor),
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssetPath.ivPlanUnselected),
                selectedIcon: SvgPicture.asset(ImageAssetPath.ivPlanSelected),
                selectedTitle: Text(
                  "My Plan",
                  style: $styles.text.title5.copyWith(color: AppColors.primary),
                ),
                title: Text(
                  "My Plan",
                  style: $styles.text.body4
                      .copyWith(color: AppColors.secondaryGreyColor),
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssetPath.ivChatUnselected),
                selectedIcon: SvgPicture.asset(ImageAssetPath.ivChatSelected),
                selectedTitle: Text(
                  "Chat",
                  style: $styles.text.title5.copyWith(color: AppColors.primary),
                ),
                title: Text(
                  "Chat",
                  style: $styles.text.body4
                      .copyWith(color: AppColors.secondaryGreyColor),
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(ImageAssetPath.ivProfileUnselected),
                selectedIcon:
                    SvgPicture.asset(ImageAssetPath.ivProfileSelected),
                selectedTitle: Text(
                  "Profile",
                  style: $styles.text.title5.copyWith(color: AppColors.primary),
                ),
                title: Text(
                  "Profile",
                  style: $styles.text.body4
                      .copyWith(color: AppColors.secondaryGreyColor),
                ),
              ),
            ]),
      ),
    );
  }

  Widget getWellBeingAssessment() {
    return GestureDetector(
      onTap: () {
        final Map<String, dynamic> data = {
          "questionType": AppConstants.wellbeingAssessmentQuestionType
        };
        Navigator.pushNamed(context, AppScreens.wellBeingQuestions,
            arguments: data);

        /*  List<WeeklyAssessmentScore>? assessmentHistory=[];
        for(int i=0;i<1;i++){
          assessmentHistory.add(WeeklyAssessmentScore(week: i+1,percentIncrement: i*10));
        }
        Map<String,dynamic> argument={
          //"scores":result.data?.assessmentHistory
          "scores":assessmentHistory
        };

        RouteNavigator.pushNamed(
            context, AppScreens.wellBeingAssessment,arguments: argument);*/
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.primary,
        child: Padding(
          padding: EdgeInsets.all(16.sps),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.white, shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(15.sps),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      ImageAssetPath.icTimer,
                      height: 20.sps,
                      width: 20.sps,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.sps),
              Text("Next Assessment in 7 days.",
                  style: $styles.text.h8.copyWith(color: AppColors.white))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
