import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/home2/DailyMood.dart';
import 'package:curate/src/data/models/response/home2/HomeApiResponse.dart';
import 'package:curate/src/data/models/response/home2/TodoList.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/response/home2/Data.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/notification/notification_count_bloc/notification_count_cubit.dart';
import '../../../../utils/routes/myNavigator.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _preferences = GetIt.I<PreferencesManager>();

  UIResponse<HomeApiResponse>? homeResponse;
  PersonalInfo? personalInfo;
  DailyMood? dailyMoodesponse;
  int nextSelectedTask = -1;
  Data? dayData;
  List<TodoListTasks>? todoListResponses;
  TodoList? dayResponse;
  int totalWeek = 0;
  int enableWeek = 0;
  int? selectedMood;
  int? currentDay = 0;

  PersonalInfo? username;
  bool showUpgradeButton = false;
  bool isAllNotificationSeen = false;
  bool isPlanExpired = false;

  HomeScreenCubit()
      : super(HomeScreenInitial(AppConstants.homeScreenDefaultType)) {
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(HomeScreenLoading());
      getData();
    });
  }

  getData() async {
    username = await getName();
    getHomeData();
  }

  Future<void> submitMood(int index) async {
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        selectedMood = index;
        List<Map<String, dynamic>> answers = [];
        num? questionId = dailyMoodesponse?.id!;
        List<int> optionIds = [selectedMood ?? 0];
        answers.add({"questionId": questionId, "optionIds": optionIds});

        var response = await _userRepository.submitQuestions(
            answers, AppConstants.moodQuestionType);
        if (response.status == Status.COMPLETED) {
          homeResponse?.data?.lastSubmitDate =
              DateTime.now().toUtc().toString();
          dailyMoodesponse?.options?.forEach((element) {
            if (element.id == selectedMood) {
              element.selected = true;
            } else {
              element.selected = false;
            }
          });
          emit(HomeScreenInitial(AppConstants.homeScreenMoodType));
        } else {
          AppUtils.showToast(response.message);
        }
      } catch (e) {
        AppUtils.showToast(e.toString());
      }
    } else {
      emit(HomeScreenNoInternet());
    }
  }

  Future<void> getHomeData() async {
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        var response = await _userRepository.getHomeData();
        if (response.status == Status.COMPLETED) {
          homeResponse = response;
          isAllNotificationSeen = response.data?.isAllNotificationSeen ?? true;
          if (!isAllNotificationSeen) {
            BlocProvider.of<NotificationCountCubit>(
                    RouteNavigator.navigatorKey.currentState!.context)
                .updateCount(0);
          }
          dailyMoodesponse = response.data?.dailyMood;
          personalInfo = response.data?.personalInfo;

          if (personalInfo!.isExpiry ?? false) {
            isPlanExpired = personalInfo!.isExpiry ?? false;
            emit(HomeScreenInitial(AppConstants.homeScreenDefaultType));
            return;
          }

          //showUpgradeButton = true;
          if (personalInfo != null) {
            if (personalInfo!.purchaseCount != null) {
              var date;
              var duration;
              if ((personalInfo!.purchaseCount ?? 0) >= 1) {
                date = personalInfo!.productStart;
                duration = personalInfo!.productDuration;
              } else {
                date = personalInfo!.trialStart;
                duration = personalInfo!.trialDuration;
              }
              DateTime? parseDateTime = DateTimeUtils.getApiDatetoUtc(date);
              if (parseDateTime != null) {
                var ddd =
                    parseDateTime.add(Duration(days: ((duration ?? 0) - 7)));
                if (ddd.isBefore(DateTime.now())) {
                  showUpgradeButton = true;
                }
              }
            }
          }

          dayData = response.data?.data;
          currentDay = (response.data?.currDay ?? 1).toInt();
          todoListResponses = response.data?.data?.todoList?.todoListTasks;
          dayResponse = response.data?.data?.todoList;
          enableWeek = ((homeResponse?.data?.currDay ?? 0) / 7).ceil();
          totalWeek = calculateWeek();
          nextSelectedTask =
              DailyActivityUtils.findNextTasks(dayData?.todoList);
          emit(HomeScreenInitial(AppConstants.homeScreenDefaultType));
        } else {
          emit(HomeScreenError(
            response.message,
          ));
        }
      } catch (e) {
        emit(HomeScreenError(e.toString()));
      }
    } else {
      //Future.delayed(Duration(milliseconds: 100),(){emit(HomeScreenNoInternet());});
      emit(HomeScreenNoInternet());
    }
  }

  Future<void> saveActivityData(Map<String, dynamic>? map) async {
    emit(TaskSubmitLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.saveActivityData(map);
        var taskId = map?["todoListTaskId"];
        if (response.status == Status.COMPLETED) {
          dayData?.status = response.data?.isDayComplete ?? 0;
          dayData?.todoList?.todoListTasks?.forEach((element) {
            if (element.id == taskId) {
              element.todoListResponses = [];
              element.todoListResponses?.add(response.data!);
            }
          });
          if (dayData?.day == currentDay) {
            nextSelectedTask =
                DailyActivityUtils.findNextTasks(dayData?.todoList);
          }
          emit(CompleteTaskSuccess());
        } else {
          AppUtils.showToast(response.message);
          emit(CompleteTaskSuccess());
        }
      } catch (e) {
        AppUtils.showToast(e.toString());
        emit(CompleteTaskSuccess());
      }
    } else {
      emit(HomeScreenNoInternet());
    }
  }

  Future<PersonalInfo?> getName() async {
    return await _preferences.getUserProfile();
  }

  int calculateWeek() {
    return ((homeResponse?.data?.planDays ?? 0) / 7).ceil();
  }

  void refreshData(TodoListTasks activityData, int index) {
    dayData?.todoList?.todoListTasks?[index] = activityData;
    nextSelectedTask = DailyActivityUtils.findNextTasks(dayData?.todoList);
    emit(HomeScreenInitial(AppConstants.homeScreenDefaultType));
  }
}
