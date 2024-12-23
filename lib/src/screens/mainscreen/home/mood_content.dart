import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/screens/mainscreen/home/cubit/home_screen_cubit.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MoodContent extends StatelessWidget {
  const MoodContent(
      {super.key,
      required this.image,
      required this.title,
      required this.isSelected,
      required this.index});

  final String image, title;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeScreenCubit>(context);
    int? selectedMood = cubit.selectedMood;

    return GestureDetector(
      onTap: () async {
        context.loaderOverlay.show();
        var data = await cubit.submitMood(index);
        context.loaderOverlay.hide();
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.all(0),
              surfaceTintColor: AppColors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: (isSelected) ? AppColors.primary : AppColors.white),
                borderRadius: BorderRadius.circular(40.sps),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.sps),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(image, height: 32.sps, width: 32.sps),
                ),
              ),
            ),
            SizedBox(height: 4.sps),
            Container(
              margin: EdgeInsets.only(
                  right: (MediaQuery.of(context).size.width / 5) - 60.sps),
              child: Center(
                child: Text(
                  title,
                  style: $styles.text.title5.copyWith(
                      color: (isSelected)
                          ? AppColors.primary
                          : AppColors.blackColor),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
