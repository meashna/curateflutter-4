import 'package:curate/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_constants.dart';

final ThemeData theme = _buildAppTheme();
ThemeData _buildAppTheme() {
  ThemeData theme = ThemeData(
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  );

  theme = theme.copyWith(
      // primaryColor: AppColors.primary,
      appBarTheme: _appBarTheme(theme),
      elevatedButtonTheme: _elevatedButtonTheme(theme),
      outlinedButtonTheme: _outlinedButtonTheme(theme),
      textButtonTheme: _textButtonTheme(theme),
      textTheme: _textTheme(theme),
      inputDecorationTheme: _inputDecorationTheme(theme),
      tabBarTheme: _tabBarTheme(theme),
      checkboxTheme: _checkboxTheme(theme),
      switchTheme: _switchTheme(theme),
      scaffoldBackgroundColor: AppColors.white,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
      radioTheme: RadioThemeData());

  return theme;
}

TextTheme _textTheme(ThemeData theme) {
  return theme.textTheme.copyWith();
}

SwitchThemeData _switchTheme(ThemeData theme) {
  return theme.switchTheme.copyWith();
}

AppBarTheme _appBarTheme(ThemeData theme) {
  return theme.appBarTheme.copyWith(
    elevation: 4.0,
    toolbarHeight: 84,
    backgroundColor: AppColors.white,

    surfaceTintColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.white,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
    //color: AppColors.white,
    foregroundColor: AppColors.darkestGrey,
    titleSpacing: 0,
    centerTitle: false,
    shadowColor: Colors.black26,

    /*theme.textTheme.copyWith(
      headline6: theme.textTheme.headline6!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),*/

    iconTheme: const IconThemeData(color: AppColors.primary),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme(ThemeData theme) {
  //final isTablet = SizerUtil.deviceType == DeviceType.tablet;
  //Device.screenType == ScreenType.tablet
  final isTablet = Device.screenType == ScreenType.tablet;
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: TextStyle(
            fontSize: isTablet
                ? AppConstants.defaultButtonTextSize
                : AppConstants.defaultButtonTextSizePhone,
            fontWeight: FontWeight.bold,
            fontFamily: AppConstants.defaultFontFamily),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(
            64.0,
            isTablet
                ? AppConstants.defaultButtonHeight
                : AppConstants.defaultButtonHeightPhone),
        padding: EdgeInsets.symmetric(horizontal: 24.spt)),
  );
}

OutlinedButtonThemeData _outlinedButtonTheme(ThemeData theme) {
  final isTablet = Device.screenType == ScreenType.tablet;
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 24.spt, vertical: 16.spt),
      side: BorderSide(color: AppColors.primary),
      backgroundColor: AppColors.primary,
      textStyle: TextStyle(
          fontSize: isTablet
              ? AppConstants.defaultButtonTextSize
              : AppConstants.defaultButtonTextSizePhone,
          fontWeight: FontWeight.bold,
          fontFamily: AppConstants.defaultFontFamily),
      /* minimumSize:  Size(
          MediaQuery.of(ap).size.width,
          isTablet
              ? AppConstants.defaultButtonHeight
              : AppConstants.defaultButtonHeightPhone),*/

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  );
}

CheckboxThemeData _checkboxTheme(ThemeData data) {
  return CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    fillColor: WidgetStateProperty.all(AppColors.primary),
  );
}

TextButtonThemeData _textButtonTheme(ThemeData theme) {
  final isTablet = Device.screenType == ScreenType.tablet;
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.darkGrey,
      textStyle: TextStyle(
          fontSize: isTablet
              ? AppConstants.defaultButtonTextSize.spt
              : AppConstants.defaultButtonTextSizePhone.spt,
          fontWeight: FontWeight.bold,
          fontFamily: AppConstants.defaultFontFamily),
      minimumSize: Size(
          64.0,
          isTablet
              ? AppConstants.defaultButtonHeight
              : AppConstants.defaultButtonHeightPhone),
      shape: const StadiumBorder(),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(ThemeData theme) {
  final isTablet = Device.screenType == ScreenType.tablet;
  return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        vertical: isTablet
            ? AppConstants.defaultInputDecorationPaddingVertical
            : AppConstants.defaultInputDecorationPaddingVerticalPhone,
        horizontal: isTablet
            ? AppConstants.defaultInputDecorationPaddingHorizontal
            : AppConstants.defaultInputDecorationPaddingHorizontalPhone,
      ),
      fillColor: AppColors.darkGrey,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64.0),
      ),
      labelStyle: $styles.text.body2.copyWith(color: AppColors.blackColor),
      hintStyle: $styles.text.body2.copyWith(color: AppColors.lightGreyColor));
}

TabBarTheme _tabBarTheme(ThemeData theme) {
  return TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        width: 2,
        color: Color(0xff07080A),
      ),
    ),
    labelColor: AppColors.darkColor,
    labelPadding: EdgeInsets.zero,
    unselectedLabelColor: AppColors.darkGrey,
    labelStyle: TextStyle(
      color: AppColors.darkColor, // black
      fontSize: 14.spt,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14.spt,
      color: AppColors.darkGrey, // medium grey
      fontWeight: FontWeight.w500,
    ),
  );
}
