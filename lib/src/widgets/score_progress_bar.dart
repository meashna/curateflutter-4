import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';
import '../utils/graph/SimpleRadialGuage.dart';
import '../utils/graph/enums.dart';

class ScoreProgressBar extends StatefulWidget {
  double data = 0;
  ScoreProgressBar({super.key, required this.data});

  @override
  State<ScoreProgressBar> createState() => _ScoreProgressBarState();
}

class _ScoreProgressBarState extends State<ScoreProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.sps),
          child: SvgPicture.asset(
            ImageAssetPath.icCircleLining,
            width: 135.sps,
            height: 135.sps,
          ),
        ),
        SimpleRadialGauge(
          actualValue: widget.data,
          maxValue: 100,
          // Optional Parameters
          minValue: 0,
          title: Text(""),
          titlePosition: TitlePosition1.top,
          unit: '%',
          icon: SvgPicture.asset(ImageAssetPath.icWellbeingScoreIcon1,
              height: 36.sps, width: 36.sps),
          pointerColor: AppColors.primary,
          decimalPlaces: 0,
          isAnimate: true,
          animationDuration: 800,
          size: 245.sps,
        ),
      ],
    );
  }
}
