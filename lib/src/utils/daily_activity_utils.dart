import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/response/home2/TodoList.dart';

class DailyActivityUtils {
  static Color getActivityTitleBackground(num activityType) {
    switch (activityType) {
      /* case AppConstants.habitActivityType:
        {
          return AppColors.habitBackgroundColor;
        }*/

      case AppConstants.mindfulnessActivityType:
        {
          return AppColors.mindfulnessBackgroundColor;
        }

      case AppConstants.medicineActivityType:
        {
          return AppColors.medicineBackgroundColor;
        }

      case AppConstants.nutritionActivityType:
        {
          return AppColors.nutritionBackgroundColor;
        }

      case AppConstants.fitnessActivityType:
        {
          return AppColors.workoutBackgroundColor;
        }
      default:
        {
          return AppColors.habitBackgroundColor;
        }
    }
  }

  static Color getActivityTitleColor(num activityType) {
    switch (activityType) {
      /*  case AppConstants.habitActivityType:
        {
          return AppColors.habitTextColor;
        }*/

      case AppConstants.mindfulnessActivityType:
        {
          return AppColors.mindfulnessTextColor;
        }

      case AppConstants.medicineActivityType:
        {
          return AppColors.medicineTextColor;
        }

      case AppConstants.nutritionActivityType:
        {
          return AppColors.nutritionTextColor;
        }

      case AppConstants.fitnessActivityType:
        {
          return AppColors.workoutTextColor;
        }
      default:
        {
          return AppColors.habitTextColor;
        }
    }
  }

  /*static String getActivityTitleTag(TodoListTasks? taskData) {
    switch (taskData?.type) {
      case AppConstants.nutritionActivityType:
        {
          return "Nutrition";
        }

      case AppConstants.mindfulnessActivityType:
        {
          return "Mindfulness";
        }

      case AppConstants.fitnessActivityType:
        {
          return "Fitness";
        }

      case AppConstants.medicineActivityType:
        {
          return "Remedy";
        }


      default:
        {
          return  "Nutrition" ;
        }
    }
  }*/

  static int calculateCompletedTask(List<TodoListTasks>? todoListResponses) {
    int count = 0;
    if (todoListResponses?.isNotEmpty ?? false) {
      for (var data in todoListResponses!) {
        if (data.todoListResponses?.isNotEmpty ?? false) {
          count++;
        }
      }
    }
    return count;
  }

  static List<String> calculateGraphDay(currentDay) {
    List<String> list = [];
    var date = DateTime.now();
    var startDate = date.subtract(Duration(days: (currentDay - 1)));
    list.add(DateFormat('E').format(startDate)[0]);
    for (int i = 0; i < 6; i++) {
      var temp = startDate.add(Duration(days: i + 1));
      list.add(DateFormat('E').format(temp)[0]);
    }

    return list;
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning,';
    }
    if (hour < 17) {
      return 'Good afternoon,';
    }
    return 'Good evening,';
  }

  static int findNextTasks(TodoList? tasks) {
    int index = 0;

    if (tasks != null) {
      for (int i = 0; i < (tasks.todoListTasks?.length ?? 0); i++) {
        if (tasks.todoListTasks?[i].todoListResponses?.isEmpty ?? false) {
          index = i;
          break;
        }
      }
    }
    return index;
  }

  static Color getDayCardBackground(Data? dayData, int currentDay) {
    if ((dayData?.day ?? 1) < currentDay) {
      if (dayData?.status == 1) {
        return AppColors.lightGreenColor;
      } else {
        return AppColors.unCompletedTask;
      }
    } else if ((dayData?.day ?? 1) == currentDay) {
      if (dayData?.status == 1) {
        return AppColors.lightGreenColor;
      } else {
        return AppColors.white;
      }
    } else {
      return AppColors.white;
    }
  }

  static String getDayCardImage(Data? dayData, int currentDay) {
    if ((dayData?.day ?? 1) < currentDay) {
      if (dayData?.status == 1) {
        if ((dayData?.day ?? 1) < 7) {
          return getDayImage((dayData?.day ?? 1).toInt());
        } else {
          return getDayImage(((dayData?.day ?? 1).toInt()) % 7);
        }
      } else {
        if ((dayData?.day ?? 1) < 7) {
          return getPendingDayStatusImage((dayData?.day ?? 1).toInt());
        } else {
          return getPendingDayStatusImage(((dayData?.day ?? 1).toInt()) % 7);
        }
      }
    } else {
      if ((dayData?.day ?? 1) < 7) {
        return getDayImage((dayData?.day ?? 1).toInt());
      } else {
        return getDayImage(((dayData?.day ?? 1).toInt()) % 7);
      }
    }
  }

  static Widget getDayCardTick(Data? dayData, int currentDay) {
    if ((dayData?.day ?? 1) < currentDay) {
      if (dayData?.status == 1) {
        return getTickSymbol(AppConstants.completedTick);
      } else {
        return getTickSymbol(AppConstants.disabledTick);
      }
    } else if ((dayData?.day ?? 1) == currentDay) {
      if (dayData?.status == 1) {
        return getTickSymbol(AppConstants.completedTick);
      } else {
        return getTickSymbol(AppConstants.emptyTick);
      }
    } else {
      return getTickSymbol(AppConstants.emptyTick);
    }
  }

  static Widget getActivityCardTick(
      Data? dayData, TodoListTasks? activityData, int currentDay) {
    if ((dayData?.day ?? 1) < currentDay) {
      return getTickSymbol(AppConstants.hideTick);
    } else if (activityData?.todoListResponses?.isNotEmpty ?? false) {
      return getTickSymbol(AppConstants.completedTick);
    } else if ((dayData?.day ?? 1) == currentDay) {
      return getTickSymbol(AppConstants.emptyTick);
    } else {
      return getTickSymbol(AppConstants.hideTick);
    }
  }

  static Widget getTickSymbol(int type) {
    switch (type) {
      case AppConstants.emptyTick:
        {
          return Container(
            height: 30.sps,
            width: 30.sps,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyColor)),
          );
        }
      case AppConstants.completedTick:
        {
          return Container(
              height: 30.sps,
              width: 30.sps,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
              child: Center(
                  child: Icon(Icons.check_rounded,
                      color: AppColors.white, size: 16.sps)));
        }
      case AppConstants.disabledTick:
        {
          return Container(
              height: 30.sps,
              width: 30.sps,
              decoration: const BoxDecoration(
                  color: AppColors.unCompletedCircle, shape: BoxShape.circle),
              child: Center(
                  child: Icon(Icons.close,
                      color: AppColors.tickRed, size: 16.sps)));
          break;
        }
      case AppConstants.hideTick:
        {
          return Container();
          break;
        }
      default:
        {
          return Container(
            height: 30.sps,
            width: 30.sps,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyColor)),
          );
        }
    }
  }

  static int getMyPlanSelectedIndex(int selectedWeek, int currentDay) {
    int currentWeek = ((currentDay ?? 0) / 7).ceil();

    if (currentWeek == selectedWeek) {
      return (((currentDay ?? 1) % 7) == 0) ? 7 : (((currentDay ?? 1) % 7) - 1);
    } else {
      return 0;
    }
  }

  static String getDayImage(int activityDay) {
    switch (activityDay) {
      case 1:
        {
          return ImageAssetPath.imageDay1;
        }
      case 2:
        {
          return ImageAssetPath.imageDay2;
        }
      case 3:
        {
          return ImageAssetPath.imageDay3;
        }
      case 4:
        {
          return ImageAssetPath.imageDay4;
        }
      case 5:
        {
          return ImageAssetPath.imageDay5;
        }
      case 6:
        {
          return ImageAssetPath.imageDay6;
        }
      case 0:
        {
          return ImageAssetPath.imageDay7;
        }
      default:
        {
          return ImageAssetPath.imageDay1;
        }
    }
  }

  static String getPendingDayStatusImage(int activityDay) {
    switch (activityDay) {
      case 1:
        {
          return ImageAssetPath.imagePendingDay1;
        }
      case 2:
        {
          return ImageAssetPath.imagePendingDay2;
        }
      case 3:
        {
          return ImageAssetPath.imagePendingDay3;
        }
      case 4:
        {
          return ImageAssetPath.imagePendingDay4;
        }
      case 5:
        {
          return ImageAssetPath.imagePendingDay5;
        }
      case 6:
        {
          return ImageAssetPath.imagePendingDay6;
        }
      case 0:
        {
          return ImageAssetPath.imagePendingDay7;
        }
      default:
        {
          return ImageAssetPath.imagePendingDay1;
        }
    }
  }

  static String getDateRange(HealthLogData data) {
    DateTime startDate =
        DateTimeUtils.getApiDatetoUtc(data.periodCycleFrom) ?? DateTime.now();
    DateTime endDate =
        DateTimeUtils.getApiDatetoUtc(data.periodCycleTo) ?? DateTime.now();

    if (startDate == endDate) {
      return "${DateTimeUtils.getDayMonthYear(startDate)}";
    }
    if (startDate.month != endDate.month || startDate.year != endDate.year) {
      return "${DateTimeUtils.getDayMonthYear(startDate)}"
          " - "
          "${DateTimeUtils.getDayMonthYear(endDate)}";
    } else {
      return "${startDate.day.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')} ${DateTimeUtils.monthYearDate(startDate)}";
    }
  }

  static String getDayCount(HealthLogData data) {
    DateTime startDate =
        DateTimeUtils.getApiDatetoUtc(data.periodCycleFrom) ?? DateTime.now();
    DateTime endDate =
        DateTimeUtils.getApiDatetoUtc(data.periodCycleTo) ?? DateTime.now();

    return (endDate.difference(startDate).inHours / 24).round().toString();
  }

  static String getDayCountWithCurrentDate(HealthLogData data) {
    DateTime startDate =
        DateTimeUtils.getApiDatetoUtc(data.periodCycleTo) ?? DateTime.now();
    DateTime endDate = DateTime.now();

    return (endDate.difference(startDate).inHours / 24).round().toString();
  }

  static String getPeriodEndDate(String? periodCycleTo) {
    if (periodCycleTo == null) {
      return "Period";
    } else {
      DateTime endDate =
          DateTimeUtils.getApiDatetoUtc(periodCycleTo) ?? DateTime.now();

      int dayNum = endDate.day;
      String suffix = "";
      if (dayNum >= 11 && dayNum <= 13) {
        suffix = 'th';
      }

      switch (dayNum % 10) {
        case 1:
          {
            suffix = 'st';
            break;
          }

        case 2:
          {
            suffix = 'nd';
            break;
          }
        case 3:
          {
            suffix = 'rd';
            break;
          }
        default:
          {
            suffix = 'th';
            break;
          }
      }

      return DateFormat("dd'$suffix' MMM").format(endDate);
    }

    //Jiffy.parseFromMap({Unit.year: 1997, Unit.month: 9, Unit.day: 23}).format(
  }

  static String getMoodImage(int? index) {
    switch (index) {
      case 0:
        {
          return ImageAssetPath.icMoodJoyful;
        }
      case 1:
        {
          return ImageAssetPath.icMoodHappy;
        }
      case 2:
        {
          return ImageAssetPath.icMoodNormal;
        }
      case 3:
        {
          return ImageAssetPath.icMoodSad;
        }
      case 4:
        {
          return ImageAssetPath.icMoodUpset;
        }

      default:
        {
          return ImageAssetPath.icMoodJoyful;
        }
    }
  }
}
