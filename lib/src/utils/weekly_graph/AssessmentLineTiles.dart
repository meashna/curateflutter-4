import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AssessmentLineTiles {
  static int currentDay = 0;
  static List<String> weeks = [];

  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 46,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false, reservedSize: 0),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50, // this value used to create space
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      );

  static Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = $styles.text.title5.copyWith(color: AppColors.lightGreyColor);
    Widget text;

    text = Text(weeks[value.toInt()], style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  static Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style =
        $styles.text.title5.copyWith(color: AppColors.lightGreyColor);
    var textString = "";

    switch (value.toInt()) {
      case 0:
        textString = "0";
        break;
      case 20:
        textString = "20";
        break;
      case 40:
        textString = "40";
        break;
      case 60:
        textString = "60";
        break;
      case 80:
        textString = "80";
        break;
      case 100:
        textString = "100";
        break;
      default:
        textString = "";
        break;
    }
    //text= Text(DailyActivityUtils.calculateGraphDay(currentDay)[value.toInt()], style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding:
            EdgeInsets.only(right: 16.sps), // this value used to give padding
        child: Text(textString, style: style),
      ),
    );
  }
}
