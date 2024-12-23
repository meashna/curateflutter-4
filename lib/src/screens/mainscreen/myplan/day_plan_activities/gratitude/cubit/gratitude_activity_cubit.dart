import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/utils/date_time_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../../data/models/response/home2/Data.dart';
import '../../../../../../data/repository/user_repo/user_repository.dart';

part 'gratitude_activity_state.dart';

class GratitudeActivityCubit extends Cubit<GratitudeActivityState> {

  Data? dayData;
  final _userRepository = GetIt.I<UserRepository>();
  DateTime? currentDate;
  DateTime? selectedDate;
  int selectedDay=0;
  int currentDay=0;
  TodoListTasks? gratitudeData;

  GratitudeActivityCubit(int selectedDay1,int currentDay1,TodoListTasks? activityData,Data? dayData1) : super(GratitudeActivityInitial("")){
     currentDate=DateTimeUtils.getGratitudeData(DateTime.now());
     selectedDate=DateTimeUtils.getGratitudeData(DateTime.now());

     selectedDay=selectedDay1;
     currentDay=currentDay1;
     dayData=dayData1;
     gratitudeData=activityData;
     if(selectedDay<currentDay){
       selectedDate=currentDate?.subtract(Duration(days: (currentDay1-selectedDay)));
       //getGratitudeData(selectedDate!,currentDay);
     }

  }

  Future<void> saveActivityData(Map<String, dynamic>? map) async {
    emit(GratitudeActivityLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.saveActivityData(map);

        if (response.status == Status.COMPLETED) {
          dayData?.status=response.data?.isDayComplete??0;
          var taskId=map?["todoListTaskId"];
          dayData?.todoList?.todoListTasks?.forEach((element) {
            if(element.id==taskId){
              element.todoListResponses=[];
              element.todoListResponses?.add(response.data!);
              gratitudeData=element;
            }
          });

          emit(GratitudeSaveCompletionState(response.message??""));
        }else {
          emit(GratitudeActivityError(
            response.message,
          ));
        }
      } catch (e) {
        emit(GratitudeActivityError(e.toString()
        ));
      }
    } else {
      emit(GratitudeActivityNoInternet());
    }
  }

  Future<void> getGratitudeData(DateTime date,int day) async {
    emit(GratitudeActivityLoading());
    selectedDate=date;
    selectedDay=day;
    Map<String,dynamic> map={
      "day":day
    };

    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getGratitideData(map);
        if (response.status == Status.COMPLETED) {
          selectedDay=(response.data?.day??1).toInt();
          gratitudeData=response.data?.todoList?.todoListTasks?.first;

          emit(GratitudeDataInitialState());
        }else {
          emit(GratitudeActivityError(
            response.message,
          ));
        }
      } catch (e) {
        emit(GratitudeActivityError(e.toString()
        ));
      }
    } else {
      emit(GratitudeActivityNoInternet());
    }
  }




}
