import 'dart:convert';

import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/questions/QuestionDto.dart';
import 'package:curate/src/data/models/response/questions/WeeklyAssessmentScore.dart';
import 'package:curate/src/screens/well_being_score/component/wellbeing_question_vm.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/app_router.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_path.dart';
import '../../../styles/colors.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_text_feild/app_text_from_feild.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../app_screens.dart';
import 'QuestionCard.dart';

class WellBeingQuestions extends StatefulWidget {
  final Map<String, dynamic> data;

  const WellBeingQuestions({super.key, required this.data});

  @override
  State<WellBeingQuestions> createState() => _WellBeingQuestionsState();
}

class _WellBeingQuestionsState extends State<WellBeingQuestions> {
  late PageController _pageController;
  var viewModel = WellbeingQuestionVM();
  @override
  late BuildContext context;
  int questionType = 0;
  bool isNotification = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    questionType = widget.data["questionType"];
    isNotification = widget.data["isNotification"] ?? false;
    if (isNotification &&
        questionType == AppConstants.wellbeingAssessmentQuestionType) {
      viewModel.getAssessmentQuestionStatus();
    } else {
      viewModel.getQuestions(questionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ChangeNotifierProvider<WellbeingQuestionVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<WellbeingQuestionVM>(builder: (context, viewModel, _) {
          switch (viewModel.questionsResponse?.status) {
            case Status.LOADING:
              context.loaderOverlay.show();
              return mainContent();
            case Status.ERROR:
              context.loaderOverlay.hide();
              AppUtils.showToast(viewModel.questionsResponse?.message ?? "");
              return mainContent();
            case Status.COMPLETED:
              if (questionType == AppConstants.wellbeingQuestionType ||
                  (questionType ==
                          AppConstants.wellbeingAssessmentQuestionType &&
                      viewModel.assessmentStatus)) {
                context.loaderOverlay.hide();
                int length = viewModel.questionList?.length ?? 0;
                for (int i = 0; i < length; i++) {
                  Image theImage = Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return ShimmerWidget.rectangular(
                      height: 150.sps,
                      width: 250.sps,
                    );
                    // You can use LinearProgressIndicator, CircularProgressIndicator, or a GIF instead
                  }, viewModel.questionList?[i].questionImage?.filePath ?? "",
                      fit: BoxFit.cover);

                  precacheImage(theImage.image, context);
                  viewModel.imageList?.add(theImage);
                }

                return mainContent();
              } else {
                context.loaderOverlay.hide();
                AppUtils.showToast("Weekly assessment already submitted");
                RouteNavigator.goBack();
                return mainContent();
              }
            case Status.NONE:
              // TODO: Handle this case.
              break;
          }
          return mainContent();
        }));
  }

  Widget mainContent() {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if (viewModel.pageIndex == 0) {
              Navigator.pop(context);
            } else {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }
          },
          child: Container(
            width: 50.sps,
            height: 50.sps,
            margin: EdgeInsets.only(left: 16.sps),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Image.asset(ImageAssetPath.icBack,
                width: 20.sps, height: 20.sps),
          ),
        ),
        title: Text(
            (questionType == 0)
                ? AppConstants.wellBeingScore
                : AppConstants.wellBeingAssessment,
            style: $styles.text.body1.copyWith(color: AppColors.blackColor)),
        centerTitle: true,
        actions: [
          Visibility(
            visible: (viewModel.questionList?.length ?? 0) > 0 ? true : false,
            child: Padding(
              padding: EdgeInsets.only(right: 16.sps),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "${viewModel.pageIndex + 1}",
                    style:
                        $styles.text.h7.copyWith(color: AppColors.blackColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: "/${viewModel.questionList?.length ?? 0}",
                        style: $styles.text.title2
                            .copyWith(color: AppColors.lightGreyColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.screenBackground,
        child: WillPopScope(
          onWillPop: () {
            if (viewModel.pageIndex == 0) {
              return Future.value(true);
            } else {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
              return Future.value(false);
            }
          },
          child: Column(
            children: [
              Container(
                height: 10.sps,
                margin: EdgeInsets.symmetric(horizontal: 16.sps),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.questionList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return customProgressBar(index + 1);
                    }),
              ),
              Visibility(
                visible: (questionType ==
                    AppConstants.wellbeingAssessmentQuestionType),
                child: Column(
                  children: [
                    SizedBox(height: 24.sps),
                    Text("In the past week...",
                        style: $styles.text.body1
                            .copyWith(color: AppColors.darkGreyColor)),
                  ],
                ),
              ),
              SizedBox(height: 16.sps),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: viewModel.questionList?.length ?? 0,
                  controller: _pageController,
                  itemBuilder: (context, index) => QuestionCard(
                    pageIndex: index,
                    viewModel: viewModel,
                    questionType: questionType,
                  ),
                  onPageChanged: (index) {
                    viewModel.updatepageIndex(index);
                  },
                ),
              ),
              getBtnWidget(),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 16)
            ],
          ),
        ),
      ),
    );
  }

  Widget getBtnWidget() {
    return (questionType == AppConstants.wellbeingQuestionType &&
            viewModel.pageIndex == 0)
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  background: AppColors.primary,
                  text: "Yes",
                  onClicked: () {
                    viewModel.calculateSelectedLogic(
                        viewModel.questionList![viewModel.pageIndex], 0,
                        isFirstQuestion: true);
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppScreens.diagnoseNow);
                    },
                    child: Text("No"),
                  ),
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
                background: AppColors.primary,
                text: "Continue",
                onClicked: () async {
                  QuestionDto? questions =
                      viewModel.questionList?[viewModel.pageIndex];
                  num min = questions?.min ?? 0;
                  num selectedcount = questions?.selectedOptions?.length ?? 0;
                  if (selectedcount >= min) {
                    if (viewModel.pageIndex ==
                        viewModel.questionList!.length - 1) {
                      submitAnswer();
                    } else {
                      addAnswerInList();
                    }
                  } else {
                    AppUtils.showToast("Please select $min options");
                  }
                }),
          );
  }

  Future<void> submitAnswer() async {
    List<Map<String, dynamic>> answers = [];
    for (int i = 0; i < viewModel.questionList!.length; i++) {
      QuestionDto questionDto = viewModel.questionList![i];
      Map<String, dynamic> ques = {};
      num questionId = questionDto.id!;
      List<num> optionIds = questionDto.selectedOptions!;
      answers.add({"questionId": questionId, "optionIds": optionIds});
    }

    context.loaderOverlay.show();
    var result = await viewModel.submitQuestions(answers, questionType);
    context.loaderOverlay.hide();
    if (result != null) {
      if (result.status == Status.COMPLETED) {
        if (questionType == AppConstants.wellbeingAssessmentQuestionType) {
          Map<String, dynamic> argument = {
            "scores": result.data?.assessmentHistory,
            "message": result.data?.message,
            "scorePercentage": result.data?.scorePercentage,
          };

          RouteNavigator.pop(context);
          RouteNavigator.pushNamed(context, AppScreens.wellBeingAssessment,
              arguments: argument);
        } else {
          RouteNavigator.popAllAndPushNamedReplacement(
              context, AppScreens.calculateWellbeingScore);
        }
      } else if (result.status == Status.ERROR) {
        AppUtils.showToast(result.message);
      }
    }
  }

  void addAnswerInList() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  Widget customProgressBar(int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.sps),
      height: 10.sps,
      width: ((MediaQuery.of(context).size.width -
              (32.sps + viewModel.questionList!.length * 8.sps)) /
          viewModel.questionList!.length),
      decoration: BoxDecoration(
          color: index <= (viewModel.pageIndex + 1)
              ? AppColors.primary
              : AppColors.greyColor,
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
    );
  }
}
