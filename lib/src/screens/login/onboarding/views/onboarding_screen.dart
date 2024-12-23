import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(ImageAssetPath.icSplashBackground)),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppScreens.welcome);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 48.sps),
                  padding: EdgeInsets.all(16.sps),
                  child: Text(
                    "Skip",
                    style: $styles.text.body1
                        .copyWith(color: AppColors.darkGreyColor),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: PageView.builder(
                itemCount: onboardingData.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                    image: onboardingData[index].image,
                    title: onboardingData[index].title,
                    description: onboardingData[index].description)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              children: [
                SizedBox(width: 16),
                ...List.generate(
                    onboardingData.length,
                    (index) => DotIndicator(
                          active: index == pageIndex,
                        )),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (pageIndex == 2) {
                      Navigator.pushNamed(context, AppScreens.welcome);
                    } else {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                    child: Image.asset(
                      ImageAssetPath.icArrowRight,
                      color: AppColors.white,
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
              ],
            ),
          )
        ]));
  }
}

class Onboard {
  final String image, title, description;
  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<OnboardContent> onboardingData = [
  const OnboardContent(
      image: ImageAssetPath.icOnboarding1,
      title: AppConstants.onBoardingTitle1,
      description: AppConstants.onBoardingDescription1),
  const OnboardContent(
      image: ImageAssetPath.icOnboarding2,
      title: AppConstants.onBoardingTitle2,
      description: AppConstants.onBoardingDescription2),
  const OnboardContent(
      image: ImageAssetPath.icOnboarding3,
      title: AppConstants.onBoardingTitle3,
      description: AppConstants.onBoardingDescription3),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sps),
      child: Column(children: [
        Expanded(
          flex: 7,
          child: Center(child: Image.asset(image, height: 250.sps)),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: $styles.text.h6.copyWith(color: AppColors.blackColor),
        ),
        SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: $styles.text.body2.copyWith(color: AppColors.darkGreyColor),
        ),
        SizedBox(height: 16)
      ]),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: 34,
      height: 10,
      decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.greyColor,
          borderRadius: BorderRadiusDirectional.circular(12)),
    );
  }
}
