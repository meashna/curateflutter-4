import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
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
        body: SafeArea(
            top: false,
            child: Container(
              color: AppColors.screenBackground,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          InkWell(
                            onTap: () {
                              if (pageIndex == onboardingData.length - 1) {
                                RouteNavigator.popAllAndPushNamedReplacement(
                                    context, AppScreens.mainScreen);
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
                                  color: AppColors.primary,
                                  shape: BoxShape.circle),
                              child: Image.asset(
                                ImageAssetPath.icArrowRight,
                                color: AppColors.white,
                                width: 24.sp,
                                height: 24.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            )));
  }
}

class Onboard {
  final String image, title, description;

  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<OnboardContent> onboardingData = [
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough1,
      title: AppConstants.walkThroughTitle1,
      description: AppConstants.walkThroughDescription1),
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough2,
      title: AppConstants.walkThroughTitle2,
      description: AppConstants.walkThroughDescription2),
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough3,
      title: AppConstants.walkThroughTitle3,
      description: AppConstants.walkThroughDescription3),
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough4,
      title: AppConstants.walkThroughTitle4,
      description: AppConstants.walkThroughDescription4),
/*    const OnboardContent(
      image: ImageAssetPath.imgWalkthrough5,
      title: AppConstants.walkThroughTitle5,
      description: AppConstants.walkThroughDescription5),*/
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough6,
      title: AppConstants.walkThroughTitle6,
      description: AppConstants.walkThroughDescription6),
  const OnboardContent(
      image: ImageAssetPath.imgWalkthrough7,
      title: AppConstants.walkThroughTitle7,
      description: AppConstants.walkThroughDescription7),
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
    return Container(
      child: Column(children: [
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: $styles.text.h6.copyWith(color: AppColors.blackColor),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sps),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: $styles.text.body2.copyWith(color: AppColors.darkGreyColor),
          ),
        ),
        const SizedBox(height: 16)
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
      width: active ? 34 : 10,
      height: 10,
      decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.greyColor,
          borderRadius: BorderRadiusDirectional.circular(12)),
    );
  }
}
