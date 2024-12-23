import 'package:cached_network_image/cached_network_image.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/data/models/response/questions/QuestionDto.dart';
import 'package:curate/src/screens/well_being_score/component/wellbeing_question_vm.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

import '../../../data/models/response/questions/OptionDto.dart';
import '../../../widgets/shimmer_widget.dart';
import 'option.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {super.key,
      // it means we have to pass this
      required this.viewModel,
      required this.pageIndex,
      required this.questionType});

  final WellbeingQuestionVM viewModel;
  final int pageIndex;
  final int questionType;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  QuestionDto? question;

  late Image theImage;

  /// Did Change Dependencies
  @override
  void didChangeDependencies() {
    theImage = Image.network(loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;

      return ShimmerWidget.rectangular(
        height: 150.sps,
        width: 250.sps,
      );
      // You can use LinearProgressIndicator, CircularProgressIndicator, or a GIF instead
    },
        widget.viewModel.questionList![widget.pageIndex].questionImage
                ?.filePath ??
            "",
        fit: BoxFit.cover);

    precacheImage(theImage.image, context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = widget.viewModel.questionList![widget.pageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 40.sps),
        color: AppColors.screenBackground,
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    print("image oiuygt");
    print(widget.viewModel.imageList?[widget.pageIndex]);
    return Column(
      children: [
        /* CachedNetworkImage(imageUrl:theImage,height: 150.sps,placeholder: (context, url) => ShimmerWidget.rectangular(height: 150.sps,width: 250.sps,),
          errorWidget: (context, url, error) => Icon(Icons.error),),
        ProgressiveImage(
            placeholder: AssetImage('assets/icon/sample_tn.jpg'),
            thumbnail:AssetImage('assets/icon/sample_tn.jpg'), // 64x36
            image: theImage as ImageProvider, // 3842x2160
            height: 150.sps,
            width: MediaQuery.of(context).size.width-116.sps,
            fit:BoxFit.none
        ),*/
        SizedBox(
            height: 150, child: widget.viewModel.imageList?[widget.pageIndex]),
        SizedBox(
          height: 20.sps,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.sps),
          child: Center(
            child: Text(
              question?.title ?? "",
              style: $styles.text.h6.copyWith(color: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        (question?.description == null || question?.description == "")
            ? Container()
            : SizedBox(
                height: 12.sps,
              ),
        (question?.description == null || question?.description == "")
            ? Container()
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 40.sps, vertical: 8.sps),
                child: Center(
                  child: Text(
                    question?.description ?? "",
                    style: $styles.text.noti_title
                        .copyWith(color: AppColors.darkGreyColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

        /* if(widget.questionType==AppConstants.wellbeingQuestionType && widget.pageIndex == 0)...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.sps),
            child: Text(
              question?.description??"",
              textAlign: TextAlign.center,
              style: $styles.text.body2.copyWith(color: AppColors.darkGrey),
            )
          ),
        ],*/
        if (widget.questionType ==
                AppConstants.wellbeingAssessmentQuestionType ||
            widget.pageIndex != 0) ...[
          ...List.generate(
            question?.Options?.length ?? 0,
            (index) {
              OptionDto? optionDto = question?.Options?[index];
              return Option(
                index: index,
                pageIndex: widget.pageIndex,
                model: widget.viewModel,
              );
            },
          ),
        ]
      ],
    );
  }
}
