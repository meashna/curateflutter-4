import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/well_being_score/wellbeing_score_vm.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/graph/SimpleRadialGuage.dart';
import 'package:curate/src/utils/graph/enums.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/utils/weekly_graph/score_line_graph_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/response/questions/WeeklyAssessmentScore.dart';
import '../../../styles/colors.dart';
import '../../../widgets/app_button.dart';
import '../../app_screens.dart';

class CalculateWellbeingAssessment extends StatefulWidget {
  final Map<String, dynamic> data;

  const CalculateWellbeingAssessment({super.key, required this.data});

  @override
  State<CalculateWellbeingAssessment> createState() =>
      _CalculateWellbeingAssessmentState();
}

class _CalculateWellbeingAssessmentState
    extends State<CalculateWellbeingAssessment> {
  var viewModel = WellbeingScoreVM();
  List<Color> gradientColors = [
    AppColors.graphStartColor,
    AppColors.graphEndColor,
  ];

  List<WeeklyAssessmentScore>? assessmentHistory = [];
  List<String> weeks = [];
  List<FlSpot> flSpots = [];
  num? score;
  String? message;

  @override
  void initState() {
    super.initState();
    assessmentHistory = widget.data["scores"];
    message = widget.data["message"];
    score = widget.data["scorePercentage"];
    if ((assessmentHistory?.length ?? 0) < 4) {
      for (int i = (assessmentHistory?.length ?? 0) - 1; i < 4; i++) {
        assessmentHistory?.add(WeeklyAssessmentScore(
            week: (assessmentHistory?[i].week ?? 0) + 1,
            percentIncrement: null));
      }
    }
    assessmentHistory?.forEach((element) {
      weeks.add("W${element.week ?? 1}");
    });

    flSpots.clear();
    for (int i = 0; i < (assessmentHistory?.length ?? 0); i++) {
      if (assessmentHistory?[i].percentIncrement != null) {
        flSpots.add(FlSpot(i.toDouble(),
            (assessmentHistory?[i].percentIncrement ?? 0).toDouble()));
      }
    }
  }

  Future<bool> _onWillPop() async {
    //Navigator.pop(context);
    RouteNavigator.popAllAndToReStart(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        body: SafeArea(
          child: Container(
            color: AppColors.screenBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.sps),
                GestureDetector(
                  onTap: () {
                    //RouteNavigator.goBack();
                    RouteNavigator.popAllAndToReStart(context);
                    //Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.sps),
                      child: Container(
                        width: 50.sps,
                        height: 50.sps,
                        margin: EdgeInsets.only(left: 16.sps),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Image.asset(ImageAssetPath.icClose,
                            width: 20.sps, height: 20.sps),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.sps),
                Center(
                  child: Text(
                    message ?? "Congrats, your score is \n getting better!",
                    style:
                        $styles.text.h6.copyWith(color: AppColors.blackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.sps),
                Stack(
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 48.sps),
                      child: SvgPicture.asset(
                        ImageAssetPath.icCircleLining,
                        width: 135.sps,
                        height: 135.sps,
                      ),
                    )),
                    Center(
                      child: SimpleRadialGauge(
                        actualValue: (score ?? 0).toDouble(),
                        maxValue: 100,
                        // Optional Parameters
                        minValue: 0,
                        title: Text(""),
                        titlePosition: TitlePosition1.top,
                        unit: '%',
                        icon: SvgPicture.asset(
                            ImageAssetPath.icWellbeingScoreIcon1,
                            height: 36.sps,
                            width: 36.sps),
                        pointerColor: AppColors.primary,
                        decimalPlaces: 0,
                        isAnimate: true,
                        animationDuration: 800,
                        size: 235,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: Text(
                      "82% of the people who have followed all the \nhabits have seen significant improvement in all \n the PCOS symptoms",
                      style: $styles.text.body2
                          .copyWith(color: AppColors.darkGreyColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 32.sps),
                SizedBox(height: 16.sps),
                Expanded(
                    child: ScoreLineGraphchart(
                  flSpots: flSpots,
                  weeks: weeks,
                )),
                SizedBox(height: 16.sps),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
