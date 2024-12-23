import 'package:flutter/material.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_text_feild/text_feild_input_formatter.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_constants.dart';
import '../../styles/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.hintText,
    required this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    super.key,
    this.textEditingController,
    this.onObsecureTap,
    this.onTap,
    this.lightTheme = true,
    this.contentPadding,
    this.disableEditing = false,
    this.defaultText,
    this.suffixIconPath,
  });

  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onObsecureTap;
  final bool lightTheme;
  final EdgeInsetsGeometry? contentPadding;
  final bool disableEditing;
  final String? defaultText;
  final String? suffixIconPath;

  @override
  State<StatefulWidget> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _textController;
  late bool _textControllerFromParent;
  late FocusNode _textFocusNode;
  bool isHintVisible = false;

  @override
  void initState() {
    _textFocusNode =
        widget.disableEditing ? AlwaysDisabledFocusNode() : FocusNode();

    _textControllerFromParent = widget.textEditingController != null;
    _textController = widget.textEditingController ?? TextEditingController();
    _textController.text = widget.defaultText ?? '';

    _textController.addListener(() {
      _handleTextAndFocusChange();
    });
    _textFocusNode.addListener(() {
      _handleTextAndFocusChange();
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
    // final isTablet = AppConstants.isTablet;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  widget.labelText,
                  style: TextStyle(
                      color: widget.lightTheme
                          ? AppColors.darkGrey
                          : AppColors.darkGrey,
                      fontSize: 14.sp,
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
        const SizedBox(height: 8.0),
        TextField(
          controller: _textController,
          focusNode: _textFocusNode,
          textCapitalization: widget.textCapitalization,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          enabled: !widget.disableEditing,
          enableSuggestions: false,
          autocorrect: false,
          inputFormatters: [CaseFormatting()],
          style: TextStyle(
            color: widget.lightTheme ? AppColors.darkColor : AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
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
            hintText: widget.hintText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.sp, vertical: 0),
            filled: true,
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
                    ? AppColors.lightestGrey1
                    : AppColors.lightestGrey1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.lightTheme
                    ? AppColors.lightestGrey1
                    : AppColors.lightestGrey1,
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
              color: widget.lightTheme ? AppColors.black : AppColors.black,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            hintStyle: TextStyle(
              color:
                  widget.lightTheme ? AppColors.lightestGrey1 : AppColors.black,
              fontSize: 14.sp,
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
