import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'app_screens.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool animate = false;

  @override
  void initState() {
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          color: AppColors.lightestGreyColor1,
          child: Stack(
            children: [
              const Positioned(
                  top: 0,
                  left: 0,
                  child: Image(
                      image: AssetImage(ImageAssetPath.icSplashBackground))),
              Positioned(
                  bottom: 300,
                  left: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(ImageAssetPath.icSpash),
                        width: 300,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Before you start your journey,\n let us go through how you\n can make most of Curate!",
                        textAlign: TextAlign.center,
                        style: $styles.text.h6
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: AppButton(
                      background: AppColors.primary,
                      text: "Get Started",
                      centerText: true,
                      endIcon: Image.asset(
                        ImageAssetPath.icArrowRight,
                        width: 24.sps,
                        height: 24.sps,
                      ),
                      onClicked: () {
                        Navigator.pushNamed(context, AppScreens.walkThrough);
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
  }
}
