import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/screens/mainscreen/myplan/cubit/plan_screen_cubit.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../app_screens.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => PlanScreenCubit(),
        child: const MyPlanScreen());
  }

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  late PlanScreenCubit cubit;
  var isLockScreen = false;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanScreenCubit, PlanScreenState>(
      listener: (context, state) {
        if (state is PlanSkeletonLoading) {
          //context.loaderOverlay.show();
          isLockScreen = false;
        } else if (state is PlanScreenInitial) {
          context.loaderOverlay.hide();
          isLockScreen = false;
        } else if (state is PlanScreenError) {
          context.loaderOverlay.hide();
          AppUtils.showToast(state.errorMessage);
          isLockScreen = false;
        } else if (state is PlanScreenNoInternet) {
          context.loaderOverlay.hide();
          isLockScreen = false;
        } else if (state is PlanScreenLock) {
          context.loaderOverlay.hide();
          isLockScreen = true;
        }
      },
      builder: (context, state) {
        cubit = BlocProvider.of<PlanScreenCubit>(context);
        if (state is PlanSkeletonLoading) {
          if (state.isEmptyScreen) {
            return SkeltonView();
          } else {
            return mainContent(state);
          }
        }

        if (state is PlanScreenInitial || state is PlanScreenLock) {
          return mainContent(state);
        } else if (state is PlanScreenNoInternet) {
          return NoInternetWidget(() {
            cubit.getPlanData(cubit.currentWeek + 1);
          });
        } else {
          return Container();
        }
      },
    );
  }

  Widget mainContent(PlanScreenState state) {
    return Container(
      color: AppColors.screenBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.sps, top: 16.sps, bottom: 8.sps, right: 16.sps),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "My plan",
                    style:
                        $styles.text.h5.copyWith(color: AppColors.blackColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.sps, horizontal: 16.sps),
            height: 44.sps,
            child: ScrollablePositionedList.builder(
                initialScrollIndex: (cubit.currentWeek) - 1,
                scrollDirection: Axis.horizontal,
                itemCount: cubit.totalWeek,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      try {
                        itemScrollController.jumpTo(
                            index: DailyActivityUtils.getMyPlanSelectedIndex(
                                index + 1, cubit.currentDay ?? 1));
                      } catch (e) {}
                      cubit.getPlanData(index + 1);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.sps),
                      child: getWeekWidget(index),
                    ),
                  );
                }),
          ),
          (state is PlanSkeletonLoading && !state.isEmptyScreen)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 240,
                  child: const Center(child: CircularProgressIndicator()))
              : (isLockScreen)
                  ? Container(
                      margin: EdgeInsets.only(top: 72.sps),
                      child: Center(
                          child: lockDayWidget(() {
                        Navigator.pushNamed(context, AppScreens.choosePlan);
                      }, cubit.isPlanPurchased)))
                  : (cubit.dayList?.length ?? 0) > 0
                      ? Expanded(
                          child: ScrollablePositionedList.builder(
                              initialScrollIndex:
                                  DailyActivityUtils.getMyPlanSelectedIndex(
                                      cubit.currentWeek, cubit.currentDay ?? 1),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.sps, horizontal: 16.sps),
                              itemCount: cubit.dayList?.length ?? 0,
                              itemScrollController: itemScrollController,
                              scrollOffsetListener: scrollOffsetListener,
                              itemPositionsListener: itemPositionsListener,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.sps),
                                  child: getDayWidget(cubit.dayList?[index]),
                                );
                              }),
                        )
                      : Expanded(
                          child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(24.sps),
                          child: NoDataWidget(
                              image: ImageAssetPath.ivGratitudeActivity,
                              title: "No tasks assigned"),
                        )),
        ],
      ),
    );
  }

  Widget SkeltonView() {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.sps, top: 16.sps, bottom: 8.sps, right: 16.sps),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(
                  height: 33.sps,
                  width: 120.sps,
                ),
                SizedBox(
                  width: 16.sps,
                ),
                ShimmerWidget.circular(
                  height: 50.sps,
                  width: 50.sps,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.sps, horizontal: 16.sps),
            height: 44.sps,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.sps),
                    child: ShimmerWidget.rectangular(
                      height: 44.sps,
                      width: 120.sps,
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                padding:
                    EdgeInsets.symmetric(vertical: 16.sps, horizontal: 16.sps),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.sps),
                    child: ShimmerWidget.rectangular(height: 100.sps),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget getWeekWidget(int index) {
    return Container(
      decoration: BoxDecoration(
        color: (cubit.currentWeek == index + 1)
            ? AppColors.primary
            : AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.sps)),
        border: Border.all(
          width: 1.sps,
          color: (cubit.currentWeek == index + 1)
              ? AppColors.primary
              : Colors.grey.shade200,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 22.sps),
      child: Row(
        children: [
          Visibility(
              visible: ((index + 1) > cubit.endWeek),
              child: Container(
                  padding: EdgeInsets.only(/*top: 4.sps,*/ right: 8.sps),
                  child: (index + 1 == cubit.currentWeek)
                      ? SvgPicture.asset(ImageAssetPath.icLockActive,
                          width: 20.sps, height: 20.sps)
                      : SvgPicture.asset(ImageAssetPath.icLock,
                          width: 20.sps, height: 20.sps))),
          Text(
            "${index + 1} ${"week"}",
            style: $styles.text.h9.copyWith(
                color: (cubit.currentWeek == index + 1)
                    ? AppColors.white
                    : AppColors.blackColor),
          ),
        ],
      ),
    );
  }

  Widget getDayWidget(Data? planData) {
    return GestureDetector(
      onTap: () async {
        Map<String, dynamic> data = {
          "isNotification": false,
          "dayData": planData,
          "currentDay": cubit.currentDay
        };

        var result = await Navigator.pushNamed(
            context, AppScreens.dayPlanScreen,
            arguments: data) as num?;

        if (result == 1) {
          cubit.refreshData();
        }
      },
      child: Card(
        margin: EdgeInsets.zero,
        surfaceTintColor: AppColors.white,
        color: DailyActivityUtils.getDayCardBackground(
            planData, cubit.currentDay ?? 1),
        shape: (cubit.currentDay == (planData?.day ?? 1))
            ? RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12.sps),
              )
            : RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColors.white,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(12.sps),
              ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sps, vertical: 20.sps),
          child: Row(
            children: [
              DailyActivityUtils.getDayCardTick(
                  planData, cubit.currentDay ?? 1),
              SizedBox(
                width: 12.sps,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Day ${planData?.day ?? ""} - ${planData?.todoList?.title ?? ""}",
                        style: $styles.text.body1
                            .copyWith(color: AppColors.lightGreyColor)),
                    Text(planData?.todoList?.description ?? "",
                        style: $styles.text.h8
                            .copyWith(color: AppColors.blackColor)),
                  ],
                ),
              ),
              SvgPicture.asset(
                DailyActivityUtils.getDayCardImage(
                    planData, cubit.currentDay ?? 1),
                width: 48.sps,
                height: 70.sps,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTickSymbol() {
    return (false)
        ? Container(
            height: 30.sps,
            width: 30.sps,
            decoration: const BoxDecoration(
                color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
                child: Icon(Icons.check_rounded,
                    color: AppColors.white, size: 16.sps)))
        : Container(
            height: 30.sps,
            width: 30.sps,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyColor)),
          );
  }
}
