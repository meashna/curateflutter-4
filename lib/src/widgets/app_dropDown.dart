import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';

class CustomDropdownButton2 extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final EdgeInsetsGeometry? contentPadding;
  final Offset? offset;
  final bool dropError;
  final String? labelText;

  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.contentPadding,
    this.labelText,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.dropError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
          visible: /*widget.floatingHintEnabled && isHintVisible*/ true,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 0.0
                    /*  horizontal: isTablet
                        ? AppConstants.defaultInputDecorationPaddingHorizontal
                        : AppConstants
                        .defaultInputDecorationPaddingHorizontalPhone*/
                    ),
            child: Row(
              children: [
                Text(
                  labelText ?? "Select",
                  style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 14.spt,
                      fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.all(1.0),
                ),
                const Text('*', style: TextStyle(color: AppColors.darkGrey)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8.spt,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            //To avoid long text overflowing.
            isExpanded: true,
            hint: Container(
              alignment: hintAlignment,
              child: Text(
                hint,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.spt,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            value: value,
            items: dropdownItems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Container(
                        alignment: valueAlignment,
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.spt,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            /*    
            buttonSplashColor: Colors.transparent,
            buttonHighlightColor: Colors.transparent,
            onChanged: onChanged,
            itemHighlightColor: Colors.transparent,
            itemSplashColor: Colors.transparent,
            selectedItemBuilder: selectedItemBuilder,
            icon: icon ?? Image.asset("assets/icons/arrow_down.png",height: 15, width: 15,)/* const Icon(Icons.keyboard_arrow_down_outlined)*/,
            iconSize: iconSize ?? 12,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
            buttonHeight: buttonHeight ?? 50,
            buttonWidth: buttonWidth ?? 250,
            buttonPadding:
            buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: buttonDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffD8D8D8),
                  ),
                ),
            buttonElevation: buttonElevation,
            itemHeight: itemHeight ?? 40,
            itemPadding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
            //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
            dropdownMaxHeight: dropdownHeight ?? 200,
            dropdownWidth: dropdownWidth ?? 250,

            dropdownPadding: dropdownPadding,
            dropdownDecoration: dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
            dropdownElevation: dropdownElevation ?? 8,
            scrollbarRadius: scrollbarRadius ?? const Radius.circular(40),
            scrollbarThickness: scrollbarThickness,
            scrollbarAlwaysShow: scrollbarAlwaysShow,
            //Null or Offset(0, 0) will open just under the button. You can edit as you want.
            offset: offset,
            dropdownOverButton: false, //Default is false to show menu below button
            */
          ),
        ),
        dropError
            ? SizedBox(
                height: 8.spt,
              )
            : Container(),
        dropError
            ? Text(
                "Please select value",
                style: TextStyle(
                  color: AppColors.error,
                ),
              )
            : Container(),
      ],
    );
  }
}
