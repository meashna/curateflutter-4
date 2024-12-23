import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../styles/colors.dart';

class CustomRefresIndicator extends StatefulWidget {
  final Widget child;
  final AsyncCallback onRefresh;

  const CustomRefresIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  _CustomRefresIndicatorState createState() => _CustomRefresIndicatorState();
}

class _CustomRefresIndicatorState extends State<CustomRefresIndicator>
    with SingleTickerProviderStateMixin {
  static const _indicatorSize = 150.0;

  /// Whether to render check mark instead of spinner
  final bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      onRefresh: widget.onRefresh,
      durations: RefreshIndicatorDurations(
        finalizeDuration: Duration(seconds: 1, milliseconds: 200),
      ),
      //indicatorFinalizeDuration: const Duration(seconds: 1, milliseconds: 200),
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            if (!controller.isIdle)
              Positioned(
                top: 15.0 * controller.value,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    value: !controller.isLoading
                        ? controller.value.clamp(0.0, 1.0)
                        : null,
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, 100.0 * controller.value),
              child: child,
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
