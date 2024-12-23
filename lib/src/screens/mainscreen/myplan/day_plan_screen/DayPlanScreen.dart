import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/habit_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/medicine_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/nutrition_activity_screen.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_screen/cubit/day_plan_cubit.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../styles/styles.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/daily_activity_utils.dart';

class DayPlanScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const DayPlanScreen({super.key, required this.data});

  static Widget create(Map<String, dynamic> argumentData) {
    var isNotification = argumentData["isNotification"] ?? false;
    var todoOrderId = argumentData["todoOrderId"] ?? "";
    var taskId = argumentData["taskId"] ?? "";
    return BlocProvider(
        create: (BuildContext context) => DayPlanCubit(
            isNotification,
            todoOrderId,
            taskId,
            isNotification ? null : argumentData["dayData"],
            isNotification ? 1 : argumentData["currentDay"]),
        child: DayPlanScreen(data: argumentData));
  }

  @override
  State<DayPlanScreen> createState() => _DayPlanScreenState();
}

class _DayPlanScreenState extends State<DayPlanScreen> {
  List<Widget> list = [];
  DayPlanCubit? cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: customAppBar( "Day ${cubit?.dayData?.day??""} - ${cubit?.dayData?.todoList?.title??""}")),*/
      body: BlocConsumer<DayPlanCubit, DayPlanState>(
        listener: (context, state) {
          if (state is DayPlanLoading) {
            context.loaderOverlay.show();
          } else if (state is DayPlanInitial) {
            context.loaderOverlay.hide();
          } else if (state is DayPlanSuccess) {
            context.loaderOverlay.hide();
            openTask();
          } else if (state is CompleteTaskSuccess) {
            context.loaderOverlay.hide();
            if (cubit?.dayData?.status == 1) {
              showAllTaskDoneSheet();
            }
          } else if (state is DayPlanError) {
            context.loaderOverlay.hide();
            AppUtils.showToast(state.errorMessage);
          } else if (state is DayPlanNoInternet) {
            context.loaderOverlay.hide();
            AppUtils.showToast(AppConstants.noInternetTitle);
          }
        },
        builder: (context, state) {
          cubit = BlocProvider.of<DayPlanCubit>(context);
          if (state is DayPlanInitial ||
              state is DayPlanError ||
              state is DayPlanNoInternet ||
              state is CompleteTaskSuccess ||
              state is DayPlanLoading ||
              state is DayPlanSuccess) {
            return getMainData();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget getMainData() {
    return SafeArea(
      child: Container(
        color: AppColors.screenBackground,
        child: Column(
          children: [
            SizedBox(
              height: 16.sps,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, cubit?.dayData?.status ?? 0);
                  },
                  child: Container(
                    width: 44.sps,
                    height: 44.sps,
                    margin: EdgeInsets.only(left: 16.sps),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: Image.asset(ImageAssetPath.icBack,
                        width: 20.sps, height: 20.sps),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 60.sps),
                    child: Text(
                        "Day ${cubit?.dayData?.day ?? ""} - ${cubit?.dayData?.todoList?.title ?? ""}",
                        textAlign: TextAlign.center,
                        style: $styles.text.body1
                            .copyWith(color: AppColors.blackColor)),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(16.sps),
                  itemCount:
                      (cubit?.dayData?.todoList?.todoListTasks?.length ?? 0) +
                          1,
                  itemBuilder: (BuildContext context, int index) {
                    return (index == 0)
                        ? getHeaderWidget()
                        : Padding(
                            padding: EdgeInsets.only(bottom: 16.sps),
                            child: getDietWidget(
                                cubit?.dayData?.todoList
                                    ?.todoListTasks?[index - 1],
                                index - 1),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDietWidget(TodoListTasks? activityData, int index) {
    return GestureDetector(
      onTap: () {
        openParticularTask(activityData);
      },
      child: Card(
          margin: EdgeInsets.zero,
          surfaceTintColor: AppColors.white,
          shape: ((cubit?.nextSelectedTask ?? -1) == index)
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
          color: (activityData?.todoListResponses?.isNotEmpty ?? false)
              ? AppColors.lightGreenColor
              : AppColors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sps, vertical: 20.sps),
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
                                  : TextDecoration.none)),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        if (activityData?.type ==
                                AppConstants.mindfulnessGratitudeSubtype &&
                            activityData?.subType ==
                                AppConstants.mindfulnessGratitudeSubtype) {
                          openGratitudeScreen(activityData);
                        } else if ((activityData?.type ==
                                    AppConstants.fitnessActivityType &&
                                activityData?.subType ==
                                    AppConstants.fitnessVideoSubtype) ||
                            (activityData?.type ==
                                    AppConstants.mindfulnessGratitudeSubtype &&
                                activityData?.subType ==
                                    AppConstants.mindfulnessVideoSubtype)) {
                          openWorkoutScreen(activityData);
                        } else {
                          if (activityData?.todoListResponses?.length == 0) {
                            Map<String, dynamic>? map = {
                              "todoOrderId": cubit?.dayData?.id,
                              "todoListId": cubit?.dayData?.todoListId,
                              "todoListTaskId": activityData?.id,
                              /*"text": "gratitude",
                           "watchTime": "watch-time"*/
                            };
                            cubit?.saveActivityData(map);
                          }
                        }
                      },
                      child: DailyActivityUtils.getActivityCardTick(
                          cubit?.dayData, activityData, cubit?.currentDay ?? 0),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void openWorkoutScreen(TodoListTasks? activityData) async {
    Map<String, dynamic> data = {
      "activityData": activityData,
      "dayData": cubit?.dayData,
      "currentDay": cubit?.currentDay,
    };

    var result = await Navigator.pushNamed(context, AppScreens.workoutActivity,
        arguments: data) as TodoListTasks?;

    if (result != null) {
      activityData = result;
      cubit?.refreshData();
      if (cubit?.dayData?.status == 1) {
        showAllTaskDoneSheet();
      }
    }

    // RouteNavigator.pushNamed(context,AppScreens.workoutActivity,arguments: data);
  }

  Future<void> openGratitudeScreen(TodoListTasks? activityData) async {
    int selectedDay = 0;
    int currentDay = 0;

    currentDay = cubit?.currentDay ?? 1;
    selectedDay = (cubit?.dayData?.day ?? 1).toInt();
    if (selectedDay > currentDay) {
      AppUtils.showToast("You can't add future gratitude");
    } else {
      Map<String, dynamic> data = {
        "activityData": activityData,
        "dayData": cubit?.dayData,
        "currentDay": cubit?.currentDay,
      };
      var result = await Navigator.pushNamed(
              context, AppScreens.gratitudeDetailsScreen, arguments: data)
          as TodoListTasks?;
      if (result != null) {
        activityData = result;
        cubit?.refreshData();
        if (cubit?.dayData?.status == 1) {
          showAllTaskDoneSheet();
        }
      }
    }
  }

  Widget getHeaderWidget() {
    return Column(
      children: [
        SvgPicture.asset(
            DailyActivityUtils.getDayCardImage(
                cubit?.dayData, cubit?.currentDay ?? 0),
            height: 140.sps),
        SizedBox(
          height: 24.sps,
        ),
        Text(cubit?.dayData?.todoList?.description ?? "",
            style: $styles.text.h6.copyWith(color: AppColors.blackColor)),
        SizedBox(
          height: 16.sps,
        )
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

  Widget customAppBar(String title) {
    return AppBar(
      backgroundColor: AppColors.screenBackground,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context, cubit?.dayData?.status ?? 0);
        },
        child: Container(
          width: 50.sps,
          height: 50.sps,
          margin: EdgeInsets.only(left: 16.sps),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child:
              Image.asset(ImageAssetPath.icBack, width: 20.sps, height: 20.sps),
        ),
      ),
      title: Text(title ?? "",
          style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
      centerTitle: true,
    );
  }

  void openTask() {
    var taskId = int.parse(cubit?.taskId ?? "-1");
    cubit?.dayData?.todoList?.todoListTasks?.forEach((taskData) {
      if ((taskData.id ?? -1) == taskId) {
        openParticularTask(taskData);
      }
    });
  }

  void openParticularTask(TodoListTasks? activityData) {
    switch (activityData?.type) {
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
      case AppConstants.nutritionActivityType:
        {
          if (activityData?.subType == AppConstants.nutritionDrinkingSubtype) {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                backgroundColor: AppColors.lightestGreyColor1,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return HabitActivityScreen(activityDayData: activityData!);
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
      case AppConstants.mindfulnessActivityType:
        {
          if (activityData?.subType ==
              AppConstants.mindfulnessGratitudeSubtype) {
            openGratitudeScreen(activityData);
          } else if (activityData?.subType ==
              AppConstants.mindfulnessVideoSubtype) {
            openWorkoutScreen(activityData);
          }
          break;
        }
      case AppConstants.fitnessActivityType:
        {
          if (activityData?.subType == AppConstants.fitnessVideoSubtype) {
            openWorkoutScreen(activityData);
          } else if (activityData?.subType == AppConstants.fitnessTextSubtype) {
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
                  return HabitActivityScreen(activityDayData: activityData!);
                });
          }
          break;
        }
    }
  }
}
