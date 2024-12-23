import 'dart:developer';
import 'dart:io';

import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/splash/cubit/splash_cubit.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen1 extends StatefulWidget {
  final RemoteMessage? message;
  const SplashScreen1({super.key, this.message});

  static Widget create(RemoteMessage? message) {
    return BlocProvider(
        create: (BuildContext context) => SplashCubit(message),
        child: SplashScreen1(
          message: message,
        ));
  }

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  late SplashCubit cubit;
  bool animate = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        color: AppColors.screenBackground,
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashError) {
              AppUtils.showToast(state.errorMessage);
            } else if (state is SplashNoInternet) {
              AppUtils.showToast(AppConstants.noInternetTitle);
            } else if (state is SplashSuccess) {
              goToNextPage();
            }
          },
          builder: (context1, state) {
            cubit = BlocProvider.of<SplashCubit>(context1);
            if (state is SplashInitial ||
                state is SplashSuccess ||
                state is SplashError ||
                state is SplashNoInternet) {
              return mainContent();
            } else if (state is SplashAppUpdateStatus) {
              return appUpdateView();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget mainContent() {
    return Stack(
      children: [
        const Positioned(
            top: 0,
            left: 0,
            child: Image(image: AssetImage(ImageAssetPath.icSplashBackground))),
        Positioned(
            bottom: 300,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(ImageAssetPath.icSpash),
                  width: 300,
                ),
                SizedBox(height: 40),
                Image(image: AssetImage(ImageAssetPath.appLogo))
                /*Text(
                    "Curate",
                    textAlign: TextAlign.center,
                    style:
                    $styles.text.h5.copyWith(color: AppColors.blackColor),
                  ),*/
              ],
            )),
        AnimatedPositioned(
          bottom: animate ? 8 : -70,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: AppButton(
              background: AppColors.primary,
              text: "Get Started",
              onClicked: () {
                RouteNavigator.pushReplacement(context, AppScreens.onBoarding);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget appUpdateView() {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
              top: 0,
              left: 0,
              child:
                  Image(image: AssetImage(ImageAssetPath.icSplashBackground))),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(ImageAssetPath.icOnboarding2)),
                    SizedBox(height: 50.sps),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.sps),
                        child: Text(
                          "App Update Required!",
                          textAlign: TextAlign.center,
                          style: $styles.text.h6
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.sps),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 25.sps),
                        child: Text(
                          "We have add new features and fix some bugs to make your experience seamless",
                          textAlign: TextAlign.center,
                          style: $styles.text.body2
                              .copyWith(color: AppColors.darkGreyColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.sps)
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 16.sps,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sps),
                    child: AppButton(
                      background: AppColors.primary,
                      text: "Update App",
                      onClicked: () async {
                        final appId = cubit.packageName ?? "";
                        final url = Uri.parse(
                          Platform.isAndroid
                              ? "https://play.google.com/store/apps/details?id=$appId"
                              //? "market://details?id=$appId"
                              : "https://apps.apple.com/app/id$appId",
                        );
                        if (!await launchUrl(url)) {
                          AppUtils.showToast('Could not launch $url');
                          throw Exception('Could not launch $url');
                        }
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.sps,
                  ),
                  cubit.criticalUpdate
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sps),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: OutlinedButton(
                              onPressed: () {
                                cubit.updatdState();
                                goToNextPage();
                              },
                              child: Text(
                                "May be later",
                                style: $styles.text.h9
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 16.sps)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
  }

  void goToNextPage() async {
    if (cubit.currPlanStatus != null) {
      if (cubit.currPlanStatus == 3) {
        RouteNavigator.popIfCanPop(context);
        RouteNavigator.pushReplacement(context, AppScreens.mainScreen,
            arguments: widget.message);
        return;
      } else if (cubit.currPlanStatus == 2) {
        Map<String, dynamic> argument = {
          "data":
              cubit.consultantPaymentStatusResponse?.product?.metaData?.first,
          "price": cubit.consultantPaymentStatusResponse?.product?.price
        };
        RouteNavigator.popIfCanPop(context);
        RouteNavigator.pushNamed(context, AppScreens.expertPayment,
            arguments: argument);
        return;
      }
    }

    if (!cubit.isToken && !cubit.isScore && !cubit.isProfile) {
      startAnimation();
    } else if (cubit.isToken && !cubit.isProfile && !cubit.isScore) {
      RouteNavigator.pushReplacement(context, AppScreens.personalDetails);
      RouteNavigator.popIfCanPop(context);
    } else if (cubit.isToken && cubit.isProfile && !cubit.isScore) {
      print("kojihugyhcvbjk");
      RouteNavigator.popIfCanPop(context);
      Map<String, dynamic> data = {
        "name": cubit.profileData?.name ?? "",
      };
      RouteNavigator.pushReplacement(context, AppScreens.wellBeingIntroScreen,
          arguments: data);
    } else if (cubit.isToken && cubit.isProfile && cubit.isScore) {
      print(";ojihugyfhcgvjikopl");
      RouteNavigator.popIfCanPop(context);
      RouteNavigator.pushReplacement(context, AppScreens.mainScreen,
          arguments: widget.message);
    }
  }
}
