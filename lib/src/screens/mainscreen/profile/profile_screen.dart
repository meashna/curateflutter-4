import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/response/questions/WeeklyAssessmentScore.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/mainscreen/profile/cubit/profile_screen_cubit.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/no_internet_widget.dart';
import 'package:curate/src/widgets/refresh_indicator_widget.dart';
import 'package:curate/src/widgets/score_progress_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../constants/asset_path.dart';
import '../../../data/manager/preferences_manager.dart';
import '../../../data/models/response/healthLog/HealthLogData.dart';
import '../../../data/repository/user_repo/user_repository.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/weekly_graph/score_line_graph_chart.dart';
import '../../../widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  static Widget create() {
    return BlocProvider(
        create: (BuildContext context) => ProfileScreenCubit(),
        child: const ProfileScreen());
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _preferences = GetIt.I<PreferencesManager>();
  late ProfileScreenCubit cubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefresIndicator(
        onRefresh: () => cubit.getProfileData(),
        child: Stack(
          children: [
            BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
              listener: (context, state) {
                if (state is ProfileScreenLoading) {
                  context.loaderOverlay.show();
                  isLoading = true;
                } else if (state is ProfileScreenInitial) {
                  context.loaderOverlay.hide();
                  isLoading = false;
                } else if (state is ProfileScreenSuccess) {
                  context.loaderOverlay.hide();
                  isLoading = false;
                } else if (state is ProfileScreenError) {
                  context.loaderOverlay.hide();
                  isLoading = false;
                  AppUtils.showToast(state.errorMessage);
                } else if (state is ProfileScreenNoInternet) {
                  context.loaderOverlay.hide();
                  isLoading = false;
                  AppUtils.showToast(AppConstants.noInternetTitle);
                }
              },
              builder: (context1, state) {
                cubit = BlocProvider.of<ProfileScreenCubit>(context1);
                if (state is ProfileScreenLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is ProfileScreenError) {
                  return CustomErrorWidget(() {
                    cubit.getProfileData();
                  });
                }
                if (state is ProfileScreenInitial ||
                    state is ProfileScreenError ||
                    state is ProfileScreenSuccess) {
                  return mainContent();
                } else if (state is ProfileScreenNoInternet) {
                  if (cubit.profileResponse != null) {
                    return mainContent();
                  } else {
                    return NoInternetWidget(() {
                      cubit.getProfileData();
                    });
                  }
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget mainContent() {
    num? weight;
    num? waist;
    String? periodDate;

    if (cubit.healthLog != null && cubit.healthLog!.isNotEmpty) {
      for (int i = 0; i < cubit.healthLog!.length; i++) {
        if (cubit.healthLog![i].type == "0") {
          weight = cubit.healthLog![i].weight;
        } else if (cubit.healthLog![i].type == "1") {
          periodDate = cubit.healthLog![i].periodCycleTo;
        } else if (cubit.healthLog![i].type == "2") {
          waist = cubit.healthLog![i].waist;
        }
      }
    }

    return Container(
      color: AppColors.screenBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.sps),
                  child: Text("My profile",
                      style: $styles.text.h5
                          .copyWith(color: AppColors.blackColor)),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(24.sps, 16.sps, 16.sps, 16.sps),
                  child: GestureDetector(
                      onTap: () async {
                        await showLogoutDialog();
                      },
                      child: SvgPicture.asset(ImageAssetPath.icLogout,
                          height: 20.sps, width: 20.sps)))
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      RouteNavigator.pushNamed(context, AppScreens.editProfile);
                    },
                    child: Card(
                      elevation: 0,
                      color: AppColors.white,
                      surfaceTintColor: AppColors.white,
                      margin: EdgeInsets.symmetric(horizontal: 16.sps),
                      child: Padding(
                        padding: EdgeInsets.all(16.sps),
                        child: Row(
                          children: [
                            ProfilePicture(
                              name: cubit.personalInfo?.name ?? "",
                              radius: 26.sps,
                              fontsize: 21,
                              count: 2,
                              random: true,
                            ),
                            SizedBox(
                              width: 12.sps,
                            ),
                            Expanded(
                                child: Text(cubit.personalInfo?.name ?? "",
                                    style: $styles.text.h7.copyWith(
                                        color: AppColors.blackColor))),
                            SvgPicture.asset(ImageAssetPath.icChevronRight)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sps),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sps),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              RouteNavigator.pushNamed(
                                  context, AppScreens.weightLog);
                            },
                            child: Card(
                              color: AppColors.white,
                              surfaceTintColor: AppColors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12.sps, bottom: 16.sps),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      ImageAssetPath.icWeight1,
                                      width: 48.sps,
                                      height: 64.sps,
                                    ),
                                    SizedBox(
                                      height: 12.sps,
                                    ),
                                    Text("${weight ?? 0} kg",
                                        style: $styles.text.h8.copyWith(
                                            color: AppColors.blackColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              RouteNavigator.pushNamed(
                                  context, AppScreens.periodLog);
                            },
                            child: Card(
                              color: AppColors.white,
                              surfaceTintColor: AppColors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12.sps, bottom: 16.sps),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      ImageAssetPath.icSlider1,
                                      width: 48.sps,
                                      height: 64.sps,
                                    ),
                                    SizedBox(
                                      height: 12.sps,
                                    ),
                                    Text(
                                        DailyActivityUtils.getPeriodEndDate(
                                            periodDate),
                                        style: $styles.text.h8.copyWith(
                                            color: AppColors.blackColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              RouteNavigator.pushNamed(
                                  context, AppScreens.waistLog);
                            },
                            child: Card(
                              color: AppColors.white,
                              surfaceTintColor: AppColors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12.sps, bottom: 16.sps),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      ImageAssetPath.icWaist1,
                                      width: 48.sps,
                                      height: 64.sps,
                                    ),
                                    SizedBox(
                                      height: 12.sps,
                                    ),
                                    Text(waist == null ? "Waist" : "$waist cm",
                                        style: $styles.text.h8.copyWith(
                                            color: AppColors.blackColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.sps),
                  Center(
                    child: Text(
                      "Your Wellbeing score is",
                      style:
                          $styles.text.h6.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: FutureBuilder<String?>(
                        future: Future<String>.value(
                            (cubit.personalInfo?.wellBeingScore ?? "0")
                                .toString()),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If we got an error
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  '${snapshot.error} occurred',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );

                              // if we got our data
                            } else if (snapshot.hasData) {
                              // Extracting data from snapshot object
                              final data = snapshot.data as String;
                              return ScoreProgressBar(data: double.parse(data));
                            }
                          }
                          // Displaying LoadingSpinner to indicate waiting state
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                  (cubit.isTaskSubmitted ?? false)
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 55.sps),
                            child: Text(
                              cubit.wellBeingMessage == null
                                  ? ""
                                  : cubit.wellBeingMessage!.title ?? "",
                              style: $styles.text.body2
                                  .copyWith(color: AppColors.blackColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 32.sps),
                  ((cubit.profileResponse?.personalInfo?.purchaseCount ?? 0) ==
                          0)
                      ? upgradePlanWidget(() {
                          Navigator.pushNamed(context, AppScreens.choosePlan);
                        })
                      : Column(
                          children: [
                            Center(
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 55.sps),
                                child: Text(
                                  "Your progress",
                                  style: $styles.text.h7
                                      .copyWith(color: AppColors.blackColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.sps),
                            ScoreLineGraphchart(
                              flSpots: cubit.flSpots,
                              weeks: cubit.weeks,
                            ),
                            Center(
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 55.sps),
                                child: Text(
                                  "Habit log",
                                  style: $styles.text.h7
                                      .copyWith(color: AppColors.blackColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.sps),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sps),
                              child: Row(
                                children: [
                                  showActivityValue(
                                      (cubit.habitLog?.nper ?? 0).toDouble(),
                                      "Nutrition"),
                                  showActivityValue(
                                      (cubit.habitLog?.mper ?? 0).toDouble(),
                                      "Mindfulness"),
                                  showActivityValue(
                                      (cubit.habitLog?.fper ?? 0).toDouble(),
                                      "Fitness"),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.sps),
                          ],
                        ),
                  GestureDetector(
                    onTap: () {
                      Map<String, dynamic> map = {
                        "title": "Medical References",
                        "link":
                            "https://www.curate.health/curate-health-research-references",
                      };
                      Navigator.pushNamed(context, AppScreens.webView,
                          arguments: map);
                    },
                    child: Card(
                      elevation: 0,
                      color: AppColors.white,
                      surfaceTintColor: AppColors.white,
                      margin: EdgeInsets.symmetric(horizontal: 16.sps),
                      child: Padding(
                        padding: EdgeInsets.all(16.sps),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Medical References",
                                    style: $styles.text.h7.copyWith(
                                        color: AppColors.blackColor))),
                            SvgPicture.asset(ImageAssetPath.icChevronRight)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sps),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showActivityValue(double value, String title) {
    String calculatedValue = "";
    if ((value % 1) == 0) {
      calculatedValue = value.toInt().toString();
    } else {
      calculatedValue = value.toStringAsFixed(1).toString();
    }
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 12.0,
              percent: value / 100,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                "$calculatedValue%",
                style: $styles.text.h8.copyWith(color: AppColors.blackColor),
              ),
              progressColor: AppColors.darkestGreenColor,
              backgroundColor: AppColors.lightestGreyColor),
          SizedBox(height: 12.sps),
          Text(
            title,
            style: $styles.text.body2.copyWith(color: AppColors.darkGreyColor),
          )
        ],
      ),
    );
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
        context: context,
        //barrierDismissible:false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Logout",
              style: $styles.text.h10.copyWith(color: AppColors.blackColor),
            ),
            content: Text("Are you sure you want to log out?",
                style:
                    $styles.text.title2.copyWith(color: AppColors.blackColor)),
            actions: [
              TextButton(
                  onPressed: () {
                    RouteNavigator.goBack();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("No",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
              TextButton(
                  onPressed: () {
                    final userRepository = GetIt.I<UserRepository>();
                    RouteNavigator.goBack();
                    userRepository.logout();
                    _preferences.logout();

                    RouteNavigator.popAllAndToReStart(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(24.sps, 24.sps),
                    maximumSize: Size(24.sps, 24.sps),
                  ),
                  child: Text("Yes",
                      style: $styles.text.title2
                          .copyWith(color: AppColors.primary))),
            ],
            insetPadding: EdgeInsets.symmetric(horizontal: 16.sps),
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        });
  }

  Widget upgradePlanWidget(VoidCallback onClicked) {
    return Container(
      margin: EdgeInsets.only(left: 16.sps, right: 16.sps, bottom: 16.sps),
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.sps,
              ),
              SvgPicture.asset(ImageAssetPath.icSlider1),
              SizedBox(
                height: 20.sps,
              ),
              Container(
                  child: Text(
                "Upgrade to our premium plans to \nunlock more benefits",
                style: $styles.text.h7.copyWith(color: AppColors.blackColor),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 16.sps,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Explore",
                  onClicked: onClicked,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
