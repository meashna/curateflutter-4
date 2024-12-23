import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/data/models/response/myplan/NutritionMetaData.dart';
import 'package:curate/src/data/models/response/myplan/WorkoutMetaData.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class NutritionActivityScreen extends StatefulWidget {
  TodoListTasks activityDayData;
  NutritionActivityScreen({super.key, required this.activityDayData});

  @override
  State<NutritionActivityScreen> createState() =>
      _NutritionActivityScreenState();
}

class _NutritionActivityScreenState extends State<NutritionActivityScreen> {
  List<NutritionMetaData>? nutritionList;
  @override
  void initState() {
    super.initState();

    nutritionList = [];
    widget.activityDayData.metaData.forEach((v) {
      nutritionList?.add(NutritionMetaData.fromJson(v));
    });

    /*json_todoList = json['todoList'] != null
        ?  TodoList.fromJson(json['todoList'])
        : null;*/
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () {
                RouteNavigator.goBack();
              },
              child: Container(
                width: 50.sps,
                height: 50.sps,
                margin: EdgeInsets.all(16.sps),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Image.asset(ImageAssetPath.icClose,
                    width: 20.sps, height: 20.sps),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 60.sps),
                SvgPicture.asset(ImageAssetPath.ivNutritionActivity),
                SizedBox(height: 44.sps),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.sps, horizontal: 16.sps),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sps),
                      color: AppColors.nutritionBackgroundColor),
                  child: Text(
                    "Nutrition",
                    style: $styles.text.title3
                        .copyWith(color: AppColors.nutritionTextColor),
                  ),
                ),
                SizedBox(height: 10.sps),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.sps),
                  child: Text(widget.activityDayData.taskTitle ?? "",
                      style:
                          $styles.text.h8.copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  height: (130 * (nutritionList?.length ?? 0).toInt()).sps,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: nutritionList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return getNutritionData(nutritionList![index]);
                      }),
                ),
                SizedBox(height: 16.sps),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget getNutritionData(NutritionMetaData nutritionData) {
    return Padding(
      padding: EdgeInsets.only(left: 16.sps, right: 16.sps, top: 16.sps),
      child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(16.sps),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.lightGreenColor,
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(10.sps),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SvgPicture.asset(
                            ImageAssetPath.icFoodDiet,
                            height: 16.sps,
                            width: 16.sps,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.sps),
                    Expanded(
                      child: Text(nutritionData.title ?? "",
                          textAlign: TextAlign.start,
                          style: $styles.text.h8
                              .copyWith(color: AppColors.blackColor)),
                    ),
                    ((nutritionData.key ?? "").isNotEmpty)
                        ? RichText(
                            text: TextSpan(
                                text: "${nutritionData.key ?? ""}: ",
                                style: $styles.text.body2
                                    .copyWith(color: AppColors.darkGreyColor),
                                children: <TextSpan>[
                                TextSpan(
                                  text: nutritionData.value.toString() ?? "",
                                  style: $styles.text.title3
                                      .copyWith(color: AppColors.darkGreyColor),
                                )
                              ]))
                        : Container()
                  ],
                ),
                SizedBox(width: 8.sps),
                SizedBox(
                  // height: (20*(nutritionData.points?.length??0).toInt()).sps,
                  child: ListView.builder(
                      itemCount: nutritionData.points?.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return getInstruction(nutritionData.points?[index]);
                      }),
                )
              ],
            ),
          )),
    );
  }

  Widget getInstruction(String? point) {
    return Padding(
      padding: EdgeInsets.only(left: 16.sps),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 6.sps,
            width: 6.sps,
            decoration: const BoxDecoration(
                color: AppColors.darkGreenColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.sps),
          Expanded(
            //point??""
            child: Text(point ?? "",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: $styles.text.body2
                    .copyWith(color: AppColors.darkGreyColor)),
          ),
        ],
      ),
    );
  }
}
