import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:curate/src/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

/*class NotificationIcon extends StatelessWidget {
  final int? count;
  const NotificationIcon({this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0.sps, 8.0.sps, 8.0.sps, 8.0.sps),
      child: Align(
        alignment: Alignment.center,
        child: badges.Badge(
          borderSide: BorderSide(color: AppColors.white, width: 1),
          showBadge: (count == null || count == 0) ? false : true,
          badgeColor: AppColors.primary,
          badgeContent: Text(
            count == null ? "" : count!.toString(),
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
          child: SvgPicture.asset(
            "assets/svgs/ic_notifications.svg",
            height: 19.sp,
            width: 19.sp,
          ),
          position: badges.BadgePosition.topEnd(),
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(10),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          alignment: Alignment.topRight,
          animationType: badges.BadgeAnimationType.scale,
        ),
      ),
    );
  }
}*/

class NotificationIcon extends StatelessWidget {
  final int? count;
  const NotificationIcon({this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0.sps, 8.0.sps, 8.0.sps, 8.0.sps),
      child: Align(
        alignment: Alignment.center,
        child: badges.Badge(
          showBadge: (count == null || count == 0) ? false : true,
          badgeStyle: badges.BadgeStyle(
            borderSide: BorderSide(color: AppColors.white, width: 1),
            shape: badges.BadgeShape.square,
            borderRadius: BorderRadius.circular(10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            badgeColor: AppColors.primary,

            ///animationType: badges.BadgeAnimationType.scale,
            // Optional: Add gradient if needed
            // badgeGradient: badges.BadgeGradient.linear(
            //   colors: [Colors.blue, Colors.yellow],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          badgeContent: Text(
            count == null ? "" : count!.toString(),
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          position: badges.BadgePosition.topEnd(top: -5, end: -5),
          child: SvgPicture.asset(
            "assets/svgs/ic_notifications.svg",
            height: 19.sp,
            width: 19.sp,
          ), // Adjust as needed
          // alignment: Alignment.topRight,
        ),
      ),
    );
  }
}

/*
class CartIcon extends StatelessWidget {
  final int? count;
  const CartIcon({this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0.sps, 8.0.sps, 20.0.sps, 8.0.sps),
      child: Align(
        alignment: Alignment.center,
        child: badges.Badge(
          borderSide: BorderSide(color: AppColors.white, width: 1),
          showBadge: (count == null || count == 0) ? false : true,
          badgeColor: AppColors.primary,
          badgeContent: Text(
            count == null ? "" : count!.toString(),
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
          child: SvgPicture.asset(
            "assets/svgs/ic_cart.svg",
            height: 19.sp,
            width: 19.sp,
          ),
          position: badges.BadgePosition.topEnd(),
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(10),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          alignment: Alignment.topRight,
          animationType: badges.BadgeAnimationType.scale,
        ),
      ),
    );
  }
}
*/
class CartIcon extends StatelessWidget {
  final int? count;
  const CartIcon({this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0.sps, 8.0.sps, 20.0.sps, 8.0.sps),
      child: Align(
        alignment: Alignment.center,
        child: badges.Badge(
          showBadge: (count == null || count == 0) ? false : true,
          badgeStyle: badges.BadgeStyle(
            borderSide: BorderSide(color: AppColors.white, width: 1),
            shape: badges.BadgeShape.square,
            borderRadius: BorderRadius.circular(10),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            badgeColor: AppColors.primary,
            //animationType: badges.BadgeAnimationType.scale,
            // Optional: Add gradient if needed
            // badgeGradient: badges.BadgeGradient.linear(
            //   colors: [Colors.blue, Colors.yellow],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          badgeContent: Text(
            count == null ? "" : count!.toString(),
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
          position: badges.BadgePosition.topEnd(top: -5, end: -5),
          child: SvgPicture.asset(
            "assets/svgs/ic_cart.svg",
            height: 19.sp,
            width: 19.sp,
          ), // Adjust as needed
          //alignment: Alignment.topRight,
        ),
      ),
    );
  }
}
