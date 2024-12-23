import 'dart:convert';
import 'dart:developer';

import 'package:curate/src/utils/app_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:curate/main.dart';

import '../../constants/app_constants.dart';
import '../../screens/app_screens.dart';
import '../routes/myNavigator.dart';
import 'notification_count_bloc/notification_count_cubit.dart';

class PushNotificationService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      PushNotificationService._firebaseMessaging ?? FirebaseMessaging.instance;

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
/*    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      try{
        BlocProvider.of<NotificationCountCubit>(RouteNavigator.navigatorKey.currentState!.context).increaseCount();
        _handleMessage(initialMessage.data);
        AppUtils.showToast("data - " +initialMessage.data.toString());
      }catch(e){
        AppUtils.showToast("getInitialMessagee error" +e.toString());
        print(e);
      }
    }*/
    enableIOSNotifications();
    await registerNotificationListeners();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // var data = jsonDecode(message.data);
      print("message.data");
      print(message.data);
      String type = message.data["type"];

      BlocProvider.of<NotificationCountCubit>(
              RouteNavigator.navigatorKey.currentState!.context)
          .increaseCount();
      switch (int.parse(type)) {
        case 0:
          {
            final Map<String, dynamic> data = {
              "isNotification": true,
              "questionType": AppConstants.wellbeingAssessmentQuestionType
            };
            Navigator.pushNamed(
                RouteNavigator.navigatorKey.currentState!.context,
                AppScreens.wellBeingQuestions,
                arguments: data);
            break;
          }
        case 1:
          {
            Map<String, dynamic> data = {
              "isNotification": true,
            };

            Navigator.pushNamed(
                RouteNavigator.navigatorKey.currentState!.context,
                AppScreens.dayPlanScreen,
                arguments: data);
            break;
          }
      }
    });
  }

  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      BlocProvider.of<NotificationCountCubit>(
              RouteNavigator.navigatorKey.currentState!.context)
          .increaseCount();
      print(
          'firebase_message foreground and a notification is received- $message');
      final RemoteNotification? notification = message!.notification;
      print(message.data);

      print(message.notification!.body);
      print(message.notification!.title);
      /* print(json.decode(message.data["data"])["eventId"]);
      print("fdfgchvjklp;");*/
      final AndroidNotification? android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                priority: Priority.high,
                enableVibration: true,
              ),
            ),
            payload: jsonEncode(message.data));
      }
    });
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      /*  onDidReceiveBackgroundNotificationResponse: (NotificationResponse details){

      },*/
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        print("notification details");
        try {
          // print(jsonDecode(details.payload));
          print("mjhugyfcgvhbjkl;");
          print(details.payload);
          Map<String, dynamic> map = jsonDecode(details.payload ?? "");
          _handleMessage(map);
        } catch (e) {
          print(e);
        }
      },
    );
  }

  void _handleMessage(Map<String, dynamic> data) {
    print("jihugyftcgvbhjnkml,");
    print(data["type"]);
    switch (int.parse(data["type"])) {
      case AppConstants.assessmentNotificationType:
        {
          final Map<String, dynamic> data = {
            "isNotification": true,
            "questionType": AppConstants.wellbeingAssessmentQuestionType
          };
          print("koijhugyhjkjlk;,;,");
          Navigator.pushNamed(RouteNavigator.navigatorKey.currentState!.context,
              AppScreens.wellBeingQuestions,
              arguments: data);
          break;
        }
      case AppConstants.taskNotificationType:
        {
          Map<String, dynamic> data = {
            "isNotification": true,
          };
          print("oiuogyvhjbknl;',");
          Navigator.pushNamed(RouteNavigator.navigatorKey.currentState!.context,
              AppScreens.dayPlanScreen,
              arguments: data);
          break;
        }
    }
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'curate.com', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
        enableVibration: true,
      );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message,
    {BuildContext? context}) async {
  await Firebase.initializeApp();
  if (RouteNavigator.navigatorKey.currentState != null) {
    BlocProvider.of<NotificationCountCubit>(
            RouteNavigator.navigatorKey.currentState!.context)
        .increaseCount();
  }
  print("Handling a background message: ${message.messageId}");
}
