import 'package:flutter/material.dart';
import 'package:curate/src/utils/extensions.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final Widget label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 16.sps,
              width: 16.sps,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.sps)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                },
              ),
            ),
          ),
          SizedBox(
            width: 10.sps,
          ),
          Expanded(child: label),
        ],
      ),
    );
  }
}
