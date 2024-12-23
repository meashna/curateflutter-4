import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/data/models/response/myplan/NutritionMetaData.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/utils/routes/myNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/asset_path.dart';
import '../../../../styles/colors.dart';
import '../../../../styles/styles.dart';

class RemedyActivityScreen extends StatefulWidget {
  TodoListTasks? activityDayData;
  RemedyActivityScreen({super.key, required this.activityDayData});

  @override
  State<RemedyActivityScreen> createState() => _RemedyActivityScreenState();
}

class _RemedyActivityScreenState extends State<RemedyActivityScreen> {
  List<NutritionMetaData>? nutritionList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nutritionList = [];
    widget.activityDayData?.metaData.forEach((v) {
      nutritionList?.add(NutritionMetaData.fromJson(v));
    });
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
                SizedBox(height: 30.sps),
                SvgPicture.asset(ImageAssetPath.ivMedicineActivity),
                SizedBox(height: 44.sps),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.sps, horizontal: 16.sps),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sps),
                      color: AppColors.medicineBackgroundColor),
                  child: Text(
                    widget.activityDayData?.tag ?? "",
                    style: $styles.text.title3
                        .copyWith(color: AppColors.medicineTextColor),
                  ),
                ),
                SizedBox(height: 10.sps),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.sps),
                  child: Text(widget.activityDayData?.taskTitle ?? "",
                      style:
                          $styles.text.h6.copyWith(color: AppColors.blackColor),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 32.sps),
                SizedBox(
                  height: (40 * (nutritionList?.length ?? 0).toInt()).sps,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: nutritionList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            getProcessWidget(nutritionList![index].key ?? "",
                                nutritionList![index].value ?? ""),
                            SizedBox(height: 16.sps),
                          ],
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget getProcessWidget(String name, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.sps),
      child: Row(
        children: [
          Text(name,
              style:
                  $styles.text.body2.copyWith(color: AppColors.darkGreyColor)),
          const Expanded(
            child: Divider(
              color: AppColors.lightGreyColor1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Text(value,
              style:
                  $styles.text.title3.copyWith(color: AppColors.darkGreyColor))
        ],
      ),
    );
  }
}
