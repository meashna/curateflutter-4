import 'package:at_gauges/at_gauges.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/graph/simple_radial_guage_painter.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/utils/graph/enums.dart';

class SimpleRadialGauge extends StatefulWidget {
  /// Creates a simple Gauge.
  ///
  /// The [actualValue] and [maxValue] must not be null.
  const SimpleRadialGauge({
    required this.actualValue,
    required this.maxValue,
    this.minValue = 0,
    this.title,
    this.titlePosition = TitlePosition1.top,
    this.unit,
    this.icon,
    this.pointerColor = Colors.blue,
    this.decimalPlaces = 0,
    this.isAnimate = true,
    this.animationDuration = kDefaultAnimationDuration,
    this.size = 200,
    super.key,
  })  : assert(actualValue <= maxValue,
            'actualValue must be less than or equal to maxValue'),
        assert(size >= 75, 'size must be greater than 75'),
        assert(actualValue >= minValue,
            'actualValue must be greater than or equal to minValue');

  /// Sets the actual value of the gauge.
  final double actualValue;

  /// Sets the maximum value of the gauge.
  final double maxValue;

  /// Sets the unit of the [actualValue] and [maxValue].
  final String? unit;

  /// Sets the icon in the center of the gauge.
  /// Typically an [Icon] widget.
  final Widget? icon;

  /// Sets the minimum value of the gauge.
  final double minValue;

  /// Sets the pointer color of the gauge.
  final Color pointerColor;

  /// Controls how much decimal places will be shown for the [actualValue] and [maxValue].
  final int decimalPlaces;

  /// Toggle on and off animation.
  final bool isAnimate;

  /// Sets a duration in milliseconds to control the speed of the animation.
  final int animationDuration;

  /// Sets the height and width of the gauge.
  ///
  /// If the parent widget has unconstrained height like a [ListView], wrap the gauge in a [SizedBox] to better control it's size
  final double size;

  /// Sets the title of the gauge.
  final Text? title;

  /// Sets the position of the title.
  final TitlePosition1 titlePosition;

  @override
  State<SimpleRadialGauge> createState() => _SimpleRadialGaugeState();
}

class _SimpleRadialGaugeState extends State<SimpleRadialGauge>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    double sweepAngleRadian = RadialHelper.actualValueToSweepAngleRadian(
        minValue: widget.minValue,
        actualValue: widget.actualValue,
        maxValue: widget.maxValue);

    double upperBound = RadialHelper.degreesToRadians(360);

    animationController = AnimationController(
      duration: RadialHelper.getDuration(
          isAnimate: widget.isAnimate,
          userMilliseconds: widget.animationDuration),
      vsync: this,
      upperBound: upperBound,
    );

    animation = Tween<double>().animate(animationController)
      ..addListener(() {
        if (animationController.value == sweepAngleRadian) {
          animationController.stop();
        }

        setState(() {});
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (animationController.value !=
        RadialHelper.actualValueToSweepAngleRadian(
            minValue: widget.minValue,
            actualValue: widget.actualValue,
            maxValue: widget.maxValue)) {
      animationController.animateTo(
          RadialHelper.actualValueToSweepAngleRadian(
              minValue: widget.minValue,
              actualValue: widget.actualValue,
              maxValue: widget.maxValue),
          duration: RadialHelper.getDuration(
              isAnimate: widget.isAnimate,
              userMilliseconds: widget.animationDuration));
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: FittedBox(
        child: Column(
          children: [
            widget.titlePosition == TitlePosition.top
                ? SizedBox(
                    height: 20,
                    child: widget.title,
                  )
                : const SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomPaint(
                  painter: SimpleRadialGaugePainter(
                    sweepAngle: animationController.value,
                    pointerColor: widget.pointerColor,
                  ),
                  child: Center(
                    child: ListTile(
                      title: widget.icon,
                      subtitle: Text(
                        '${RadialHelper.sweepAngleRadianToActualValue(sweepAngle: animationController.value, maxValue: widget.maxValue, minValue: widget.minValue).toStringAsFixed(widget.decimalPlaces)} ${widget.unit ?? ''}',
                        style: $styles.text.h5
                            .copyWith(color: AppColors.blackColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.titlePosition == TitlePosition.bottom
                ? SizedBox(
                    height: 30,
                    child: widget.title,
                  )
                : const SizedBox(
                    height: 20,
                  )
          ],
        ),
      ),
    );
  }
}
