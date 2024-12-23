import 'dart:io';

import 'package:flag/flag_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:readmore/readmore.dart';
import 'package:vibration/vibration.dart';

import '../constants/app_constants.dart';
import '../data/models/app_language.dart';
import '../localization/app_localization_manager.dart';
import '../styles/colors.dart';
import 'package:html/parser.dart';

import '../styles/styles.dart';

class AppUtils {
  AppUtils._();

  static FlagsCode getCode(String code) {
    var value = FlagsCode.NULL;
    for (var element in FlagsCode.values) {
      print("element");
      print(element);
      print(element.toString().split(".").last.toLowerCase());
      print(code);
      if (element.toString().split(".").last.toLowerCase() ==
          code.toLowerCase()) {
        value = element;
      }
    }
    return value;
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static Widget moreText(String text) {
    return ReadMoreText(
      text,
      trimLines: 3,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      style: $styles.text.title1.copyWith(color: AppColors.darkGrey),
      lessStyle: $styles.text.title1.copyWith(color: AppColors.primary),
      moreStyle: $styles.text.title1.copyWith(color: AppColors.primary),
    );
  }

  static int getDeviceType() {
    if (Platform.isAndroid) {
      return 1;
    } else if (Platform.isIOS) {
      return 2;
    } else {
      return -1;
    }
  }

  static String getEmptyBoardLink() {
    String lang = AppLocalizationManager.isCurrentEnglish ? 'en' : 'ar';
    return 'https://board.learnwaw.com/?letter=0&$lang';
  }

  static Future<String?> getDeviceId() async {
    return PlatformDeviceId.getDeviceId;
  }

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static List<AppLanguage> getLanguages() {
    return [
      AppLanguage(name: 'English', code: 'en'),
      AppLanguage(name: 'عربي', code: 'ar'),
    ];
  }

  static void showSnackBar(BuildContext context, String? text) {
    if (text != null && text.isNotEmpty) {
      final snackBar = SnackBar(content: Text(text));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<void> vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        if (await Vibration.hasAmplitudeControl() ?? false) {
          Vibration.vibrate(duration: 50, amplitude: 128);
        } else {
          Vibration.vibrate(duration: 50);
        }
      } else {
        if (await Vibration.hasAmplitudeControl() ?? false) {
          Vibration.vibrate(amplitude: 128);
          /* await Future.delayed(Duration(milliseconds: 500));
          Vibration.vibrate(amplitude: 128);*/
        } else {
          Vibration.vibrate();
          /*  await Future.delayed(Duration(milliseconds: 500));
          Vibration.vibrate();*/
        }
      }
    }
  }

  static void showToast(String? text, {Color? bgColor}) {
    if (text != null && text.isNotEmpty) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  static Widget progressHudWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }

  static getLevelLinks({
    required int levelIndex,
    required String letterNumber,
    required int mode,
    required String letterId,
    required int index,
  }) {
    String link = '';
    String lang = AppLocalizationManager.isCurrentEnglish ? 'en' : 'ar';

    switch (levelIndex) {
      case 2: // FOUNDATION
        link =
            'https://board.learnwaw.com/?letter=0_i_$letterNumber&mode=$mode&lang=$lang';
        break;
      case 3: // Individuals Letters
        link =
            'https://board.learnwaw.com/?letter=$letterNumber&mode=$mode&lang=$lang';
        break;
      case 4: // Connected Letters
        link =
            'https://board.learnwaw.com/?&mode=$mode&letter=${letterId}_c_$letterNumber&lang=$lang';
        break;
      case 5: // Words
        link =
            'https://board.learnwaw.com/?&mode=$mode&letter=word_$index&lang=$lang';
        break;
      case 6: // Sentences
        link = 'https://board.learnwaw.com/?&mode=5&letter=$index&lang=$lang';
        break;
    }
    return link;
  }
}
