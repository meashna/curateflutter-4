import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/utils/app_styles.dart';

import '../styles/colors.dart';

class LogoutDialog {
  static Future<void> show({
    required BuildContext parentContext,
    required VoidCallback onSignOutClicked,
  }) async {
    showCupertinoDialog(
      context: parentContext,
      builder: (BuildContext context) => Platform.isAndroid
          ? AlertDialog(
              title: Text("Confirm ?"),
              content: Text(
                "Are you sure want to logout? ",
                style: const TextStyle(
                  color: AppColors.darkGrey,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Close",
                    style: AppStyles.appBarTextButtonTextStyle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  onPressed: onSignOutClicked,
                  child: Text(
                    "Sign out",
                    style: AppStyles.appBarTextButtonTextStyle,
                  ),
                ),
              ],
            )
          : CupertinoAlertDialog(
              title: Text("Confirm ?"),
              content: Text(
                "Are you sure want to logout? ",
                style: const TextStyle(
                  color: AppColors.darkGrey,
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: onSignOutClicked,
                  child: Text("Sign out"),
                ),
              ],
            ),
    );
  }
}
