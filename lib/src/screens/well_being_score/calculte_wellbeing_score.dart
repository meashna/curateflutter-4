import 'dart:async';

import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/app_screens.dart';
import 'package:curate/src/screens/well_being_score/component/wellbeing_question_vm.dart';
import 'package:curate/src/screens/well_being_score/wellbeing_score_vm.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/graph/SimpleRadialGuage.dart';
import 'package:curate/src/utils/graph/enums.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../widgets/score_progress_bar.dart';
import '../login/onboarding/views/onboarding_screen.dart';

class CalculateWellbeingScore extends StatefulWidget {
  const CalculateWellbeingScore({super.key});

  @override
  State<CalculateWellbeingScore> createState() =>
      _CalculateWellbeingScoreState();
}

class _CalculateWellbeingScoreState extends State<CalculateWellbeingScore> {
  var viewModel = WellbeingScoreVM();
  late LoopPageController _pageController;
  late Timer _timer;
  var isAnimate = true;
  int pageIndex = 0;
  List<String> quotes = [];

  @override
  void initState() {
    super.initState();
    _pageController = LoopPageController(initialPage: 0);
    quotes.add("Embrace the uniqueness: No two PCOS journeys are alike");
    quotes.add(
        "Empower yourself, own your body, and reclaim your health with PCOS");
    quotes.add("Conquering PCOS to realize your dreams of motherhood");
    quotes.add("Defeat PCOS, embrace life on your terms");

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (pageIndex < 3) {
        isAnimate = false;
        pageIndex++;
      } else {
        pageIndex = 0;
      }

      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.screenBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                Center(
                  child: Text(
                    "Your Wellbeing score is",
                    style:
                        $styles.text.h6.copyWith(color: AppColors.blackColor),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: FutureBuilder<String?>(
                      future: viewModel.getWellbeingScore(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
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
                SizedBox(height: 8),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 55.sps),
                    child: Text(
                      "Your score is a measure of your physical and mental health, reflecting your overall wellness and vitality",
                      style: $styles.text.body2
                          .copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: getTextViewPager()),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 55.sps),
                    child: Text(
                      "Let’s see how curate can improve your wellbeing",
                      style: $styles.text.title3
                          .copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16.sps),
                Center(child: Image.asset(ImageAssetPath.icGraphImage)),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.sps, right: 16.sps, top: 16.sps),
                  child: AppButton(
                    background: AppColors.primary,
                    text: "Explore plans",
                    onClicked: () {
                      Map<String, dynamic> data = {"isBeforeHome": true};
                      Navigator.pushNamed(context, AppScreens.choosePlan,
                          arguments: data);
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.sps, right: 16.sps, top: 8.sps),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        RouteNavigator.popAllAndPushNamedReplacement(
                            context, AppScreens.getStarted);
                      },
                      child: Text("Skip for now"),
                    ),
                  ),
                ),
                SizedBox(height: 16.sps),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextViewPager() {
    return SizedBox(
      height: 48.sps,
      child: LoopPageView.builder(
          itemCount: quotes.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.sps),
              child: Text(
                quotes[index],
                textAlign: TextAlign.center,
                maxLines: 3,
                style: $styles.text.body2.copyWith(color: AppColors.blackColor),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
}
