import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/response/healthLog/PeriodsFlows.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/mainscreen/profile/periodLog/addlog/addFlow/cubit/add_flow_cubit.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/response/healthLog/HealthLogData.dart';
import '../../../../../../styles/colors.dart';

class PeriodFlowScreen extends StatefulWidget {
  Map<String, dynamic> mainData;

  PeriodFlowScreen({super.key, required this.mainData});

  static Widget create(Map<String, dynamic> mainData) {
    return BlocProvider(
        create: (BuildContext context) => AddFlowCubit(),
        child: PeriodFlowScreen(
          mainData: mainData,
        ));
  }

  @override
  State<PeriodFlowScreen> createState() => _PeriodFlowScreenState();
}

class _PeriodFlowScreenState extends State<PeriodFlowScreen> {
  late AddFlowCubit cubit;
  List<DateTime?> dates = [];
  HealthLogData? data;
  var isLoading = false;
  var isFirstRun = false;

  @override
  Widget build(BuildContext context) {
    dates = widget.mainData["dates"];
    if (widget.mainData.containsKey("mainData")) {
      data = widget.mainData["mainData"];
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title: data == null ? "Add log" : "Update log")),
      body: BlocConsumer<AddFlowCubit, AddFlowState>(
        listener: (context, state) {
          if (state is AddFlowLoading) {
            isLoading = true;
          } else if (state is AddFlowInitial) {
            isLoading = false;
          } else if (state is AddFlowSuccess) {
            isLoading = false;
          } else if (state is SubmitFlowSuccess) {
            RouteNavigator.pushNamedAndRemoveUntil(
                context, AppScreens.periodLog, AppScreens.mainScreen);
          } else if (state is AddFlowError) {
            isLoading = false;
            AppUtils.showToast(state.errorMessage);
          } else if (state is AddFlowNoInternet) {
            isLoading = false;
            AppUtils.showToast(AppConstants.noInternetTitle);
          }
        },
        builder: (context1, state) {
          cubit = BlocProvider.of<AddFlowCubit>(context1);
          if (state is AddFlowInitial ||
              state is AddFlowError ||
              state is AddFlowSuccess ||
              state is AddFlowNoInternet ||
              state is AddFlowLoading) {
            return mainContent();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget mainContent() {
    if (!isFirstRun) {
      isFirstRun = true;
      if (widget.mainData.containsKey("mainData")) {
        data = widget.mainData["mainData"];
        cubit.saveSelectedReason(data!.periodFlowId ?? 0);
      }
    }
    return Stack(children: [
      Container(
        width: double.infinity,
        color: AppColors.screenBackground,
        child: Column(
          children: [
            SizedBox(height: 16.sps),
            Text(
              "How is your flow?",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
            ),
            SizedBox(height: 24.sps),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sps),
                child: ListView.builder(
                    itemCount: cubit.flowTypes.length ?? 0,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16.sps),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            cubit.saveSelectedReason(
                                cubit.flowTypes[index].id ?? 0);
                          },
                          child: getItem(index, cubit.flowTypes[index]));
                    }),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(16.sps),
              child: AppButton(
                background: AppColors.primary,
                text: "Submit",
                onClicked: () {
                  if (data != null) {
                    cubit.updatePeriodData(dates, data!.id ?? 0);
                  } else {
                    cubit.savePeriodData(dates);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      //Center(child: CircularProgressIndicator()),
      Visibility(
          visible: isLoading,
          child: Align(
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(),
          ))
    ]);
  }

  Widget getItem(int index, PeriodsFlows data) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.sps),
      child: Row(
        children: [
          getRadioSymbol(data.id ?? 0),
          SizedBox(
            width: 16.sps,
          ),
          Expanded(
            child: Text(
              data.title ?? "",
              textAlign: TextAlign.start,
              maxLines: 4,
              style: $styles.text.body1.copyWith(color: AppColors.blackColor),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }

  Widget getRadioSymbol(num index) {
    return (cubit.selectedReason == index)
        ? Container(
            height: 30.sps,
            width: 30.sps,
            decoration: const BoxDecoration(
                color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
                child:
                    Icon(Icons.circle, color: AppColors.white, size: 16.sps)))
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
