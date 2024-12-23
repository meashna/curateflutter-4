import 'package:flutter/material.dart';
import 'package:curate/src/utils/extensions.dart';

import '../styles/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.background,
    required this.text,
    this.endIcon,
    this.onClicked,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.elevation,
    this.horizontalPadding = 24,
    this.verticalPadding = 16,
    this.centerText = false,
  });

  final Color background;
  final String text;
  final Widget? endIcon;
  final Color? textColor;
  final double? fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight? fontWeight;
  final VoidCallback? onClicked;
  final double? elevation;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.darkGrey;
            }
            return textColor ?? AppColors.white;
          },
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          //side: BorderSide(color: Colors.red)
        )),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.darkGrey;
            }
            return background;
          },
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
            horizontal: horizontalPadding.spt, vertical: verticalPadding.spt)),
        elevation: WidgetStateProperty.resolveWith<double?>(
          (Set<WidgetState> states) {
            return elevation ?? 1;
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (centerText && endIcon != null) ...[
            Opacity(
              opacity: 0.0,
              child: endIcon!,
            ),
          ],
          Text(
            text,
            style: TextStyle(
                fontWeight: fontWeight ?? FontWeight.bold, fontSize: fontSize),
          ),
          if (endIcon != null) ...[
            SizedBox(
              width: 8.sps,
            ),
            endIcon!,
          ],
        ],
      ),
    );
  }
}
