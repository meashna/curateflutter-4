import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/helpers/slider.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import '../../styles/colors.dart';

class LocalSliderWidget extends StatefulWidget {
  final String imagePath;
  final ValueChanged<double>? onChanged;
  final double? min;
  final double? max;

  const LocalSliderWidget(
      {required this.imagePath,
      required this.min,
      required this.max,
      required this.onChanged,
      super.key});

  @override
  State<LocalSliderWidget> createState() => _LocalSliderWidgetState();
}

class _LocalSliderWidgetState extends State<LocalSliderWidget> {
  double intValue = 0;
  ui.Image? customImage;

  Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: 71.sps.toInt(), targetWidth: 49.sps.toInt());
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load(widget.imagePath).then((image) {
      setState(() {
        customImage = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          inactiveTrackColor: AppColors.lightestGreyColor,
          activeTrackColor: AppColors.primary,
          //1trackShape: GradientSliderTrackShape(linearGradient:LinearGradient(colors: [AppColors.primary, AppColors.primary])),
          trackHeight: 8.0,
          overlayColor: Colors.purple.withAlpha(36),
          thumbShape: customImage != null
              ? SliderThumbImage(customImage!)
              : const RoundSliderThumbShape()),
      child: Slider(
        min: widget.min ?? 0.0,
        max: widget.max ?? 0.0,
        //divisions: 1,
        onChanged: (double value) {
          setState(() {
            intValue = value;
          });
          widget.onChanged!.call(intValue);
        },
        value: intValue,
      ),
    );
  }
}
