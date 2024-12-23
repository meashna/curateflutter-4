import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/weekly_graph/AssessmentLineTiles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class ScoreLineGraphchart extends StatefulWidget {
  List<FlSpot> flSpots = [];
  List<String> weeks = [];

  ScoreLineGraphchart({super.key, required this.flSpots, required this.weeks});

  @override
  State<ScoreLineGraphchart> createState() => _ScoreLineGraphchartState();
}

class _ScoreLineGraphchartState extends State<ScoreLineGraphchart> {
  List<Color> gradientColors = [
    AppColors.graphStartColor,
    AppColors.graphEndColor,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssessmentLineTiles.weeks = widget.weeks;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.width * 0.70,
        child: lineChartData());
  }

  Widget lineChartData() {
    return Padding(
      padding: EdgeInsets.only(left: 24.sps, right: 24.sps, bottom: 32.sps),
      child: Container(
          padding: EdgeInsets.only(left: 16.sps, right: 16.sps, top: 16.sps),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.sps)),
              color: AppColors.white),
          child: LineChart(LineChartData(
              backgroundColor: AppColors.white,
              minX: 0,
              maxX: (widget.weeks.length - 1).toDouble(),
              minY: 0,
              maxY: 120,
              lineTouchData: LineTouchData(
                handleBuiltInTouches: true,
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((spotIndex) {
                    final spot = barData.spots[spotIndex];
                    return TouchedSpotIndicatorData(
                      FlLine(
                          color: AppColors.black,
                          strokeWidth: 1,
                          dashArray: [5, 3]),
                      FlDotData(
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.black,
                            strokeWidth: 4,
                            strokeColor: AppColors.white,
                          );
                        },
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  //tooltipBgColor: AppColors.blackColor,
                  getTooltipColor: (LineBarSpot spot) => AppColors.blackColor,
                  tooltipRoundedRadius: 30.sps,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      String value = "${flSpot.y.toInt()} %";
                      return LineTooltipItem(
                        value,
                        $styles.text.title5.copyWith(color: AppColors.white),

                        //textAlign: textAlign,
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(
                  show: true,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                        color: AppColors.greenColor,
                        dashArray: [4, 4],
                        strokeWidth: 1);
                  },
                  drawVerticalLine: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  barWidth: 2,
                  color: AppColors.darkestGreenColor,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: gradientColors.toList(),
                    ),
                  ),
                  spots: widget.flSpots,
                  dotData: FlDotData(
                      show: (widget.flSpots.length == 1) ? true : false,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.black,
                          strokeWidth: 4,
                          strokeColor: AppColors.white,
                        );
                      }),
                ),
              ],
              borderData: FlBorderData(show: false),
              titlesData: AssessmentLineTiles.getTitleData()))),
    );
  }
}
