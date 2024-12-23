import 'package:flutter/material.dart';
import '../logic/common/color_utils.dart';

class AppColors {
  /// Common

  static const Color primary = Color(0xFF57B757);
  static const Color accentDarkColor = Color(0xFF094E26);
  static const Color accentDarklightColor = Color(0xFFDCF0E5);
  static const Color accentDarklightColor1 = Color(0xFFECF6F1);
  static const Color accentLight = Color(0xFFDAECE1);
  static const Color lightgreen = Color(0xFFD4EFEE);
  static const Color lightestgreen = Color(0xFFEEF6F1);
  static const Color accentMedium = Color(0xFFC0E0C6);
  static const Color accentlight1 = Color(0xFFB7DEBE);
  static const Color lightborderColor = Color(0xFFE0EDE5);
  static const Color errorColor = Color(0xFFE70000);
  static const Color transparentColor = Color(0x00000000);

  static const Color blackColor = Color(0xFF141414);
  static const Color lightblackColor = Color(0x00FFFFFF);
  static const Color secondaryGreyColor = Color(0xFF909090);
  static const Color darkGreyColor = Color(0xFF606060);
  static const Color lightGreyColor = Color(0xFFB6B6B6);
  static const Color lightGreyColor1 = Color(0xFFF3F3F3);
  static const Color lightestGreyColor = Color(0xFFEDEDED);
  static const Color lightGreenColor = Color(0xFFE6F6E7);
  static const Color greenColor = Color(0xFFCFF3D0);
  static const Color lightestGreyColor1 = Color(0xFFF5F5F5);
  static const Color screenBackground = Color(0xFFF9FAFB);

  static const Color darkGreenColor = Color(0xFF399939);
  static const Color darkestGreenColor = Color(0xFF4E964E);
  static const Color white = Color(0xFFFFFFFF);

  static const Color graphStartColor = Color(0xFFCBEECB);
  static const Color graphEndColor = Color(0x80FFFFFF);
  static const Color unCompletedTask = Color(0xFFF5EAEA);
  static const Color unCompletedCircle = Color(0xFFF5DADA);

  //activity color
  static const Color habitBackgroundColor = Color(0xFFF1F3FF);
  static const Color habitTextColor = Color(0xFF5A73D8);
  static const Color mindfulnessBackgroundColor = Color(0xFFFFF7E8);
  static const Color mindfulnessTextColor = Color(0xFFF0BB52);
  static const Color medicineBackgroundColor = Color(0xFFF3F3F3);
  static const Color medicineTextColor = Color(0xFFE70000);
  static const Color nutritionBackgroundColor = Color(0xFFCFF3D0);
  static const Color nutritionTextColor = Color(0xFF399939);
  static const Color workoutBackgroundColor = Color(0xFFFFF2F1);
  static const Color workoutTextColor = Color(0xFFC76461);

  static const Color tickRed = Color(0xFFED032E);

  static const Color redDark = Color(0xFF811F18);

  static const Color redDarkLight = Color(0xFFFFEEED);
  static const Color redDarkLight1 = Color(0xFFFFF4F3);
  static const Color redLight = Color(0xFFAC4139);
  static const Color appBgColor = Color(0xFFFBFCFB);
  static const Color starColor = Color(0xFFF0940B);
  static const Color error = Color(0xFFD8090D);
  static const Color hintColor = Color(0xFFA2A2A2);
  static const Color borderColor = Color(0xFFD8D8D8);
  static const Color orangeBorderColor = Color(0xFFFCD79F);
  static const Color orangeColor = Color(0xFFEA8C00);
  static const Color lightOrangeColor = Color(0xFFFFEED3);
  static const Color starColor1 = Color(0xFFFCC607);
  static const Color darkOrange = Color(0xFFFC7900);
  static const Color lightOrange = Color(0xFFFFC700);
  static const Color lightOrange1 = Color(0xFFFEF0DB);

  static const Color black = Color(0xFF07080A);
  static const Color darkColor = Color(0xFF262626);
  static const Color darkestGrey = Color(0xFF404040);
  static const Color darkGrey = Color(0xFF616161);
  static const Color mediumGrey = Color(0xFF7E7E7E);
  static const Color darkGreynew = Color(0xFF2E3A39);

  static const Color greyColor = Color(0xFFA2A2A2);
  static const Color lightGrey = Color(0xFFC6C6C6);
  static const Color lightestGrey3 = Color(0xFFD8D8D8);
  static const Color lightestGrey2 = Color(0xFFE0E0E0);
  static const Color lightestGrey1 = Color(0xFFF0F0F0);
  static const Color userContainerBGColor = Color(0xFFF7F7FC);
  static const Color stableStateBtn = Color(0xFFEEEEF6);
  static const Color tagColor = Color(0xFF003B4D);
  static const Color round_icon_bg_color = Color(0xFFEEF5EE);
  static const Color round_icon_bg_color1 = Color(0xFF6D9C95);
  static const Color round_icon_border_color1 = Color(0xFF21574F);
  static const Color round_icon_border_color2 = Color(0xFFA6D9D6);
  static const Color round_icon_bg_color2 = Color(0xFFCBECEA);

  static const Color gradientStart = Color(0xFF07080A);
  static const Color gradientEnd = Color(0xFF141F16);

  static const Color soulWritingBackground = Color(0xFFDAECE1);
  static const Color soulWritingBackground1 = Color(0xFFe9f1eb);

  static const bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));

  ThemeData toThemeData() {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme =
        (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    Color txtColor = white;
    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom theme, to the MaterialApp
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        primaryContainer: accentLight,
        secondary: redDark,
        secondaryContainer: white,
        surface: white,
        onSurface: txtColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: error);

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    /// Also add on some extra properties that ColorScheme seems to miss
    var t =
        ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme).copyWith(
      textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
      highlightColor: redLight,
    );

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}
