import 'package:flutter/material.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/app_styles.dart';
import 'package:curate/src/utils/extensions.dart';

class ScreensAppBars {
  static PreferredSize MyAppBar({List<Widget>? actions}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(64),
      child: AppBar(
        title: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Image.asset(
            "assets/images/kuby_app_icon.png",
            height: 28.spt,
          ),
        ),
        centerTitle: false,
        actions: actions,
      ),
    );
  }

  static AppBar profileAppBar(
      {List<Widget>? actions,
      required String title,
      VoidCallback? onBackButtonPress}) {
    return AppBar(
      leading: InkWell(
        onTap: onBackButtonPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Icon(Icons.chevron_left, size: 25, color: AppColors.mediumGrey),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 8.0.sps),
        child: Text(
          title,
          style: AppStyles.appBarTitleTextStyle,
        ),
      ),
      centerTitle: false,
      actions: actions,
    );
  }
}
