import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_text_feild/text_feild_input_formatter.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_constants.dart';
import '../../styles/colors.dart';
import 'app_textFeild.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.hintText,
    required this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isLabelVisible = true,
    super.key,
    this.textEditingController,
    this.maxLines = 1,
    this.maxLength,
    this.onObsecureTap,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onTap,
    this.lightTheme = true,
    this.isRequired = true,
    this.contentPadding,
    this.disableEditing = false,
    this.defaultText,
    this.suffixIconPath,
    this.inputFormatters,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.preIconPath,
  });

  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final bool obscureText;
  final bool isLabelVisible;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? textEditingController;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onObsecureTap;

  final bool lightTheme;
  final bool isRequired;
  final EdgeInsetsGeometry? contentPadding;
  final bool disableEditing;
  final String? defaultText;
  final String? suffixIconPath;
  final String? preIconPath;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  //final String? Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<StatefulWidget> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late TextEditingController _textController;
  late bool _textControllerFromParent;
  late FocusNode _textFocusNode;
  bool isHintVisible = false;

  @override
  void initState() {
    _textFocusNode =
        widget.disableEditing ? AlwaysDisabledFocusNode() : FocusNode();
    //widget.inputFormatters!.add(CaseFormatting());
    _textControllerFromParent = widget.textEditingController != null;
    _textController = widget.textEditingController ?? TextEditingController();
    //_textController.text = widget.defaultText ?? '';

    _textController.addListener(() {
      //_handleTextAndFocusChange();
    });
    _textFocusNode.addListener(() {
      //_handleTextAndFocusChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    // If text controller was created from parent widget then don't dispose the controller here.
    if (!_textControllerFromParent) {
      _textController.dispose();
    }
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final isTablet = AppConstants.isTablet;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.isLabelVisible,
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
                if (widget.labelText.isNotEmpty)
                  Text(
                    widget.labelText,
                    style: TextStyle(
                        color: widget.lightTheme
                            ? AppColors.darkGrey
                            : AppColors.darkGrey,
                        fontSize: 14.spt,
                        fontWeight: FontWeight.w500),
                  ),
                if (widget.isRequired) ...[
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                  ),
                  const Text('*', style: TextStyle(color: AppColors.darkGrey)),
                ]
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: _textController,
          focusNode: _textFocusNode,
          textCapitalization: widget.textCapitalization,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          enabled: !widget.disableEditing,
          enableSuggestions: false,
          autovalidateMode: widget.autovalidateMode,
          autocorrect: false,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          onSaved: (val) {
            widget.textEditingController?.text = val ?? "";
          },
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            color: widget.lightTheme ? AppColors.darkColor : AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.spt,
          ),
          validator: widget.validator,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIconPath == null
                ? null
                : GestureDetector(
                    onTap: widget.onObsecureTap,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12),
                      child: Image.asset(
                        widget.suffixIconPath!,
                        height: 16.sp,
                        width: 16.sp,
                      ),
                    )),
            prefixIcon: widget.preIconPath == null
                ? null
                : Image.asset(
                    widget.preIconPath!,
                    height: 16.sp,
                    width: 16.sp,
                  ),
            hintText: widget.hintText,
            counterText: "",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.sp, vertical: 12.sps),
            filled: true,
            errorStyle: TextStyle(color: AppColors.errorColor),
            fillColor: widget.lightTheme ? AppColors.white : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color:
                    widget.lightTheme ? AppColors.primary : AppColors.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.lightTheme
                    ? AppColors.borderColor
                    : AppColors.borderColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.lightTheme
                    ? AppColors.borderColor
                    : AppColors.borderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.lightTheme ? AppColors.error : AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.lightTheme ? AppColors.error : AppColors.error,
              ),
            ),
            errorMaxLines: 3,
            labelStyle: TextStyle(
              color:
                  widget.lightTheme ? AppColors.darkColor : AppColors.darkColor,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            hintStyle: TextStyle(
              color:
                  widget.lightTheme ? AppColors.hintColor : AppColors.hintColor,
              fontSize: 14.spt,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: widget.onTap,
        ),
      ],
    );
  }

  void _handleTextAndFocusChange() {
    setState(() {
      isHintVisible =
          _textFocusNode.hasFocus || _textController.text.isNotEmpty;
    });
  }
}
