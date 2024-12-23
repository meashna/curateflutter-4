import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../constants/asset_path.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import '../../widgets/app_button.dart';
import '../app_screens.dart';

class DiagnoseNowScreen extends StatelessWidget {
  const DiagnoseNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
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
            const Center(
                child:
                    Image(image: AssetImage(ImageAssetPath.icWellbeingScore))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "We understand that you’re currently not eligible for our Wellbeing score analysis at this moment. But don’t worry, we’re here to help you diagnose and understand your condition, including the possibility of PCOS.",
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
                text: "Diagnose now",
                onClicked: () {
                  Navigator.pushNamed(context, AppScreens.talkExpert);
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
