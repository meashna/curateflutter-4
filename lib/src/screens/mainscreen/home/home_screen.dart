import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/mainscreen/home/cubit/home_screen_cubit.dart';
import 'package:curate/src/screens/mainscreen/mainCubit/main_screen_cubit.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/habit_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/medicine_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/nutrition_activity_screen.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:curate/src/widgets/no_internet_widget.dart';
import 'package:curate/src/widgets/refresh_indicator_widget.dart';
import 'package:curate/src/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../constants/asset_path.dart';
import '../../../data/models/response/questions/WeeklyAssessmentScore.dart';
import '../../../utils/notification/notification_count_bloc/notification_count_cubit.dart';
import '../../../utils/notification/notification_count_bloc/notification_count_state.dart';
import 'mood_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => HomeScreenCubit(),
        child: const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenCubit cubit;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        if (state is HomeScreenLoading) {
          //context.loaderOverlay.show();
        } else if (state is TaskSubmitLoading) {
          context.loaderOverlay.show();
        } else if (state is HomeScreenInitial) {
          context.loaderOverlay.hide();
          if (state.intialStateType == AppConstants.homeScreenMoodType) {
            Map<String, dynamic> map = {
              AppConstants.planTotalWeek: cubit.totalWeek,
              AppConstants.planTotalDay:
                  cubit.homeResponse?.data?.planDays ?? 0,
              AppConstants.planCurrentDay:
                  cubit.homeResponse?.data?.currDay ?? 0,
            };
            RouteNavigator.pushNamed(context, AppScreens.moodDetails,
                arguments: map);
          }
        } else if (state is CompleteTaskSuccess) {
          context.loaderOverlay.hide();
          if (cubit.dayData?.status == 1) {
            showAllTaskDoneSheet();
          }
        } else if (state is HomeScreenError) {
          context.loaderOverlay.hide();
          AppUtils.showToast(state.errorMessage);
        } else if (state is HomeScreenNoInternet) {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        cubit = BlocProvider.of<HomeScreenCubit>(context);
        if (state is HomeScreenError) {
          return CustomErrorWidget(() {
            cubit.getHomeData();
          });
        }

        if (state is HomeScreenLoading) {
          return SkeltonView();
        }

        if (state is HomeScreenInitial) {
          if (cubit.isPlanExpired) {
            var mainCubit = BlocProvider.of<MainScreenCubit>(context);
            mainCubit.updateExpireView(
                isAssementPending:
                    (cubit.homeResponse?.data?.isPendingAssessment ?? false));
            return Scaffold();
          }
          return Container(
              color: AppColors.screenBackground, child: getMainWidget());
        } else if (state is HomeScreenNoInternet) {
          return NoInternetWidget(() {
            cubit.getHomeData();
          });
        } else {
          return Container(
              color: AppColors.screenBackground, child: getMainWidget());
        }
      },
    );
  }

  Widget SkeltonView() {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
            left: 16.sps, top: 16.sps, bottom: 16.sps, right: 16.sps),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 15.sps,
                      width: 100.sps,
                    ),
                    SizedBox(
                      height: 2.sps,
                    ),
                    ShimmerWidget.rectangular(
                      height: 25.sps,
                      width: 130.sps,
                    ),
                  ],
                ),
              ),
              ShimmerWidget.rectangularbBg(
                height: 45.sps,
                width: 130.sps,
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
          SizedBox(
            height: 32.sps,
          ),
          Row(
            children: [
              ShimmerWidget.rectangular(
                height: 26.sps,
                width: 200.sps,
              ),
            ],
          ),
          SizedBox(
            height: 12.sps,
          ),
          SizedBox(
            height: 70.sp,
            //width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cubit.dailyMoodesponse?.options?.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width / 5) - 3.3,
                    //child: Container(color: Colors.red,),
                    child: Column(
                      children: [
                        ShimmerWidget.circular(
                          height: 50.sps,
                          width: 50.sps,
                        ),
                        SizedBox(
                          height: 8.sps,
                        ),
                        ShimmerWidget.rectangular(
                          height: 16.sps,
                          width: 60.sps,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 12.sps,
          ),
          Row(
            children: [
              ShimmerWidget.rectangular(
                height: 24.sps,
                width: 120.sps,
              ),
            ],
          ),
          SizedBox(
            height: 32.sps,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget.rectangular(
                height: 26.sps,
                width: 120.sps,
              ),
              ShimmerWidget.rectangular(
                height: 21.sps,
                width: 80.sps,
              ),
            ],
          ),
          SizedBox(height: 16.sps),
          SizedBox(
            height: 32.sps,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.0.sps),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        index == 0
                            ? ShimmerWidget.rectangular(
                                height: 16.sps,
                                width: 50.sps,
                              )
                            : Container(
                                height: 16,
                              ),
                        SizedBox(
                          height: 8.sps,
                        ),
                        ShimmerWidget.rectangular(
                          height: 6.sps,
                          width: 60.sps,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 16.sps),
          ShimmerWidget.rectangular(
            height: 100.sps,
          ),
          SizedBox(height: 32.sps),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerWidget.rectangular(
                height: 26.sps,
                width: 140.sps,
              ),
              ShimmerWidget.rectangular(
                height: 27.sps,
                width: 60.sps,
              ),
            ],
          ),
          SizedBox(height: 16.sps),
          SizedBox(
            height: 250.sps,
            child: GridView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ShimmerWidget.rectangular(
                height: 100.sps,
                width: MediaQuery.of(context).size.width - 100,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.4,
                mainAxisSpacing: 8.sps,
                crossAxisSpacing: 8.sps,
              ),
            ),
          ),
          SizedBox(height: 32.sps),
        ],
      ),
    );
  }

  Widget getMainWidget() {
    print("cubit.showUpgradeButton");
    print(cubit.showUpgradeButton);
    return CustomRefresIndicator(
      onRefresh: () => cubit.getHomeData(),
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.screenBackground,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.sps, top: 16.sps, bottom: 16.sps, right: 16.sps),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DailyActivityUtils.greeting(),
                            style: $styles.text.body2
                                .copyWith(color: AppColors.lightGreyColor),
                          ),
                          Text(
                            cubit.username?.name ?? "",
                            style: $styles.text.h5
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ],
                      ),
                    ),
                    (cubit.showUpgradeButton)
                        ? SizedBox(
                            height: 45.sps,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  //side: BorderSide(color: Colors.red)
                                )),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppScreens.choosePlan);
                              },
                              child: Text(
                                "Upgrade",
                                style: $styles.text.h9
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          )
                        : Container(),
                    BlocConsumer<NotificationCountCubit,
                        NotificationCountState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppScreens.notification);
                          },
                          child: Container(
                            width: 50.sps,
                            height: 50.sps,
                            margin: EdgeInsets.only(left: 16.sps),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Container(
                                padding: EdgeInsets.all(14.sps),
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                        ImageAssetPath.icNotification),
                                    state.count == null
                                        ? Container()
                                        : state.count! < 1
                                            ? Container()
                                            : Positioned(
                                                right: 0,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              AppColors.white),
                                                  width: 10.sps,
                                                  height: 10.sps,
                                                  child: Center(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColors
                                                                  .primary),
                                                      width: 8.sps,
                                                      height: 8.sps,
                                                    ),
                                                  ),
                                                ),
                                              )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.sps,
                ),
                Text(cubit.dailyMoodesponse?.title ?? "",
                    style:
                        $styles.text.h6.copyWith(color: AppColors.blackColor)),
                SizedBox(
                  height: 12.sps,
                ),
                SizedBox(
                  height: 70.sp,
                  //width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.dailyMoodesponse?.options?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width:
                                (MediaQuery.of(context).size.width / 5) - 3.3,
                            //child: Container(color: Colors.red,),
                            child: MoodContent(
                              image: DailyActivityUtils.getMoodImage(index),
                              title: cubit.dailyMoodesponse?.options?[index]
                                      .optionTitle ??
                                  "",
                              index: cubit.dailyMoodesponse?.options?[index].id
                                      ?.toInt() ??
                                  0,
                              isSelected: cubit.dailyMoodesponse
                                      ?.options?[index].selected ??
                                  false,
                            ));
                      }),
                ),
                SizedBox(
                  height: 12.sps,
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Expanded(
                      child: Text(
                        (cubit.homeResponse?.data?.lastSubmitDate == null)
                            ? "Not submitted yet"
                            : "Last submitted ${timeago.format(DateTime.parse(cubit.homeResponse?.data?.lastSubmitDate ?? ""))}.",
                        style: $styles.text.body1
                            .copyWith(color: AppColors.lightGreyColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> map = {
                          AppConstants.planTotalWeek: cubit.totalWeek,
                          AppConstants.planTotalDay:
                              cubit.homeResponse?.data?.planDays ?? 0,
                          AppConstants.planCurrentDay:
                              cubit.homeResponse?.data?.currDay ?? 0,
                        };

                        RouteNavigator.pushNamed(
                            context, AppScreens.moodDetails,
                            arguments: map);
                      },
                      child: Visibility(
                        visible: (cubit.homeResponse?.data?.currDay == 1 &&
                                cubit.homeResponse?.data?.lastSubmitDate ==
                                    null)
                            ? false
                            : true,
                        child: Text(
                          "View",
                          style: $styles.text.body2
                              .copyWith(color: AppColors.blackColor),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.sps,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text("My plan",
                          style: $styles.text.h6
                              .copyWith(color: AppColors.blackColor)),
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<MainScreenCubit>(context)
                            .setNAvigationIndex(1);
                        //RouteNavigator.pushNamed(context,AppScreens.workoutActivity);
                      },
                      child: Text("View all",
                          style: $styles.text.body2
                              .copyWith(color: AppColors.blackColor)),
                    ),
                  ],
                ),
                SizedBox(height: 16.sps),
                (cubit.enableWeek ?? 0) > 0
                    ? SizedBox(
                        height: 36.sps,
                        child: ScrollablePositionedList.builder(
                            initialScrollIndex: (cubit.enableWeek ?? 0) - 1,
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.totalWeek,
                            itemScrollController: itemScrollController,
                            scrollOffsetListener: scrollOffsetListener,
                            itemPositionsListener: itemPositionsListener,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.sps),
                                  child: barWidget(index),
                                ),
                              );
                            }),
                      )
                    : Container(),
                SizedBox(height: 16.sps),
                GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> data = {
                        "isNotification": false,
                        "dayData": cubit.homeResponse?.data?.data,
                        "currentDay": cubit.homeResponse?.data?.currDay
                      };

                      var result = await Navigator.pushNamed(
                          context, AppScreens.dayPlanScreen,
                          arguments: data) as num?;
                      cubit.getHomeData();
                    },
                    child: getDayWidget()),
                SizedBox(height: 32.sps),
                Visibility(
                  visible: cubit.todoListResponses != null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text("Today's progress",
                                style: $styles.text.h6
                                    .copyWith(color: AppColors.blackColor)),
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  "${DailyActivityUtils.calculateCompletedTask(cubit.todoListResponses)} ",
                              style: $styles.text.h7
                                  .copyWith(color: AppColors.blackColor),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "/ ${cubit.todoListResponses?.length ?? 0}",
                                  style: $styles.text.title2.copyWith(
                                      color: AppColors.lightGreyColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.sps),
                      SizedBox(
                        height: 250.sps,
                        child: GridView.builder(
                          itemCount: cubit.todoListResponses?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => getDietWidget(
                              cubit.todoListResponses?[index], index),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.4,
                            mainAxisSpacing: 8.sps,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.sps),
                Visibility(
                  visible:
                      (cubit.homeResponse?.data?.isPendingAssessment ?? false),
                  //visible: (true),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wellbeing Assessment",
                          style: $styles.text.h6
                              .copyWith(color: AppColors.blackColor)),
                      SizedBox(height: 16.sps),
                      getWellBeingAssessment()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDayWidget() {
    if (cubit.dayResponse == null) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(24.sps),
        child: Text("No task assigned",
            textAlign: TextAlign.center,
            style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
      );
    } else {
      return Card(
        margin: EdgeInsets.zero,
        surfaceTintColor: AppColors.white,
        color: DailyActivityUtils.getDayCardBackground(
            cubit.dayData, (cubit.homeResponse?.data?.currDay ?? 1).toInt()),
        shape: RoundedRectangleBorder(
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
                  cubit.dayData, cubit.currentDay ?? 1),
              SizedBox(
                width: 12.sps,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Day ${cubit.homeResponse?.data?.currDay ?? ""} - ${cubit.dayResponse?.title ?? ""}",
                        style: $styles.text.body1
                            .copyWith(color: AppColors.lightGreyColor)),
                    Text(cubit.dayResponse?.description ?? "",
                        style: $styles.text.h8
                            .copyWith(color: AppColors.blackColor)),
                  ],
                ),
              ),
              SvgPicture.asset(
                DailyActivityUtils.getDayCardImage(
                    cubit.dayData, cubit.currentDay ?? 0),
                width: 48.sps,
                height: 70.sps,
              )
            ],
          ),
        ),
      );
    }
  }

  Widget getDietWidget(TodoListTasks? activityData, int index) {
    return GestureDetector(
      onTap: () {
        switch (activityData?.type) {
          case AppConstants.nutritionActivityType:
            {
              if (activityData?.subType ==
                  AppConstants.nutritionDrinkingSubtype) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    backgroundColor: AppColors.lightestGreyColor1,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return HabitActivityScreen(
                          activityDayData: activityData!);
                    });
              } else if (activityData?.subType ==
                  AppConstants.nutritionMealsSubtype) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    backgroundColor: AppColors.lightestGreyColor1,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return NutritionActivityScreen(
                          activityDayData: activityData!);
                    });
              }
              break;
            }
          case AppConstants.medicineActivityType:
            {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  backgroundColor: AppColors.lightestGreyColor1,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return RemedyActivityScreen(activityDayData: activityData!);
                  });
              break;
            }

          case AppConstants.mindfulnessActivityType:
            {
              if (activityData?.subType ==
                  AppConstants.mindfulnessGratitudeSubtype) {
                openGratitudeScreen(activityData, index);
              } else if (activityData?.subType ==
                  AppConstants.mindfulnessVideoSubtype) {
                openWorkoutScreen(activityData, index);
              }
              break;
            }
          case AppConstants.fitnessActivityType:
            {
              if (activityData?.subType == AppConstants.fitnessVideoSubtype) {
                openWorkoutScreen(activityData, index);
              } else if (activityData?.subType ==
                  AppConstants.fitnessTextSubtype) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    backgroundColor: AppColors.lightestGreyColor1,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return HabitActivityScreen(
                          activityDayData: activityData!);
                    });
              }
              break;
            }
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8.sps),
        child: Card(
            margin: EdgeInsets.zero,
            surfaceTintColor: AppColors.white,
            color: (activityData?.todoListResponses?.isNotEmpty ?? false)
                ? AppColors.lightGreenColor
                : AppColors.white,
            shape: ((cubit.nextSelectedTask ?? -1) == index)
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
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12.sps),
                  ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.sps, vertical: 20.sps),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.sps, horizontal: 16.sps),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sps),
                              color:
                                  DailyActivityUtils.getActivityTitleBackground(
                                      activityData?.type ?? 0)),
                          child: Text(
                            activityData?.tag ?? "",
                            style: $styles.text.title3.copyWith(
                                color: DailyActivityUtils.getActivityTitleColor(
                                    activityData?.type ?? 0)),
                          ),
                        ),
                        const Spacer(),
                        ((activityData?.timing ?? "").isNotEmpty)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ImageAssetPath.icDietTime),
                                  SizedBox(
                                    width: 8.sps,
                                  ),
                                  Text(
                                    DateTimeUtils.getActivityTime(
                                            activityData?.timing) ??
                                        "",
                                    style: $styles.text.body2.copyWith(
                                        color: AppColors.lightGreyColor),
                                  )
                                ],
                              )
                            : Container()
                      ]),
                  SizedBox(height: 16.sps),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(activityData?.taskTitle ?? "",
                            style: $styles.text.h8.copyWith(
                                color: AppColors.blackColor,
                                decoration: (activityData
                                            ?.todoListResponses?.isNotEmpty ??
                                        false)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          if (activityData?.type ==
                                  AppConstants.mindfulnessGratitudeSubtype &&
                              activityData?.subType ==
                                  AppConstants.mindfulnessGratitudeSubtype) {
                            openGratitudeScreen(activityData, index);
                          } else if ((activityData?.type ==
                                      AppConstants.fitnessActivityType &&
                                  activityData?.subType ==
                                      AppConstants.fitnessVideoSubtype) ||
                              (activityData?.type ==
                                      AppConstants
                                          .mindfulnessGratitudeSubtype &&
                                  activityData?.subType ==
                                      AppConstants.mindfulnessVideoSubtype)) {
                            openWorkoutScreen(activityData, index);
                          } else {
                            if (activityData?.todoListResponses?.length == 0) {
                              Map<String, dynamic>? map = {
                                "todoOrderId": cubit.dayData?.id,
                                "todoListId": cubit.dayData?.todoListId,
                                "todoListTaskId": activityData?.id,
                                /*"text": "gratitude",
                           "watchTime": "watch-time"*/
                              };
                              cubit.saveActivityData(map);
                            }
                          }
                        },
                        child: DailyActivityUtils.getActivityCardTick(
                            cubit.dayData, activityData, cubit.currentDay ?? 1),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void openWorkoutScreen(TodoListTasks? activityData, int index) async {
    Map<String, dynamic> data = {
      "activityData": activityData,
      "dayData": cubit.homeResponse?.data?.data,
      "currentDay": cubit.homeResponse?.data?.currDay,
    };

    var result = await Navigator.pushNamed(context, AppScreens.workoutActivity,
        arguments: data) as TodoListTasks?;

    if (result != null) {
      activityData = result;
      cubit.refreshData(activityData, index);
      if (cubit.dayData?.status == 1) {
        showAllTaskDoneSheet();
      }
    }
  }

  Future<void> openGratitudeScreen(
      TodoListTasks? activityData, int index) async {
    Map<String, dynamic> data = {
      "activityData": activityData,
      "dayData": cubit.homeResponse?.data?.data,
      "currentDay": cubit.homeResponse?.data?.currDay,
    };

    var result = await Navigator.pushNamed(
            context, AppScreens.gratitudeDetailsScreen, arguments: data)
        as TodoListTasks?;

    if (result != null) {
      activityData = result;
      cubit.refreshData(activityData, index);
      if (cubit.dayData?.status == 1) {
        showAllTaskDoneSheet();
      }
    }
  }

  Widget getWellBeingAssessment() {
    return GestureDetector(
      onTap: () {
        final Map<String, dynamic> data = {
          "questionType": AppConstants.wellbeingAssessmentQuestionType
        };
        Navigator.pushNamed(context, AppScreens.wellBeingQuestions,
            arguments: data);

        /*  List<WeeklyAssessmentScore>? assessmentHistory=[];
        for(int i=0;i<1;i++){
          assessmentHistory.add(WeeklyAssessmentScore(week: i+1,percentIncrement: i*10));
        }
        Map<String,dynamic> argument={
          //"scores":result.data?.assessmentHistory
          "scores":assessmentHistory
        };

        RouteNavigator.pushNamed(
            context, AppScreens.wellBeingAssessment,arguments: argument);*/
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: AppColors.primary,
        child: Padding(
          padding: EdgeInsets.all(16.sps),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.white, shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(15.sps),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      ImageAssetPath.icTimer,
                      height: 20.sps,
                      width: 20.sps,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.sps),
              Text("Next Assessment in 7 days.",
                  style: $styles.text.h8.copyWith(color: AppColors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget barWidget(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (index + 1 <= cubit.enableWeek) ? "Week ${index + 1}" : "",
          style: $styles.text.title4.copyWith(color: AppColors.darkGreyColor),
        ),
        SizedBox(
          height: 8.sps,
        ),
        Container(
            height: 6.sps,
            width: 60.sps,
            decoration: BoxDecoration(
                color: (index + 1 <= cubit.enableWeek)
                    ? AppColors.primary
                    : AppColors.lightestGreyColor,
                borderRadius: BorderRadius.circular(8.sps)))
      ],
    );
  }

  Future showAllTaskDoneSheet() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        backgroundColor: AppColors.lightestGreyColor1,
        context: context,
        builder: (context) {
          return Wrap(
            spacing: 32.sps,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32.sps),
                    child: Center(
                        child:
                            SvgPicture.asset(ImageAssetPath.icTaskCompleted)),
                  ),
                  Positioned(
                      right: 10.sps,
                      top: 16.sps,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50.sps,
                          width: 50.sps,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.white),
                          child: Image.asset(
                            ImageAssetPath.icClose,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 32.sps,
              ),
              Center(
                child: Text(
                  "Congratulations!\nYou have finished all your \ntasks for the day!",
                  style: $styles.text.h6.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 32.sps,
              ),
            ],
          );
        });
  }
}
