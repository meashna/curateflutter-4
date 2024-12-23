import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/styles/colors.dart';
import 'package:curate/src/utils/daily_activity_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/apis/UIResponse.dart';
import '../../../../../data/models/response/home2/Data.dart';
import '../../../../../data/repository/user_repo/user_repository.dart';

part 'day_plan_state.dart';

class DayPlanCubit extends Cubit<DayPlanState> {
  Data? dayData;
  String? todoOrderId;
  int nextActivity = 0;
  int nextSelectedTask = -1;
  int currentDay = 0;
  bool isNotification = false;
  String taskId = "-1";
  final _userRepository = GetIt.I<UserRepository>();

  DayPlanCubit(this.isNotification, this.todoOrderId, this.taskId, this.dayData,
      this.currentDay)
      : super(DayPlanInitial()) {
    if (isNotification) {
      Future.delayed(Duration(milliseconds: 100), () {
        getDayData();
      });
    } else {
      if (dayData?.day == currentDay) {
        nextSelectedTask = DailyActivityUtils.findNextTasks(dayData?.todoList);
        emit(DayPlanInitial());
      }
    }
  }

  Future<void> getDayData() async {
    emit(DayPlanLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getDayData(todoOrderId ?? "");
        if (response.status == Status.COMPLETED) {
          dayData = response.data?.data;
          currentDay = (response.data?.currDay ?? 1).toInt();
          if (dayData?.day == currentDay) {
            nextSelectedTask =
                DailyActivityUtils.findNextTasks(dayData?.todoList);
          }
          emit(DayPlanSuccess());
        } else {
          emit(DayPlanError(
            response.message,
          ));
        }
      } catch (e) {
        emit(DayPlanError(e.toString()));
      }
    } else {
      DayPlanNoInternet();
    }
  }

  Future<void> saveActivityData(Map<String, dynamic>? map) async {
    emit(DayPlanLoading());
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
          emit(DayPlanError(
            response.message,
          ));
        }
      } catch (e) {
        emit(DayPlanError(e.toString()));
      }
    } else {
      emit(DayPlanNoInternet());
    }
  }

  void refreshData() {
    nextSelectedTask = DailyActivityUtils.findNextTasks(dayData?.todoList);
    emit(DayPlanInitial());
  }
}
