import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/questions/OptionDto.dart';
import 'package:curate/src/screens/well_being_score/component/wellbeing_question_vm.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../data/models/response/questions/QuestionDto.dart';
import '../../../styles/styles.dart';

class Option extends StatefulWidget {
  Option(
      {super.key,
      required this.index,
      required this.pageIndex,
      required this.model});

  final int index;
  final int pageIndex;
  WellbeingQuestionVM model;
  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  OptionDto? optionData;
  QuestionDto? questionData;

  @override
  void initState() {
    super.initState();
    questionData = widget.model.questionList![widget.pageIndex];
    optionData = questionData?.Options?[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.model.calculateSelectedLogic(questionData!, widget.index);
        },
        child: mainContent());
  }

  Widget mainContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sps, vertical: 20.sps),
      margin: EdgeInsets.only(left: 16.sps, right: 16.sps, top: 8.sps),
      decoration: BoxDecoration(
          color: (optionData?.isSelected ?? false)
              ? AppColors.lightGreenColor
              : AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        children: [
          ((questionData?.min ?? 0) == 1 && (questionData?.max ?? 0) == 1)
              ? getRadioSymbol()
              : getTickSymbol(),
          SizedBox(
            width: 16.sps,
          ),
          Expanded(
            child: Text(
              optionData?.optionTitle ?? "",
              textAlign: TextAlign.start,
              maxLines: 4,
              style: $styles.text.body2.copyWith(color: AppColors.blackColor),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }

  Widget getTickSymbol() {
    return (optionData?.isSelected ?? false)
        ? Container(
            height: 30.sps,
            width: 30.sps,
            decoration: const BoxDecoration(
                color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
                child: Icon(Icons.check_rounded,
                    color: AppColors.white, size: 16.sps)))
        : Container(
            height: 30.sps,
            width: 30.sps,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyColor)),
          );
  }

  Widget getRadioSymbol() {
    return (optionData?.isSelected ?? false)
        ? Container(
            height: 30.sps,
            width: 30.sps,
            decoration: const BoxDecoration(
                color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
                child:
                    Icon(Icons.circle, color: AppColors.white, size: 16.sps)))
        : Container(
            height: 30.sps,
            width: 30.sps,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyColor)),
          );
  }
}
