import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_screens.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: CustomAppbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.sp),
            Image.asset(ImageAssetPath.icSignIn),
            SizedBox(height: 40.sp),
            Center(
              child: Text(
                "Let's Sign you in!",
                style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: AppButton(
                text: "Sign Up with Mobile number",
                background: AppColors.primary,
                onClicked: () {
                  var map = {"title": "Sign Up"};
                  Navigator.pushNamed(context, AppScreens.signIn,
                      arguments: map);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    var map = {"title": "Sign In"};
                    Navigator.pushNamed(context, AppScreens.signIn,
                        arguments: map);
                  },
                  child: RichText(
                      text: TextSpan(
                    style: $styles.text.body2
                        .copyWith(color: AppColors.blackColor),
                    children: <TextSpan>[
                      const TextSpan(text: 'Already have an account? '),
                      TextSpan(
                          text: 'Sign In',
                          style: $styles.text.h8
                              .copyWith(color: AppColors.blackColor)),
                    ],
                  )),
                ),
              ],
            ),
            SizedBox(height: 24.sps),
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sps),
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: 'By continuing, I agree to Curate\'s ',
                      style: $styles.text.body2
                          .copyWith(color: AppColors.blackColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms of Service',
                            style: $styles.text.body2.copyWith(
                                color: AppColors.blackColor,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Map<String, dynamic> map = {
                                  "title": "Terms of Service",
                                  "link":
                                      "https://www.curate.health/terms-conditions",
                                };
                                Navigator.pushNamed(context, AppScreens.webView,
                                    arguments: map);
                              }),
                        TextSpan(
                            text: '\n and ',
                            style: $styles.text.body2
                                .copyWith(color: AppColors.blackColor),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Privacy Policy',
                                  style: $styles.text.body2.copyWith(
                                      color: AppColors.blackColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Map<String, dynamic> map = {
                                        "title": "Privacy Policy",
                                        "link":
                                            "https://www.curate.health/privacy-policy",
                                      };
                                      Navigator.pushNamed(
                                          context, AppScreens.webView,
                                          arguments: map);
                                    })
                            ])
                      ])),
            )),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 16.sps)
          ],
        ),
      ),
    );
  }
}
