import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/mainscreen/home/moodDetails/LinesTiles.dart';
import 'package:curate/src/screens/mainscreen/home/moodDetails/cubit/mood_detail_cubit.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../mood_content.dart';

class MoodDetailsScreen extends StatefulWidget {
  Map<String, dynamic>? data;

  MoodDetailsScreen({super.key, required this.data});

  static Widget create(Map<String, dynamic>? data1) {
    int currDay = data1?[AppConstants.planCurrentDay];
    int totalDay = data1?[AppConstants.planTotalDay];
    return BlocProvider(
        create: (BuildContext context) => MoodDetailCubit(currDay, totalDay),
        child: MoodDetailsScreen(data: data1));
  }

  @override
  State<MoodDetailsScreen> createState() => _MoodDetailsScreenState();
}

class _MoodDetailsScreenState extends State<MoodDetailsScreen> {
  List<Color> gradientColors = [
    AppColors.graphStartColor,
    AppColors.graphEndColor,
  ];

  late MoodDetailCubit cubit;
  int selectecdIndex = 0;
  List<FlSpot> flSpots = [];

  int totalDays = 0;
  int totalWeeks = 0;
  int currentDays = 0;

  @override
  void initState() {
    super.initState();
    totalDays = widget.data?[AppConstants.planTotalDay];
    totalDays = widget.data?[AppConstants.planTotalDay];
    totalWeeks = widget.data?[AppConstants.planTotalWeek];
    currentDays = widget.data?[AppConstants.planCurrentDay];
    LineTiles.currentDay = currentDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(),
      ),
      body: SafeArea(
          child: BlocConsumer<MoodDetailCubit, MoodDetailState>(
              listener: (context, state) {
        if (state is MoodDetailLoading) {
          context.loaderOverlay.show();
        } else if (state is MoodDetailInitial) {
          context.loaderOverlay.hide();
        } else if (state is MoodDetailError) {
          context.loaderOverlay.hide();
        }
      }, builder: (context, state) {
        cubit = BlocProvider.of<MoodDetailCubit>(context);
        flSpots.clear();
        for (int i = 0; i < (cubit.responseData?.moods?.length ?? 0); i++) {
          flSpots.add(FlSpot(i.toDouble(),
              (cubit.responseData?.moods?[i].score ?? 0).toDouble()));
        }

        return mainContent(state);
      })),
    );
  }

  Widget mainContent(MoodDetailState state) {
    return Container(
      color: AppColors.screenBackground,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(16.sps),
            padding: EdgeInsets.all(16.sps),
            decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius: BorderRadius.circular(12.sps)),
            child: Column(children: [
              Card(
                margin: EdgeInsets.all(0),
                surfaceTintColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.white),
                  borderRadius: BorderRadius.circular(40.sps),
                ),
                child: Padding(
                  padding: EdgeInsets.all(18.sps),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      ImageAssetPath.icMoodNormal,
                      height: 30.sps,
                      width: 30.sps,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.sps),
              (state is MoodDetailLoading)
                  ? Container(
                      height: 52.sps,
                    )
                  : Column(
                      children: [
                        Text(
                            (cubit.responseData?.option?.optionTitle ?? "")
                                    .isEmpty
                                ? "Mood not submitted yet"
                                : "Feeling ${cubit.responseData?.option?.optionTitle ?? ""}",
                            style: $styles.text.h6
                                .copyWith(color: AppColors.blackColor)),
                        SizedBox(height: 16.sps),
                        Text(
                          cubit.responseData?.option?.optionDescription ??
                              "Slow progress is better than no progress stay positive and never give up.",
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
            ]),
          ),
          Text("Your progress",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              textAlign: TextAlign.center),
          SizedBox(height: 16.sps),
          SizedBox(
            height: 74.sps,
            child: ScrollablePositionedList.builder(
                initialScrollIndex: cubit.currentWeekDay - 1,
                scrollDirection: Axis.horizontal,
                itemCount: totalWeeks,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      cubit.currentWeekDay = index + 1;
                      cubit.getMoodData(index + 1);
                    },
                    child: SizedBox(
                        height: 60.sps,
                        width: MediaQuery.of(context).size.width / 5,
                        child: dateWidget(index)),
                  );
                }),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 24.sps, right: 24.sps, bottom: 32.sps),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 16.sps, right: 16.sps, top: 16.sps),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.sps)),
                      color: AppColors.white),
                  child: lineChartData()),
            ),
          ),
        ],
      ),
    );
  }

  Widget dateWidget(int index) {
    return Column(
      children: [
        SizedBox(
          height: 50.sps,
          width: 50.sps,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              (cubit.currentWeekDay == index + 1)
                  ? SizedBox(
                      height: 40.sps,
                      width: 40.sps,
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        color: AppColors.primary,
                        shadowColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.sps),
                        ),
                        child: Center(
                            child: Text("${index + 1}W",
                                style: $styles.text.title5
                                    .copyWith(color: AppColors.white))),
                      ),
                    )
                  : Container(
                      height: 40.sps,
                      width: 40.sps,
                      decoration: const BoxDecoration(
                          color: AppColors.lightGreenColor,
                          shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        "W${index + 1}",
                        style: $styles.text.title5
                            .copyWith(color: AppColors.lightGreyColor),
                      )),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  LineChart lineChartData() {
    return LineChart(LineChartData(
        backgroundColor: AppColors.white,
        minX: 0,
        maxX: 6,
        minY: -1.5,
        maxY: 5,
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              final spot = barData.spots[spotIndex];
              return TouchedSpotIndicatorData(
                FlLine(
                    color: AppColors.blackColor,
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
                String value = "";
                switch (flSpot.y.toInt()) {
                  case -1:
                    value = "Not submiited";
                    break;
                  case 0:
                    value = "Felt sad";
                    break;
                  case 1:
                    value = "Felt upset";
                    break;
                  case 2:
                    value = "Felt normal";
                    break;
                  case 3:
                    value = "Felt happy";
                    break;
                  case 4:
                    value = "Felt joyful";
                    break;
                  default:
                    value = "";
                }

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
            horizontalInterval: 1,
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
            spots: flSpots,
            dotData: FlDotData(
                show: (flSpots.length == 1) ? true : false,
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
        titlesData: LineTiles.getTitleData()));
  }
}
