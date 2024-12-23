import 'package:curate/src/constants/asset_path.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/data/models/response/myplan/WorkoutMetaData.dart';
import 'package:curate/src/screens/mainscreen/myplan/day_plan_activities/workout/cubit/workout_activity_cubit.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/styles/styles.dart';
import 'package:curate/src/utils/app_bar.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/extensions.dart';
import 'package:curate/src/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutActivityScreen extends StatefulWidget {
  final Map<String, dynamic> activityMap;
  const WorkoutActivityScreen({super.key, required this.activityMap});

  @override
  State<WorkoutActivityScreen> createState() => _WorkoutActivityScreenState();

  static Widget create(Map<String, dynamic> argumentData) {
    Data? dayData = argumentData["dayData"];
    return BlocProvider(
        create: (BuildContext context) => WorkoutActivityCubit(
            dayData, argumentData["activityData"], argumentData["currentDay"]),
        child: WorkoutActivityScreen(activityMap: argumentData));
  }
}

class _WorkoutActivityScreenState extends State<WorkoutActivityScreen> {
  TodoListTasks? activityData;
  Data? dayData;
  WorkoutMetaData? workoutMetaData;
  List<Widget> sessionInstructions = <Widget>[];
  YoutubePlayerController? controller1;
  WorkoutActivityCubit? cubit;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);

    activityData = widget.activityMap["activityData"];
    dayData = widget.activityMap["dayData"];
    workoutMetaData = WorkoutMetaData.fromJson(activityData?.metaData);

    var flags = const YoutubePlayerFlags(
      hideControls: false,
      mute: false,
      autoPlay: false,
      disableDragSeek: false,
      loop: true,
      isLive: false,
      forceHD: false,
      enableCaption: false,
    );
    controller1 = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(workoutMetaData?.link ?? "")!,
        flags: flags);

    if ((workoutMetaData?.sessionIncludes?.length ?? 0) != 0) {
      sessionInstructions.add(getInstructionTitle("Session includes:"));
      for (var i = 0;
          i < (workoutMetaData?.sessionIncludes?.length ?? 0);
          i++) {
        sessionInstructions.add(getInstructionStatement(
            "${i + 1}. ${workoutMetaData?.sessionIncludes?[i]}"));
      }
    }

    if ((workoutMetaData?.proTips?.length ?? 0) != 0) {
      sessionInstructions.add(getInstructionTitle("Pro Tips:"));
      for (var i = 0; i < (workoutMetaData?.proTips?.length ?? 0); i++) {
        sessionInstructions.add(getInstructionStatement(
            "${i + 1}. ${workoutMetaData?.proTips?[i]}"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.screenBackground,
      child: BlocConsumer<WorkoutActivityCubit, WorkoutActivityState>(
        listener: (context, state) {
          if (state is WorkoutActivityLoading) {
            context.loaderOverlay.show();
          } else if (state is WorkoutDataInitialState) {
            context.loaderOverlay.hide();
            AppUtils.showToast(state.message);
          } else if (state is WorkoutSubmitionTaskSuccess) {
            context.loaderOverlay.hide();
            AppUtils.showToast(state.successMesaage);
            Navigator.pop(context, cubit?.activityData);
          } else if (state is WorkoutActivityInitial) {
            context.loaderOverlay.hide();
          } else if (state is WorkoutActivityError) {
            context.loaderOverlay.hide();
            AppUtils.showToast(state.errorMessage);
          }
        },
        builder: (context, state) {
          cubit = BlocProvider.of<WorkoutActivityCubit>(context);
          if (state is WorkoutActivityInitial ||
              state is WorkoutActivityError ||
              state is WorkoutActivityLoading ||
              state is WorkoutSubmitionTaskSuccess) {
            return YoutubePlayerBuilder(
              builder: (BuildContext context, Widget player) {
                return Scaffold(
                  appBar: PreferredSize(
                      preferredSize:
                          const Size(double.infinity, kToolbarHeight),
                      child: CustomAppbar(title: activityData?.tag ?? "")),
                  body: mainContent(player),
                );
              },
              player: YoutubePlayer(
                showVideoProgressIndicator: true,
                controller: controller1!,
                progressIndicatorColor: AppColors.primary,
              ),
              onEnterFullScreen: () {
                //AppUtils.showToast("Enter");
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]);
              },
              onExitFullScreen: () {
                //AppUtils.showToast("Exit");
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
                //The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget mainContent(Widget player) {
    return Padding(
      padding: EdgeInsets.all(16.sps),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(activityData?.taskTitle ?? "",
                style: $styles.text.h6.copyWith(color: AppColors.blackColor)),
          ),
          SizedBox(
            height: 16.sps,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.sps)),
            height: 150.sps,
            child: player,
          ),
          SizedBox(
            height: 24.sps,
          ),
          Row(
            children: [
              getWidgetProperties(
                  workoutMetaData?.level ?? "", ImageAssetPath.icLevel),
              getWidgetProperties(
                  workoutMetaData?.duration ?? "", ImageAssetPath.icTime),
              getWidgetProperties(
                  workoutMetaData?.language ?? "", ImageAssetPath.icLanguage)
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: sessionInstructions.length,
                itemBuilder: (BuildContext context, int index) {
                  return sessionInstructions[index];
                }),
          ),
          Visibility(
            visible: (cubit?.currentDay == cubit?.dayData?.day &&
                    cubit?.activityData?.todoListResponses?.length == 0)
                ? true
                : false,
            child: Padding(
              padding: EdgeInsets.all(8.sps),
              child: AppButton(
                background: AppColors.primary,
                text: "Done",
                onClicked: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  HapticFeedback.mediumImpact();
                  Map<String, dynamic>? map = {
                    "todoOrderId": dayData?.id,
                    "todoListId": dayData?.todoListId ?? "",
                    "todoListTaskId": activityData?.id,
                    "watchTime": "120"
                  };
                  cubit?.saveActivityData(map);
                  controller1?.pause();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetProperties(String name, String image) {
    return Expanded(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.lightGreenColor, shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.all(10.sps),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SvgPicture.asset(
                  image,
                  height: 16.sps,
                  width: 16.sps,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.sps,
          ),
          Text(name,
              style: $styles.text.title3.copyWith(color: AppColors.blackColor))
        ],
      ),
    );
  }

  Widget getInstructionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 24.sps, bottom: 2.sps),
      child: Text(title,
          style: $styles.text.h8.copyWith(color: AppColors.blackColor)),
    );
  }

  Widget getInstructionStatement(String instructions) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sps),
      child: Text(instructions,
          style: $styles.text.body2.copyWith(color: AppColors.darkGreyColor)),
    );
  }

  @override
  void deactivate() {
    controller1?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    controller1?.dispose();
    super.dispose();
  }
}
