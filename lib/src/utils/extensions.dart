import 'package:sizer/sizer.dart';

extension SizerExt on num {
  static const double _scaleFactor = 0.25;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size

  double get spt => (this-(this * _scaleFactor)).sp;
  double get sps => (this-(this * _scaleFactor)).sp;
}
