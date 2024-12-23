import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HabitActivityScreen extends StatefulWidget {
  TodoListTasks activityDayData;
  HabitActivityScreen({super.key, required this.activityDayData});

  @override
  State<HabitActivityScreen> createState() => _HabitActivityScreenState();
}

class _HabitActivityScreenState extends State<HabitActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () {
                RouteNavigator.goBack();
              },
              child: Container(
                width: 50.sps,
                height: 50.sps,
                margin: EdgeInsets.all(16.sps),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Image.asset(ImageAssetPath.icClose,
                    width: 20.sps, height: 20.sps),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 52.sps),
                SvgPicture.asset(ImageAssetPath.ivHabitActivity),
                SizedBox(height: 44.sps),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.sps, horizontal: 16.sps),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sps),
                      color: DailyActivityUtils.getActivityTitleBackground(
                          AppConstants.nutritionActivityType)),
                  child: Text(
                    widget.activityDayData.tag ?? "",
                    style: $styles.text.title3.copyWith(
                        color: DailyActivityUtils.getActivityTitleColor(
                            AppConstants.nutritionActivityType)),
                  ),
                ),
                SizedBox(height: 10.sps),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sps),
                  child: Center(
                    child: Text(widget.activityDayData.taskTitle ?? "",
                        textAlign: TextAlign.center,
                        style: $styles.text.h6
                            .copyWith(color: AppColors.blackColor)),
                  ),
                ),
                SizedBox(height: 16.sps),
                Padding(
                  padding: EdgeInsets.only(
                      left: 32.sps, right: 32.sps, bottom: 40.sps),
                  child: Text(
                    widget.activityDayData.taskDescription ?? "",
                    style: $styles.text.body2
                        .copyWith(color: AppColors.darkGreyColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
