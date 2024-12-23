import 'package:curate/src/utils/extensions.dart';
import 'package:sizer/sizer.dart';

enum ProductStatus { selected, normal, notAvailable }

enum SoulWritingStatus { draft, received, companionWrites }

enum SoulWritingTextStep {
  reason,
  project,
  occasion,
  trigger,
  painPicture,
  protagonist,
  bridge,
  redline,
  rewrite,
  affirmation,
  projection,
  implementation
}

class AppConstants {
  AppConstants._();
//192.168.168.192
  static const String baseUrlDev = "http://192.168.168.192:3000/";

  //static const String baseUrlDev = "https://api.curate.health/";
  //static const String baseUrlDev = "https://curateapi.illuminz.com/";

  // static const String socketBaseUrlDev = "https://curateapi.illuminz.com/";
  static const String socketBaseUrlDev = "https://api.curate.health/";

  //static final bool isTablet = SizerUtil.deviceType == DeviceType.tablet;
  static final bool isTablet = Device.screenType == ScreenType.tablet;

  static final double defaultButtonTextSize = 6.5.sp;
  static const double defaultButtonTextSizePhone = 14;
  static final double defaultButtonHeight = 48.sp;
  static final double defaultButtonHeightPhone = 36.spt;
  static final double outlineButtonHeightPhone = 48.spt;
  static final double defaultInputDecorationPaddingVertical = 30.5.spt;
  static const double defaultInputDecorationPaddingVerticalPhone = 23;
  static final double defaultInputDecorationPaddingHorizontal = 48.spt;
  static const double defaultInputDecorationPaddingHorizontalPhone = 32;

  static const double defaultPadding = 16;

  static const String defaultFontFamily = 'Karla';
  static const String defaultCountryCode = '+966';
  static const String defaultLanguage = 'en';

  static const int nutritionActivityType = 0;
  static const int mindfulnessActivityType = 1;
  static const int fitnessActivityType = 2;
  static const int medicineActivityType = 3;

  static const int nutritionDrinkingSubtype = 0;
  static const int nutritionMealsSubtype = 1;
  static const int mindfulnessVideoSubtype = 0;
  static const int mindfulnessGratitudeSubtype = 1;
  static const int fitnessVideoSubtype = 0;
  static const int fitnessTextSubtype = 1;

  static const int homeScreenDefaultType = 0;
  static const int homeScreenMoodType = 1;

  static const int wellbeingQuestionType = 0;
  static const int moodQuestionType = 1;
  static const int wellbeingAssessmentQuestionType = 2;

  static const int assessmentNotificationType = 0;
  static const int taskNotificationType = 1;
  static const int testNotificationType = 2;

  static const String onBoardingTitle1 = 'Discover the New You';
  static const String onBoardingTitle2 =
      'A Whole Team of Experts to Address the Root Cause';
  static const String onBoardingTitle3 =
      'Track Your Progress, Boost Your Wellbeing';

  static const String onBoardingDescription1 =
      'Step onto a journey in holistic wellness — where the science of Ayurveda, yoga, and strength training meet mindful nutrition to build a better you. ';
  static const String onBoardingDescription2 =
      'Our squad ensures you no longer wonder \'why is this happening,\' helping you overcome challenges and celebrating your wins together.';
  static const String onBoardingDescription3 =
      'Calculate your well-being score and monitor your daily progress to track your Wellness journey.';

  static const String walkThroughTitle1 = 'Track your mood';
  static const String walkThroughTitle2 = 'Complete your tasks';
  static const String walkThroughTitle3 = 'Track your habits';
  static const String walkThroughTitle4 = 'Assess your Wellbeing score';
  static const String walkThroughTitle5 = 'Book consultations';
  static const String walkThroughTitle6 = 'Health coach support';
  static const String walkThroughTitle7 = 'View Progress';

  static const String walkThroughDescription1 =
      'Monitoring your mood daily can help you and us understand the impact of stress and anxiety on your PCOS symptoms';
  static const String walkThroughDescription2 =
      'Improve your well-being through small, daily tasks, and learn how to feel better through short, easy HABITS.';
  static const String walkThroughDescription3 =
      'Track your daily habits with our habit tracker.';
  static const String walkThroughDescription4 =
      'Take weekly assessment test to evaluate your overall well-being and stay on track as you make progress from week to week';
  static const String walkThroughDescription5 =
      'Keep track of and schedule appointments with your health coach, gynecologist, and mental health counselors';
  static const String walkThroughDescription6 =
      'Your health coaches are here to keep your motivation up and guide you throughout your journey with Curate';
  static const String walkThroughDescription7 =
      'By recording your weight, waist size, and menstrual cycles, you can set goals and track your progress toward achieving them';

  static const String moodJoyful = 'Joyful';
  static const String moodHappy = 'Happy';
  static const String moodNormal = 'Normal';
  static const String moodSad = 'Sad';
  static const String moodUpset = 'Upset';

  static const String wellBeingScore = 'Well-Being Score';
  static const String wellBeingAssessment = 'Wellbeing Assessment';
  static const String planTotalWeek = "planTotalWeek";
  static const String planTotalDay = "planTotalDay";
  static const String planCurrentDay = "planCurrentDay";
  static const String noInternetTitle =
      "No Internet, Please check internet connection";

  static const int emptyTick = 1;
  static const int completedTick = 2;
  static const int disabledTick = 3;
  static const int hideTick = 4;

  static const int patientWeightLog = 0;
  static const int patientPeriodLog = 1;
  static const int patientWaistLog = 2;

  //constant String
  static const String chatDescription =
      "Talk to our health coach by following this link you will be redirected to the WhatsApp application.";
}
