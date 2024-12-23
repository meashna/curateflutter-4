import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget? child;
  final Color? backgroundColor;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      //  isLoading: isLoading,
      child: child ?? Container(),
      //color: backgroundColor ?? AppColors.black48,
    );
  }
}
