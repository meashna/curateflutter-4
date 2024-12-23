import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/screens/mainscreen/profile/weightLog/cubit/weight_screen_cubit.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_text_feild/app_text_from_feild.dart';
import 'package:curate/src/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../constants/app_constants.dart';
import '../../../../styles/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/fetch_more_widget.dart';
import '../../../../widgets/no_internet_widget.dart';
import '../../../../widgets/refresh_indicator_widget.dart';

class WeightLogScreen extends StatefulWidget {
  const WeightLogScreen({super.key});

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => WeightScreenCubit(),
        child: WeightLogScreen());
  }

  @override
  State<WeightLogScreen> createState() => _WeightLogScreenState();
}

class _WeightLogScreenState extends State<WeightLogScreen> {
  bool isLoading = false;
  late WeightScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: CustomAppbar(title: "Weight log")),
      body: SafeArea(
        child: BlocConsumer<WeightScreenCubit, WeightScreenState>(
          listener: (context, state) {
            if (state is WeightScreenLoading) {
              isLoading = true;
            } else if (state is SaveWeightDataLoading) {
              context.loaderOverlay.show();
            } else if (state is SaveWeightDataSuccess) {
              context.loaderOverlay.hide();
              RouteNavigator.goBack();
              cubit.getWeightData();
            } else if (state is WeightScreenInitial) {
              isLoading = false;
            } else if (state is WeightScreenSuccess) {
              isLoading = false;
            } else if (state is WeightScreenError) {
              isLoading = false;
              AppUtils.showToast(state.errorMessage);
            } else if (state is WeightScreenNoInternet) {
              isLoading = false;
              AppUtils.showToast(AppConstants.noInternetTitle);
            }
          },
          builder: (context1, state) {
            cubit = BlocProvider.of<WeightScreenCubit>(context1);
            if (state is WeightScreenLoading) {
              return ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.only(
                      left: 12.sps, right: 12.sps, bottom: 54.sps),
                  itemBuilder: (BuildContext context, int index) {
                    return getListSkelton();
                  });
            }
            if (state is WeightScreenInitial ||
                state is WeightScreenError ||
                state is WeightScreenSuccess ||
                state is WeightScreenLoading) {
              return mainContent();
            } else if (state is WeightScreenNoInternet) {
              if ((cubit.weightData.length ?? 0) > 0) {
                return mainContent();
              } else {
                return NoInternetWidget(() {
                  cubit.getWeightData();
                });
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget mainContent() {
    return Container(
      color: AppColors.screenBackground,
      child: Column(
        children: [
          Expanded(
            child: CustomRefresIndicator(
              onRefresh: () => cubit.getWeightData(isRefresh: true),
              child: FetchMoreIndicator(
                isLastPage: cubit.isLastPage,
                onAction: cubit.getWeightData,
                child: Padding(
                  padding: EdgeInsets.all(16.sps),
                  child: Stack(
                    children: [
                      (!isLoading)
                          ? (cubit.weightData.isNotEmpty)
                              ? ListView.builder(
                                  itemCount: cubit.weightData.length ?? 0,
                                  padding: EdgeInsets.only(bottom: 54.sps),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return getLogItem(cubit.weightData[index]);
                                  })
                              : NoDataWidget(
                                  image: ImageAssetPath.icEmptyWeight)
                          : ListView.builder(
                              itemCount: 10,
                              padding: EdgeInsets.only(bottom: 54.sps),
                              itemBuilder: (BuildContext context, int index) {
                                return getListSkelton();
                              }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.sps),
              child: AppButton(
                background: AppColors.primary,
                text: "Add log",
                onClicked: () async {
                  await showAddWeightDialog();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLogItem(HealthLogData data) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        showAddWeightDialog(data: data);
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
                          DateTimeUtils.getApiStringMonthNameDate(
                              DateTimeUtils.getApiDatetoUtc(data.updatedAt)),
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showAddWeightDialog(data: data);
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
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Weight: ",
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                          children: [
                        TextSpan(
                            text: "${data.weight ?? 0} kg",
                            style: $styles.text.h9
                                .copyWith(color: AppColors.blackColor))
                      ])),
                  SizedBox(width: 16.sps),
                  Text("|"),
                  SizedBox(width: 16.sps),
                  RichText(
                      text: TextSpan(
                          text: "Time: ",
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                          children: [
                        TextSpan(
                            text:
                                "${DateTimeUtils.getApiStringLogTime(DateTimeUtils.getApiDateUtc(data.updatedAt))}",
                            style: $styles.text.body2
                                .copyWith(color: AppColors.darkGreyColor))
                      ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddWeightDialog({HealthLogData? data}) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController weightController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (data != null) {
            weightController.text = (data.weight ?? 0).toString();
          }
          return Dialog(
            insetPadding: EdgeInsets.all(16.sps),
            backgroundColor: AppColors.screenBackground,
            surfaceTintColor: AppColors.screenBackground,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.sps),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            RouteNavigator.goBack();
                          },
                          child: Container(
                            width: 50.sps,
                            height: 50.sps,
                            margin: EdgeInsets.only(left: 16.sps),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Image.asset(ImageAssetPath.icClose,
                                width: 20.sps, height: 20.sps),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.sps),
                      Text(
                        "${data == null ? "Enter" : "Update"} weight ( in kg )",
                        style: $styles.text.h6
                            .copyWith(color: AppColors.blackColor),
                      ),
                      Form(
                        key: formKey,
                        child: AppTextFormField(
                            hintText: "Weight",
                            labelText: "",
                            isLabelVisible: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            validator: (value) => _validateWeight(value!),
                            textEditingController: weightController),
                      ),
                      SizedBox(height: 24.sps),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                RouteNavigator.goBack();
                              },
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size.fromHeight(48),
                                maximumSize: const Size.fromHeight(48),
                              ),
                              child: Text("Cancel",
                                  style: $styles.text.h8
                                      .copyWith(color: AppColors.blackColor)),
                            ),
                          ),
                          SizedBox(width: 8.sps),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 48.sps,
                              child: AppButton(
                                background: AppColors.primary,
                                text: data == null ? "Save" : "Update",
                                fontSize: 16.sps,
                                verticalPadding: 8.sps,
                                fontWeight: FontWeight.bold,
                                onClicked: () {
                                  if (formKey.currentState!.validate()) {
                                    String? weight = weightController.text;
                                    if (data == null) {
                                      cubit
                                          .saveWeightData(double.parse(weight));
                                    } else {
                                      cubit.updateWeightData(
                                          double.parse(weight), data.id!);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget getListSkelton() {
    return Card(
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
    );
  }

  _validateWeight(String value) {
    if (value.trim().isEmpty) {
      return "Please enter the weight" /*context?.resources.strings.cantBeEmpty*/;
    } else {
      return null;
    }
  }
}
