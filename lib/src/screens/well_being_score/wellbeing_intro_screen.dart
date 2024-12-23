import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../constants/asset_path.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import '../../widgets/app_button.dart';
import '../app_screens.dart';

class WellbeingIntroScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const WellbeingIntroScreen({super.key, required this.data});

  @override
  State<WellbeingIntroScreen> createState() => _WellbeingIntroScreenState();
}

class _WellbeingIntroScreenState extends State<WellbeingIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.screenBackground,
          elevation: 0,
          automaticallyImplyLeading: false),
      body: Container(
        color: AppColors.screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Hi ${widget.data["name"]}",
                style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              ),
            ),
            SizedBox(height: 18.sps),
            const Center(
                child:
                    Image(image: AssetImage(ImageAssetPath.icWellbeingScore))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Let’s kick off your wellness adventure! Check your well-being score and together we’ll design a personalized plan to boost your health and happiness.",
                style:
                    $styles.text.body1.copyWith(color: AppColors.darkGreyColor),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppButton(
                background: AppColors.primary,
                text: "Continue",
                onClicked: () {
                  final Map<String, dynamic> data = {
                    "questionType": AppConstants.wellbeingQuestionType
                  };
                  Navigator.pushNamed(context, AppScreens.wellBeingQuestions,
                      arguments: data);
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
          ],
        ),
      ),
    );
  }
}
