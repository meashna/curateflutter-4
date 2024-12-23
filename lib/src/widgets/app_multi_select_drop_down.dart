import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:curate/src/utils/extensions.dart';

import '../styles/colors.dart';

class AppMultiSelectDropDown extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final List<String> selectedItems;
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

  const AppMultiSelectDropDown({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.selectedItems,
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
  State<AppMultiSelectDropDown> createState() => _AppMultiSelectDropDownState();
}

class _AppMultiSelectDropDownState extends State<AppMultiSelectDropDown> {
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
            padding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 0.0
                    /*  horizontal: isTablet
                        ? AppConstants.defaultInputDecorationPaddingHorizontal
                        : AppConstants
                        .defaultInputDecorationPaddingHorizontalPhone*/
                    ),
            child: Row(
              children: [
                Text(
                  widget.labelText ?? "Select",
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
            isExpanded: true,
            hint: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            items: widget.dropdownItems.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                //disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = widget.selectedItems.contains(item);
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        isSelected
                            ? widget.selectedItems.remove(item)
                            : widget.selectedItems.add(item);
                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {});
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            isSelected
                                ? const Icon(Icons.check_box_outlined)
                                : const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
            value: widget.selectedItems.isEmpty
                ? null
                : widget.selectedItems.first,
            onChanged: widget.onChanged,
            /*
            icon: widget.icon ??
                Image.asset(
                  "assets/icons/arrow_down.png",
                  height: 15,
                  width: 15,
                ) /* const Icon(Icons.keyboard_arrow_down_outlined)*/,
            iconSize: widget.iconSize ?? 12,
            iconEnabledColor: widget.iconEnabledColor,
            iconDisabledColor: widget.iconDisabledColor,
            buttonHeight: widget.buttonHeight ?? 50,
            buttonWidth: widget.buttonWidth ?? 250,
            buttonPadding: widget.buttonPadding ??
                const EdgeInsets.only(left: 14, right: 14),
            itemPadding: EdgeInsets.zero,
            buttonDecoration: widget.buttonDecoration ??
                BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffD8D8D8),
                    ),
                    color: AppColors.white),
            buttonElevation: widget.buttonElevation,
            dropdownMaxHeight: widget.dropdownHeight ?? 200,
            dropdownWidth: widget.dropdownWidth ?? 250,
            dropdownPadding: widget.dropdownPadding,
            dropdownDecoration: widget.dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
            dropdownElevation: widget.dropdownElevation ?? 8,
            scrollbarRadius:
                widget.scrollbarRadius ?? const Radius.circular(40),
            scrollbarThickness: widget.scrollbarThickness,
            scrollbarAlwaysShow: widget.scrollbarAlwaysShow,
            //Null or Offset(0, 0) will open just under the button. You can edit as you want.
            offset: widget.offset,
            dropdownOverButton: false,
            selectedItemBuilder: (context) {
              return widget.dropdownItems.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.selectedItems.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },*/
          ),
        ),
      ],
    );
  }
}
