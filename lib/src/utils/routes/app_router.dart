import 'package:curate/src/screens/expert_talk/expert_talk_screen.dart';
import 'package:curate/src/screens/get_started_screen.dart';
import 'package:curate/src/screens/login/onboarding/views/onboarding_screen.dart';
import 'package:curate/src/screens/login/personalDetail/personal_details_screen.dart';
import 'package:curate/src/screens/login/signin/signin_phone_screen.dart';
import 'package:curate/src/screens/mainscreen/home/home_screen.dart';
import 'package:curate/src/screens/mainscreen/home/moodDetails/MoodDetailsScreen.dart';
import 'package:curate/src/screens/mainscreen/main_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/gratitude/gratitude_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/workout/workout_activities_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_screen/DayPlanScreen.dart';
import 'package:curate/src/screens/mainscreen/profile/editPhoneNo/otp/phone_otp_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/editPhoneNo/updatePhone/update_phone_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/editProfile/edit_profile_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/periodLog/addlog/addCalendar/add_calendar_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/periodLog/addlog/addFlow/period_flow_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/periodLog/period_log_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/waistLog/waist_log_screen.dart';
import 'package:curate/src/screens/mainscreen/profile/weightLog/weight_log_screen.dart';
import 'package:curate/src/screens/notification_list/notification_list_screen.dart';

import 'package:curate/src/screens/packages/choose_package/choose_package_screen.dart';
import 'package:curate/src/screens/packages/payment_screen1.dart';
import 'package:curate/src/screens/packages/payment_screen.dart';
import 'package:curate/src/screens/login/otp/signin_otp_screen.dart';
import 'package:curate/src/screens/walkthrough/walkthrough_screen.dart';
import 'package:curate/src/screens/welcome_screen.dart';
import 'package:curate/src/screens/well_being_score/wellbeing_intro_screen.dart';
import 'package:curate/src/widgets/webview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import '../../data/models/response/healthLog/HealthLogData.dart';
import '../../screens/app_screens.dart';
import '../../screens/well_being_score/calculte_wellbeing_score.dart';
import '../../screens/well_being_score/component/wellbeing_questions.dart';
import '../../screens/well_being_score/diagnose_now_screen.dart';
import '../../screens/well_being_score/wellbeing_assessment/calculate_wellbeing_assessment.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    // final isTablet = sizerUtil.deviceType == ScreenType.tablet;
    final isTablet = Device.screenType == ScreenType.tablet;

    switch (settings.name) {
      case AppScreens.onBoarding:
        return _buildRoute(
          settings,
          OnBoardingScreen(),
        );

      case AppScreens.welcome:
        return _buildRoute(settings, WelcomeScreen());

      case AppScreens.signIn:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, SignInScreen1.create(arguments));

      case AppScreens.otpVerification:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, OTPVerificationScreen.create(arguments));

      case AppScreens.personalDetails:
        return _buildRoute(settings, PersonalDetails1.create());

      case AppScreens.wellBeingIntroScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, WellbeingIntroScreen(data: arguments));

      case AppScreens.homeScreen:
        return _buildRoute(settings, const HomeScreen());

      case AppScreens.wellBeingQuestions:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            WellBeingQuestions(
              data: arguments,
            ));

      case AppScreens.wellBeingAssessment:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            CalculateWellbeingAssessment(
              data: arguments,
            ));

      case AppScreens.diagnoseNow:
        return _buildRoute(settings, const DiagnoseNowScreen());

      case AppScreens.calculateWellbeingScore:
        return _buildRoute(settings, const CalculateWellbeingScore());

      case AppScreens.choosePlan:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(settings, ChoosePackageScreen.create(arguments));

      case AppScreens.payment:
        {
          final arguments = settings.arguments as Map<String, dynamic>;
          return _buildRoute(
              settings,
              PaymentScreen(
                mapData: arguments,
              ));
        }

      case AppScreens.expertPayment:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, PaymentScreen1(data: arguments));

      case AppScreens.getStarted:
        return _buildRoute(settings, const GetStartedScreen());

      case AppScreens.walkThrough:
        return _buildRoute(settings, const WalkthroughScreen());

      case AppScreens.talkExpert:
        return _buildRoute(settings, ExpertTalkScreen.create());

      case AppScreens.dayPlanScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, DayPlanScreen.create(arguments));

      case AppScreens.gratitudeDetailsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, GratitudeActivityScreen.create(arguments));

      case AppScreens.workoutActivity:
        final arguments = settings.arguments as Map<String, dynamic>;

        return _buildRoute(settings, WorkoutActivityScreen.create(arguments));

      case AppScreens.moodDetails:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, MoodDetailsScreen.create(arguments));

      case AppScreens.mainScreen:
        final arguments = settings.arguments as RemoteMessage?;
        return _buildRoute(settings, MainScreen.create(arguments));

      case AppScreens.periodLog:
        return _buildRoute(settings, PeriodLogScreen.create());

      case AppScreens.weightLog:
        return _buildRoute(settings, WeightLogScreen.create());

      case AppScreens.waistLog:
        return _buildRoute(settings, WaistLogScreen.create());

      case AppScreens.editProfile:
        return _buildRoute(settings, EditProfileScreen.create());

      case AppScreens.calendarAddLog:
        var data = settings.arguments as HealthLogData?;
        return _buildRoute(settings, AddCalendarScreen(data: data));
      case AppScreens.updatePhone:
        return _buildRoute(settings, UpdatePhoneScreen.create());

      case AppScreens.webView:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, WebView(data: arguments));

      case AppScreens.phoneOtp:
        final arguments = settings.arguments as Map<String, dynamic>;
        return _buildRoute(settings, PhoneOTPScreen.create(arguments));

      case AppScreens.flowAddLog:
        {
          final arguments = settings.arguments as Map<String, dynamic>;
          return _buildRoute(settings, PeriodFlowScreen.create(arguments));
        }
      case AppScreens.notification:
        {
          // final arguments = settings.arguments as List<DateTime?>;
          return _buildRoute(settings, NotificationListScreen.create());
        }
      default:
        return _buildRoute(
            settings,
            Scaffold(
              body: Container(
                child: Center(
                  child: Text("No Route find"),
                ),
              ),
            ));
    }
  }

  CupertinoPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}
