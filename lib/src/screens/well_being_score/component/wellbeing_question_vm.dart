import 'dart:convert';

import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/AssessmentStatusDto.dart';
import 'package:curate/src/data/models/response/questions/OptionDto.dart';
import 'package:curate/src/data/models/response/questions/QuestionDto.dart';
import 'package:curate/src/data/models/response/questions/WellbeingQuestionDto.dart';
import 'package:curate/src/data/models/response/questions/WellbeingScoreDto.dart';
import 'package:curate/src/data/repository/user_repo/user_repository_impl.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:flutter/material.dart';

class WellbeingQuestionVM extends ChangeNotifier {
  WellbeingQuestionVM();

  int pageIndex = 0;
  UIResponse<WellbeingQuestionDto>? questionsResponse;
  List<QuestionDto>? questionList = [];
  List<Image>? imageList = [];
  bool assessmentStatus = true;

  final _myRepo = UserRepositoryImpl();

  Future<void> getQuestions(int questionType) async {
    _setQuestions(UIResponse.loading());
    _myRepo
        .getWellbeingScore(questionType)
        .then((value) => _setQuestions(value))
        .onError((error, stackTrace) =>
            _setQuestions(UIResponse.error(error.toString())));
  }

  void _setQuestions(UIResponse<WellbeingQuestionDto> response) {
    questionList = response.data?.questionDto;
    questionsResponse = response;
    notifyListeners();
  }

  Future<void> getAssessmentQuestionStatus() async {
    _setAssssmentstatus(UIResponse.loading());
    _myRepo
        .getAssessmentStatus()
        .then((value) => _setAssssmentstatus(value))
        .onError((error, stackTrace) =>
            _setAssssmentstatus(UIResponse.error(error.toString())));
  }

  void _setAssssmentstatus(UIResponse<AssessmentStatusDto> response) {
    assessmentStatus = response.data?.isPendingAssessment ?? false;
    //assessmentStatus=false;
    if (response.status == Status.LOADING || response.status == Status.ERROR) {
      notifyListeners();
    } else {
      getQuestions(AppConstants.wellbeingAssessmentQuestionType);
    }
  }

  Future<UIResponse<WellbeingScoreDto>?> submitQuestions(
      List<Map<String, dynamic>> answers, int questionType) async {
    var result = await _myRepo.submitQuestions(answers, questionType);
    return result;
  }

  updatepageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void calculateSelectedLogic(QuestionDto questionData, int index,
      {bool isFirstQuestion = false}) {
    var questionData1 = questionList?[pageIndex];
    var optionData = questionData1?.Options![index];

    if (!(optionData?.isSelected ?? false)) {
      questionData1?.selectedOptions ??= [];

      num max = questionData1?.max ?? 0;
      num min = questionData1?.min ?? 0;

      //means single selection option
      if (min == 1 && max == 1) {
        questionData1?.selectedOptions?.clear();
        var options = questionData1?.Options!;
        if (options != null) {
          for (OptionDto? option in (options)) {
            option?.isSelected = false;
          }
        }

        optionData?.isSelected = !(optionData.isSelected ?? false);
        questionData1?.selectedOptions?.add((optionData?.id ?? 0));
      } else {
        if ((questionData1?.selectedOptions?.length ?? 0) <= max) {
          optionData?.isSelected = !(optionData.isSelected ?? false);
          questionData1?.selectedOptions?.add((optionData?.id ?? 0));
        } else {
          AppUtils.showToast("You can select $max options");
        }
      }
    } else {
      if (!isFirstQuestion) {
        optionData?.isSelected = !(optionData.isSelected ?? false);
        questionData1?.selectedOptions?.remove((optionData?.id ?? 0));
      }
    }

    print("Selected Values");
    //AppUtils.showToast(questionData1?.selectedOptions.toString());
    print(questionData1?.selectedOptions.toString());

    notifyListeners();
  }
}
