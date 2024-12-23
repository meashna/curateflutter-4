import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/response/healthLog/HealthLogData.dart';
import '../../../../../../styles/colors.dart';
import '../../../../../../styles/styles.dart';
import '../../../../../../utils/date_time_utils.dart';

class AddCalendarScreen extends StatefulWidget {
  final HealthLogData? data;
  const AddCalendarScreen({super.key, this.data});

  @override
  State<AddCalendarScreen> createState() => _AddCalendarScreenState();
}

class _AddCalendarScreenState extends State<AddCalendarScreen> {
  List<DateTime?> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      DateTime startDate =
          DateTimeUtils.getApiDatetoUtc(widget.data!.periodCycleFrom) ??
              DateTime.now();
      DateTime endDate =
          DateTimeUtils.getApiDatetoUtc(widget.data!.periodCycleTo) ??
              DateTime.now();
      selectedDates.add(startDate);
      selectedDates.add(endDate);
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(
              title: widget.data == null ? "Add log" : "Update log")),
      body: Container(
        width: double.infinity,
        color: AppColors.screenBackground,
        child: Column(
          children: [
            SizedBox(height: 16.sps),
            Text(
              "New period calendar",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 16.sps),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sps),
              child: Text(
                "Mark the date range of your last periods.",
                style:
                    $styles.text.body1.copyWith(color: AppColors.darkGreyColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.sps),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                selectableDayPredicate: (day) =>
                    !(DateTime.now().difference(day).isNegative),
                calendarType: CalendarDatePicker2Type.range,
                weekdayLabelTextStyle: $styles.text.title4
                    .copyWith(color: AppColors.lightGreyColor),
                controlsTextStyle:
                    $styles.text.h8.copyWith(color: AppColors.blackColor),
                dayTextStyle:
                    $styles.text.body1.copyWith(color: AppColors.darkGreyColor),
                selectedDayTextStyle:
                    $styles.text.h8.copyWith(color: AppColors.white),
                selectedRangeDayTextStyle:
                    $styles.text.h8.copyWith(color: AppColors.blackColor),
                selectedDayHighlightColor: AppColors.primary,
                selectedRangeHighlightColor: AppColors.lightGreenColor,
                yearTextStyle:
                    $styles.text.h8.copyWith(color: AppColors.darkGreyColor),
                selectedYearTextStyle:
                    $styles.text.h8.copyWith(color: AppColors.white),
              ),
              value: selectedDates.isEmpty ? [DateTime.now()] : selectedDates,
              onValueChanged: (List<DateTime?> dates) {
                print("dates");
                print(dates);
                selectedDates = dates;
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(16.sps),
              child: AppButton(
                background: AppColors.primary,
                text: "Continue",
                onClicked: () {
                  if (selectedDates.length < 2) {
                    AppUtils.showToast("Please select range of dates");
                  } else {
                    var data = selectedDates;
                    var difference = selectedDates[1]
                        ?.difference(selectedDates[0] ?? DateTime.now());
                    if ((difference?.inDays ?? 0) > 9) {
                      AppUtils.showToast(
                          "The selected range should not be more than 10");
                    } else {
                      Map<String, dynamic> updateData = {"dates": data};
                      if (widget.data != null) {
                        updateData.addAll({"mainData": widget.data});
                      }
                      RouteNavigator.pushNamed(context, AppScreens.flowAddLog,
                          arguments: updateData);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
