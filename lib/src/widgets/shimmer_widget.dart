import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)));

  const ShimmerWidget.rectangularbBg(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)));

  const ShimmerWidget.circular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  const ShimmerWidget.round(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)));

  const ShimmerWidget.topRectangular(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
