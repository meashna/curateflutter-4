import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curate/src/utils/extensions.dart';

import '../constants/app_constants.dart';
import '../styles/colors.dart';

class AppStyles {
  static TextStyle getTitleMediumTextStyle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      color: AppColors.darkestGrey,
      textStyle: Theme.of(context).textTheme.titleMedium,
      fontSize: 24.spt,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle getAppBarTextStyle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      color: AppColors.darkestGrey,
      textStyle: Theme.of(context).textTheme.titleMedium,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle getRegularTextStyle(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      color: AppColors.primary,
      textStyle: Theme.of(context).textTheme.labelMedium,
      fontSize: 14.spt,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getbodyText2Style(BuildContext context) {
    return GoogleFonts.plusJakartaSans(
      color: AppColors.mediumGrey,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      fontSize: 14.spt,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle titleMediumTextStyle = GoogleFonts.plusJakartaSans(
    color: AppColors.darkestGrey,
    fontSize: 24.spt,
    fontWeight: FontWeight.w700,
  );

  static TextStyle thinLargeTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 15.spt,
    fontWeight: FontWeight.w300,
  );

  static TextStyle thinMediumTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 13.spt,
    fontWeight: FontWeight.w300,
  );

  static TextStyle thickLargeTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 15.spt,
    fontWeight: FontWeight.w700,
  );

  static TextStyle normalTextStyle = TextStyle(
    color: AppColors.darkGrey,
    fontSize: 6.spt,
    fontWeight: FontWeight.w300,
  );

  static TextStyle appBarTitleTextStyle = const TextStyle(
    color: AppColors.darkestGrey,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle radioButtonSelectedTextStyle = const TextStyle(
    color: AppColors.darkColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle radioButtonUnSelectedTextStyle = const TextStyle(
    color: AppColors.greyColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle userNameTextStyle = const TextStyle(
    color: AppColors.darkColor,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static TextStyle genderTextStyle = const TextStyle(
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static TextStyle userProfileSubtitleTextStyle = TextStyle(
    color: AppColors.darkColor,
    fontWeight: FontWeight.w700,
    fontSize: 12.spt,
  );

  static TextStyle userProfileTitleTextStyle = TextStyle(
    color: AppColors.mediumGrey,
    fontWeight: FontWeight.w400,
    fontSize: 12.spt,
  );
  static TextStyle appBarTextButtonTextStyle = const TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static TextStyle errorTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 13,
  );

  static TextStyle get arabicScriptPageTitleStyle {
    return AppConstants.isTablet
        ? _arabicScriptPageTitleTabletStyle
        : _arabicScriptPageTitlePhoneStyle;
  }

  static TextStyle get arabicScriptPageSubTitleStyle {
    return AppConstants.isTablet
        ? _arabicScriptPageSubTitleTabletStyle
        : _arabicScriptPageSubTitlePhoneStyle;
  }

  static final TextStyle _arabicScriptPageTitleTabletStyle = TextStyle(
    color: AppColors.black,
    fontSize: 45.spt,
  );

  static final TextStyle _arabicScriptPageSubTitleTabletStyle = TextStyle(
    color: AppColors.black,
    fontSize: 32.spt,
    fontWeight: FontWeight.w300,
    height: 1.51,
  );

  static const TextStyle _arabicScriptPageTitlePhoneStyle = TextStyle(
    color: AppColors.black,
    fontSize: 32,
  );

  static const TextStyle _arabicScriptPageSubTitlePhoneStyle = TextStyle(
    color: AppColors.black,
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.51,
  );

  static TextStyle get arabicScriptPopupTitleTextStyle {
    return AppConstants.isTablet
        ? _arabicScriptPopupTitleTextTabletStyle
        : _arabicScriptPopupTitleTextPhoneStyle;
  }

  static TextStyle get arabicScriptPopupDescriptionTextStyle {
    return AppConstants.isTablet
        ? _arabicScriptPopupDescriptionTextTabletStyle
        : _arabicScriptPopupDescriptionTextPhoneStyle;
  }

  static final TextStyle _arabicScriptPopupTitleTextTabletStyle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 30.spt,
    letterSpacing: 5.spt,
  );

  static final TextStyle _arabicScriptPopupDescriptionTextTabletStyle =
      TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w300,
    fontSize: 24.spt,
  );

  static const TextStyle _arabicScriptPopupTitleTextPhoneStyle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle _arabicScriptPopupDescriptionTextPhoneStyle =
      TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );

/*  static ScrollingDotsEffect scrollingDotsEffect = ScrollingDotsEffect(
    dotHeight: AppConstants.isTablet ? 3.sp : 8,
    dotWidth: AppConstants.isTablet ? 3.sp : 8,
    activeDotColor: AppColors.color1,
    dotColor: AppColors.color4,
    activeDotScale: 1,
  );*/
}
