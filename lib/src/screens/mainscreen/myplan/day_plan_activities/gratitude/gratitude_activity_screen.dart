import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../widgets/app_text_feild/app_text_from_feild.dart';
import 'cubit/gratitude_activity_cubit.dart';

class GratitudeActivityScreen extends StatefulWidget {
  final Map<String, dynamic> activityMap;
  const GratitudeActivityScreen({super.key, required this.activityMap});

  @override
  State<GratitudeActivityScreen> createState() =>
      _GratitudeActivityScreenState();

  static Widget create(Map<String, dynamic> argumentData) {
    Data? dayData = argumentData["dayData"];
    return BlocProvider(
        create: (BuildContext context) => GratitudeActivityCubit(
            (dayData?.day ?? 1).toInt(),
            argumentData["currentDay"],
            argumentData["activityData"],
            dayData),
        child: GratitudeActivityScreen(activityMap: argumentData));
  }
}

class _GratitudeActivityScreenState extends State<GratitudeActivityScreen> {
  TodoListTasks? activityData;
  Data? dayData;
  GratitudeActivityCubit? cubit;

  TextEditingController descriptionController = TextEditingController();
  var date = DateTimeUtils.getGratitudeData(DateTime.now());
  List<DateTime> list = <DateTime>[];
  int? descriptionCharacterLength;

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    activityData = widget.activityMap["activityData"];
    dayData = widget.activityMap["dayData"];

    for (var i = widget.activityMap["currentDay"] - 1; i >= 0; i--) {
      list.add(date.subtract(Duration(days: i)));
    }

    for (var i = 0; i < 2; i++) {
      list.add(date.add(Duration(days: i + 1)));
    }
    descriptionController.addListener(() {
      setState(() {
        descriptionCharacterLength = descriptionController.text.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title: "For mind")),
      body: SingleChildScrollView(
        child: BlocConsumer<GratitudeActivityCubit, GratitudeActivityState>(
          listener: (context, state) {
            if (state is GratitudeActivityLoading) {
              context.loaderOverlay.show();
            } else if (state is GratitudeActivityInitial) {
              context.loaderOverlay.hide();
              AppUtils.showToast(state.message);
              //RouteNavigator.goBack();
            } else if (state is GratitudeSaveCompletionState) {
              context.loaderOverlay.hide();
              AppUtils.showToast(state.successMessage);
              Navigator.pop(context, cubit?.gratitudeData);
            } else if (state is GratitudeDataInitialState) {
              context.loaderOverlay.hide();
            } else if (state is GratitudeActivityError) {
              context.loaderOverlay.hide();
              AppUtils.showToast(state.errorMessage);
            }
          },
          builder: (context, state) {
            cubit = BlocProvider.of<GratitudeActivityCubit>(context);
            return mainContent();
          },
        ),
      ),
    );
  }

  Widget mainContent() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 14.sps),
          SvgPicture.asset(ImageAssetPath.ivGratitudeActivity, height: 102.sps),
          SizedBox(height: 16.sps),
          Text(activityData?.taskTitle ?? "",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor)),
          SizedBox(height: 16.sps),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.sps),
            child: Text(
              activityData?.taskDescription ?? "",
              style:
                  $styles.text.body2.copyWith(color: AppColors.darkGreyColor),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 14.sps),
          SizedBox(
            height: 120.sps,
            child: ScrollablePositionedList.builder(
                initialScrollIndex: (((dayData?.day ?? 1).toInt() - 3) < 0)
                    ? 0
                    : ((dayData?.day ?? 1).toInt() - 3),
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemScrollController: itemScrollController,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      cubit?.getGratitudeData(list[index], index + 1);
                      /*   setState(() {
                        date = list[index];
                      });*/
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: dateWidget(list[index])),
                  );
                }),
          ),
          getGratitudeWidget()
        ],
      ),
    );
  }

  Widget dateWidget(DateTime date1) {
    return Column(
      children: [
        SizedBox(
          height: 60.sps,
          width: 60.sps,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              (cubit?.selectedDate?.difference(date1).inDays == 0)
                  ? SizedBox(
                      height: 50.sps,
                      width: 50.sps,
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        color: AppColors.primary,
                        shadowColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.sps),
                        ),
                        child: Center(
                            child: Text(DateFormat.d().format(date1),
                                style: $styles.text.h8
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
                        DateFormat.d().format(date1),
                        style: $styles.text.h8
                            .copyWith(color: AppColors.blackColor),
                      )),
                    ),
            ],
          ),
        ),
        SizedBox(height: 8.sps),
        Text(DateFormat.LLL().format(date1),
            style:
                $styles.text.title5.copyWith(color: AppColors.lightGreyColor)),
        SizedBox(height: 16.sps),
      ],
    );
  }

  Widget getGratitudeWidget() {
    if (((cubit?.selectedDay == cubit?.currentDay) &&
        ((cubit?.gratitudeData?.todoListResponses?.length ?? 0) == 0))) {
      return writeGratitudeWidget();
    } else if (((cubit?.selectedDay == cubit?.currentDay) &&
        ((cubit?.gratitudeData?.todoListResponses?.length ?? 0) != 0))) {
      return showGratitudeWidget();
    } else if ((((cubit?.selectedDay ?? 0).toInt() <
            (cubit?.currentDay ?? 0).toInt()) &&
        ((cubit?.gratitudeData?.todoListResponses?.length ?? 0) != 0))) {
      return showGratitudeWidget();
    } else if ((((cubit?.selectedDay ?? 0).toInt() <
            (cubit?.currentDay ?? 0).toInt()) &&
        ((cubit?.gratitudeData?.todoListResponses?.length ?? 0) == 0))) {
      return showNoGratitudeWidget("No gratitude submitted");
    } else if ((((cubit?.selectedDay ?? 0).toInt() >
            (cubit?.currentDay ?? 0).toInt()) &&
        ((cubit?.gratitudeData?.todoListResponses?.length ?? 0) == 0))) {
      return showNoGratitudeWidget("You can't add future gratitude");
    } else {
      return showGratitudeWidget();
    }
  }

  Widget writeGratitudeWidget() {
    int maxLength = 500;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.sps, right: 20.sps),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Write a gratitude for today",
                style: $styles.text.body2.copyWith(color: AppColors.blackColor),
                textAlign: TextAlign.start,
              ),
              descriptionCharacterLength == null
                  ? Container()
                  : Text(
                      "${descriptionCharacterLength!}/$maxLength",
                      style: $styles.text.body2
                          .copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.start,
                    ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.sps, right: 16.sps),
          child: AppTextFormField(
            hintText: "I am grateful for...",
            labelText: "",
            maxLines: 10,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
            ],
            textEditingController: descriptionController,
            textInputAction: TextInputAction.none,
            isRequired: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.sps),
          child: AppButton(
            background: AppColors.primary,
            text: "Submit",
            onClicked: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (descriptionController.text.isNotEmpty) {
                HapticFeedback.mediumImpact();
                Map<String, dynamic>? map = {
                  "todoOrderId": dayData?.id,
                  "todoListId": dayData?.todoListId ?? "",
                  "todoListTaskId": activityData?.id,
                  "text": descriptionController.text,
                  /*  "watchTime": "watch-time"*/
                };
                cubit?.saveActivityData(map);
              } else {
                AppUtils.showToast("Please add gratitude");
              }
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
      ],
    );
  }

  Widget showGratitudeWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(28.sps),
          child: Text(
            cubit?.gratitudeData?.todoListResponses?.first.text ?? "",
            style: $styles.text.body2.copyWith(
              color: AppColors.blackColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  Widget showNoGratitudeWidget(String text) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(28.sps),
          child: Text(
            text,
            style: $styles.text.body2.copyWith(
              color: AppColors.blackColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
