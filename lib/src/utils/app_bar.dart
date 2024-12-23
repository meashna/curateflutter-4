import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  String? title = "";
  bool? popAll = false;
  CustomAppbar({super.key, this.title, this.popAll});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.screenBackground,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          if (popAll ?? false) {
            RouteNavigator.popAllUntill(context, "/");
          } else {
            RouteNavigator.goBack();
          }
        },
        child: Container(
          width: 50.sps,
          height: 50.sps,
          margin: EdgeInsets.only(left: 16.sps),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child:
              Image.asset(ImageAssetPath.icBack, width: 20.sps, height: 20.sps),
        ),
      ),
      title: Text(title ?? "",
          style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
      centerTitle: true,
    );
  }
}
