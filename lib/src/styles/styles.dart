// ignore_for_file: library_private_types_in_public_api

import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets();

  /// Text styles
  late final _Text text = _Text();

  /// Animation Durations
  final _Times times = _Times();
}

@immutable
class _Text {
  /* final Map<String, TextStyle> _titleFonts = {
    'en': TextStyle(fontFamily: 'Tenor'),
  };

  final Map<String, TextStyle> _monoTitleFonts = {
    'en': TextStyle(fontFamily: 'B612Mono'),
  };

  final Map<String, TextStyle> _quoteFonts = {
    'en': TextStyle(fontFamily: 'Cinzel'),
    'zh': TextStyle(fontFamily: 'MaShanZheng'),
  };

  final Map<String, TextStyle> _wonderTitleFonts = {
    'en': TextStyle(fontFamily: 'Yeseva'),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': TextStyle(fontFamily: 'Raleway', fontFeatures: const [
      FontFeature.enable('dlig'),
      FontFeature.enable('kern'),
    ]),
  };

  TextStyle _getFontForLocale(Map<String, TextStyle> fonts) {
    return fonts.entries.first.value;
    */ /*if (localeLogic.isLoaded) {
      return fonts.entries.firstWhere((x) => x.key == $strings.localeName, orElse: () => fonts.entries.first).value;
    } else {
      return fonts.entries.first.value;
    }*/ /*
  }

  TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get quoteFont => _getFontForLocale(_quoteFonts);
  TextStyle get wonderTitleFont => _getFontForLocale(_wonderTitleFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);
  TextStyle get monoTitleFont => _getFontForLocale(_monoTitleFonts);*/

  late final TextStyle dropCase = copy(sizePx: 56.sps, heightPx: 20.sps);

  late final TextStyle h1 = copy(sizePx: 96.sps, heightPx: 62.sps);
  late final TextStyle h2 = copy(sizePx: 60.sps, heightPx: 46.sps);
  late final TextStyle h3 =
      copy(sizePx: 48.sps, heightPx: 36.sps, weight: FontWeight.w600);
  late final TextStyle h4 = copy(
    sizePx: 34.sps,
    heightPx: 23.sps,
    spacingPc: 5.sps,
    weight: FontWeight.w600,
  );
  late final TextStyle h5 =
      copy(sizePx: 26.sps, heightPx: 33.sps, weight: FontWeight.w700);
  late final TextStyle h6 =
      copy(sizePx: 20.sps, heightPx: 26.sps, weight: FontWeight.w700);
  late final TextStyle h7 =
      copy(sizePx: 18.sps, heightPx: 27.sps, weight: FontWeight.w700);
  late final TextStyle h8 = copy(
    sizePx: 16.sps,
    heightPx: 24.sps,
    weight: FontWeight.w700,
  );
  late final TextStyle h9 = copy(
    sizePx: 16.sps,
    weight: FontWeight.w700,
  );
  late final TextStyle h10 =
      copy(sizePx: 26.sps, heightPx: 33.sps, weight: FontWeight.w400);

  late final TextStyle title1 =
      copy(sizePx: 16.sps, heightPx: 26.sps, spacingPc: 5.sps);
  late final TextStyle title2 = copy(sizePx: 14.sps, heightPx: 16.38.sps);
  late final TextStyle title3 =
      copy(sizePx: 14.sps, heightPx: 21.sps, weight: FontWeight.w700);
  late final TextStyle title4 =
      copy(sizePx: 12.sps, heightPx: 15.6.sps, weight: FontWeight.w700);
  late final TextStyle title5 =
      copy(sizePx: 12.sps, heightPx: 15.6.sps, weight: FontWeight.w700);

  late final TextStyle body1 =
      copy(sizePx: 16.sps, heightPx: 24.sps, weight: FontWeight.w400);
  late final TextStyle noti_title =
      copy(sizePx: 14.sps, weight: FontWeight.w400);
  late final TextStyle body2 =
      copy(sizePx: 14.sps, heightPx: 21.sps, weight: FontWeight.w400);
  late final TextStyle body3 =
      copy(sizePx: 10.sps, heightPx: 13.sps, weight: FontWeight.w400);
  late final TextStyle body4 =
      copy(sizePx: 12.sps, heightPx: 21.sps, weight: FontWeight.w400);

  late final TextStyle callout =
      copy(sizePx: 16.sps, heightPx: 26.sps, weight: FontWeight.w600)
          .copyWith(fontStyle: FontStyle.italic);
  late final TextStyle btn =
      copy(sizePx: 12.sps, weight: FontWeight.w600, heightPx: 13.2.sps);

  TextStyle copy(
      {required double sizePx,
      double? heightPx,
      double? spacingPc,
      FontWeight? weight}) {
    TextStyle style = TextStyle(fontFamily: GoogleFonts.lexend().fontFamily);
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing:
            spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Times {
  final Duration fast = Duration(milliseconds: 300);
  final Duration med = Duration(milliseconds: 600);
  final Duration slow = Duration(milliseconds: 900);
  final Duration pageTransition = Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: Offset(0, 2),
        blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: Offset(0, 4),
        blurRadius: 6),
  ];
}
