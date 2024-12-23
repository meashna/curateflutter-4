import 'package:flutter/material.dart';
import 'package:curate/src/styles/colors.dart';

class BottomSheetArrowIcon extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.primary;
    paint.strokeWidth = 5;
    Path path = Path();
    path.moveTo(0,20);
    path.moveTo(20,40);
    //canvas.drawLine(p1, p2, paint)
    canvas.drawPath(path, paint);
   /* canvas.drawLine(
      Offset(10, 10),
      Offset(-10, 10),
      paint,
    );*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  double ydivideableValue;

  TrianglePainter({required this.ydivideableValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    print("ydivideableValue");
    print(ydivideableValue);
    double value;
    if(ydivideableValue<1){
      value = ydivideableValue*10;
    }else{
      value = y/ydivideableValue;
    }

    return Path()
      ..moveTo(0, y/2)
      ..lineTo(x / 2, value)
      ..lineTo(x, y/2);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return true;
   /* return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;*/
  }
}