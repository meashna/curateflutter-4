import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget CustomErrorWidget(VoidCallback onClicked,
    {String image = ImageAssetPath.icError,
    String title = "We’re sorry",
    String subtitle =
        "This page doesn’t exist or maybe fell asleep. We suggest that you get back to home."}) {
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(16.sps),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(image),
                  SizedBox(
                    height: 30.sps,
                  ),
                  Container(
                      child: Text(
                    title,
                    style:
                        $styles.text.h6.copyWith(color: AppColors.blackColor),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 16.sps,
                  ),
                  Container(
                      child: Text(
                    subtitle,
                    style: $styles.text.body1
                        .copyWith(color: AppColors.darkGreyColor),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 42.sps,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                  background: AppColors.primary,
                  text: "Try again",
                  onClicked: onClicked),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget NoInternetWidget(VoidCallback onClicked) {
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(16.sps),
      color: AppColors.screenBackground,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssetPath.icNoInternet),
                  SizedBox(
                    height: 30.sps,
                  ),
                  Container(
                      child: Text(
                    "Your internet connection is lost",
                    style:
                        $styles.text.h6.copyWith(color: AppColors.blackColor),
                  )),
                  SizedBox(
                    height: 16.sps,
                  ),
                  Container(
                      child: Text(
                    "Please check your internet connection \n and try again.",
                    textAlign: TextAlign.center,
                    style: $styles.text.body1
                        .copyWith(color: AppColors.darkGreyColor),
                  )),
                  SizedBox(
                    height: 30.sps,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                  background: AppColors.primary,
                  text: "Try again",
                  onClicked: onClicked),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget lockDayWidget(VoidCallback onClicked, bool isPlanPurchased) {
  return Container(
    padding: EdgeInsets.all(16.sps),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(ImageAssetPath.icUpgradePlan),
          SizedBox(
            height: 30.sps,
          ),
          Container(
              child: Text(
            isPlanPurchased
                ? "This content will be available after completing previous tasks"
                : "Upgrade to our premium plans to unlock more benefits",
            style: $styles.text.h6.copyWith(color: AppColors.blackColor),
            textAlign: TextAlign.center,
          )),
          isPlanPurchased
              ? Container()
              : SizedBox(
                  height: 42.sps,
                ),
          isPlanPurchased
              ? Container()
              : Padding(
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
  );
}

Widget NoDataWidget(
    {String image = ImageAssetPath.icNoLogs,
    String title = "No logs available"}) {
  return Scaffold(
    body: Container(
      color: AppColors.screenBackground,
      padding: EdgeInsets.symmetric(horizontal: 40.sps, vertical: 16.sps),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            SizedBox(
              height: 30.sps,
            ),
            Container(
                child: Text(
              title,
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 42.sps,
            ),
          ],
        ),
      ),
    ),
  );
}
