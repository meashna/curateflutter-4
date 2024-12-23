import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class LineTiles{

  static int currentDay=0;
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
     topTitles:AxisTitles(
       sideTitles: SideTitles(
         showTitles: false,
         reservedSize: 46,
       ),
     ),
    rightTitles:AxisTitles(
      sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 0
      ),
    ),
    leftTitles:AxisTitles(
      sideTitles: SideTitles(
          showTitles: false
      ),
    ),



  );


  static Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style =$styles.text.title5.copyWith(color: AppColors.lightGreyColor);
    Widget text;

    text= Text(DailyActivityUtils.calculateGraphDay(currentDay)[value.toInt()], style: style);


    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }



}