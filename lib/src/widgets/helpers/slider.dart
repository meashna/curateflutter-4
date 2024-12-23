import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    var canvas = context.canvas;
    final picWidth = image.width;
    final picHeight = image.height;

    Offset picOffset = Offset(
      (center.dx - (picWidth / 2)),
      (center.dy - (picHeight / 2)),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, picOffset, paint);
  }
}
