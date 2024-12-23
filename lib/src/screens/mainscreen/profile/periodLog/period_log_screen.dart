import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/no_internet_widget.dart';
import 'package:curate/src/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/app_button.dart';
import '../../../../widgets/fetch_more_widget.dart';
import '../../../../widgets/refresh_indicator_widget.dart';
import 'cubit/period_log_screen_cubit.dart';

class PeriodLogScreen extends StatefulWidget {
  const PeriodLogScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => PeriodLogScreenCubit(),
        child: PeriodLogScreen());
  }

  @override
  State<PeriodLogScreen> createState() => _PeriodLogScreenState();
}

class _PeriodLogScreenState extends State<PeriodLogScreen> {
  bool isLoading = false;
  late PeriodLogScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title: "Period Calendar")),
      body: BlocConsumer<PeriodLogScreenCubit, PeriodLogScreenState>(
        listener: (context, state) {
          if (state is PeriodLogScreenLoading) {
            isLoading = true;
          } else if (state is PeriodLogScreenInitial) {
            isLoading = false;
          } else if (state is PeriodLogScreenSuccess) {
            isLoading = false;
          } else if (state is PeriodLogScreenError) {
            isLoading = false;
            AppUtils.showToast(state.errorMessage);
          } else if (state is PeriodLogScreenNoInternet) {
            isLoading = false;
            AppUtils.showToast(AppConstants.noInternetTitle);
          }
        },
        builder: (context1, state) {
          cubit = BlocProvider.of<PeriodLogScreenCubit>(context1);
          if (state is PeriodLogScreenLoading) {
            return ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(
                    right: 12.sps, left: 12.sps, bottom: 64.sps),
                itemBuilder: (BuildContext context, int index) {
                  return getListSkelton(index);
                });
          }
          if (state is PeriodLogScreenInitial ||
              state is PeriodLogScreenError ||
              state is PeriodLogScreenSuccess ||
              state is PeriodLogScreenLoading) {
            return Container(
                color: AppColors.screenBackground, child: getMainContent());
          } else if (state is PeriodLogScreenNoInternet) {
            if ((cubit.periodData.length ?? 0) > 0) {
              return Container(
                  color: AppColors.screenBackground, child: getMainContent());
            } else {
              return NoInternetWidget(() {
                cubit.getPeriodData();
              });
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget getMainContent() {
    return CustomRefresIndicator(
      onRefresh: () => cubit.getPeriodData(isRefresh: true),
      child: FetchMoreIndicator(
        isLastPage: cubit.isLastPage,
        onAction: cubit.getPeriodData,
        child: Stack(
          children: [
            (!isLoading)
                ? (cubit.periodData.isEmpty)
                    ? NoDataWidget()
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 12.sps, left: 12.sps, bottom: 64.sps),
                          child: Container(
                            width: double.infinity,
                            color: AppColors.screenBackground,
                            child: Column(
                              children: [
                                SizedBox(height: 16.sps),
                                Text(
                                  "Days since last cycle",
                                  style: $styles.text.h6
                                      .copyWith(color: AppColors.blackColor),
                                ),
                                SizedBox(height: 16.sps),
                                Container(
                                  height: 104.sps,
                                  width: 104.sps,
                                  decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle),
                                  child: Stack(
                                    children: [
                                      Center(
                                          child: SvgPicture.asset(
                                              ImageAssetPath.icCircleLining,
                                              width: 97.sps,
                                              height: 97.sps)),
                                      Center(
                                          child: Text(
                                        DailyActivityUtils
                                            .getDayCountWithCurrentDate(
                                                cubit.periodData[0]),
                                        style: $styles.text.h5.copyWith(
                                            color: AppColors.blackColor),
                                      ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.sps),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sps),
                                  child: Text(
                                    "Normal period cycles range from 21-35 days.",
                                    style: $styles.text.body1.copyWith(
                                        color: AppColors.darkGreyColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 32.sps),
                                Text(
                                  "Timeline",
                                  style: $styles.text.h6
                                      .copyWith(color: AppColors.blackColor),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 12.sps),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: cubit.periodData.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return getLogItem(
                                          index, cubit.periodData[index]);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      )
                : Padding(
                    padding: EdgeInsets.only(
                        right: 12.sps, left: 12.sps, bottom: 64.sps),
                    child: ListView.builder(
                        itemCount: 10,
                        padding: EdgeInsets.only(bottom: 54.sps),
                        itemBuilder: (BuildContext context, int index) {
                          return getListSkelton(index);
                        }),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.screenBackground,
                padding: EdgeInsets.all(16.sps),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Add log",
                  onClicked: () {
                    RouteNavigator.pushNamed(
                        context, AppScreens.calendarAddLog);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogItem(int index, HealthLogData data) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 2.sps,
                      decoration: BoxDecoration(
                          color: (index == 0)
                              ? AppColors.transparentColor
                              : AppColors.lightGreenColor,
                          shape: BoxShape.rectangle),
                    ),
                  ),
                  Visibility(
                    visible: ((index == (cubit.periodData.length ?? 0) - 1 ||
                            index == 0) &&
                        ((cubit.periodData.length ?? 0) != 1)),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        width: 2.sps,
                        margin: EdgeInsets.only(top: 3.sps),
                        decoration: BoxDecoration(
                            color: (index == 0)
                                ? AppColors.lightGreenColor
                                : AppColors.transparentColor,
                            shape: BoxShape.rectangle),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: 12.sps,
                  width: 12.sps,
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                ),
              )
            ],
          ),
          SizedBox(
            width: 12.sps,
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                RouteNavigator.pushNamed(context, AppScreens.calendarAddLog,
                    arguments: data);
              },
              child: Card(
                color: AppColors.white,
                margin: EdgeInsets.only(bottom: 12.sps),
                surfaceTintColor: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.sps),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.lightGreenColor,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sps),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        ImageAssetPath.icCalendar,
                                        width: 16.sps,
                                        height: 16.sps,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.sps,
                                ),
                                Text(
                                  DailyActivityUtils.getDateRange(data),
                                  style: $styles.text.title3
                                      .copyWith(color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              RouteNavigator.pushNamed(
                                  context, AppScreens.calendarAddLog,
                                  arguments: data);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sps),
                              child: SvgPicture.asset("assets/svg/ic_edit.svg"),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.sps,
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Duration: ",
                                  style: $styles.text.body2
                                      .copyWith(color: AppColors.darkGreyColor),
                                  children: [
                                TextSpan(
                                    text:
                                        "${DailyActivityUtils.getDayCount(data)} Days",
                                    style: $styles.text.title3
                                        .copyWith(color: AppColors.blackColor))
                              ])),
                          SizedBox(width: 16.sps),
                          Text("|"),
                          SizedBox(width: 16.sps),
                          Expanded(
                            child: RichText(
                                //maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: "Flow: ",
                                    style: $styles.text.body2.copyWith(
                                        color: AppColors.darkGreyColor),
                                    children: [
                                      TextSpan(
                                        text: data.periodFlow?.title ?? "",
                                        style: $styles.text.title3.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                      )
                                    ])),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getListSkelton(int index) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 2.sps,
                      decoration: BoxDecoration(
                          color: (index == 0)
                              ? AppColors.transparentColor
                              : AppColors.lightGreenColor,
                          shape: BoxShape.rectangle),
                    ),
                  ),
                  Visibility(
                    visible: ((index == 9 || index == 0) &&
                        ((cubit.periodData.length ?? 0) != 1)),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        width: 2.sps,
                        margin: EdgeInsets.only(top: 3.sps),
                        decoration: BoxDecoration(
                            color: (index == 0)
                                ? AppColors.lightGreenColor
                                : AppColors.transparentColor,
                            shape: BoxShape.rectangle),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: 12.sps,
                  width: 12.sps,
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                ),
              )
            ],
          ),
          SizedBox(
            width: 12.sps,
          ),
          Expanded(
            child: Card(
              color: AppColors.white,
              margin: EdgeInsets.only(bottom: 12.sps),
              surfaceTintColor: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16.sps),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(height: 16.sps, width: 120.sps),
                    SizedBox(
                      height: 12.sps,
                    ),
                    ShimmerWidget.rectangular(height: 16.sps),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
