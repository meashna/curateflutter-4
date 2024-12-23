import 'package:bloc/bloc.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/home2/Data.dart';
import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../../../constants/network_check.dart';
part 'workout_activity_state.dart';

class WorkoutActivityCubit extends Cubit<WorkoutActivityState> {

  Data? dayData;
  final _userRepository = GetIt.I<UserRepository>();
  TodoListTasks? activityData;
  int currentDay=1;

  WorkoutActivityCubit(Data? dayData1,TodoListTasks? activityData1,int currentDay1) : super(WorkoutActivityInitial()) {
      currentDay=currentDay1;
      dayData=dayData1;
      activityData=activityData1;
  }

  Future<void> saveActivityData(Map<String, dynamic>? map) async {
    emit(WorkoutActivityLoading());
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
            }
          });
          emit(WorkoutSubmitionTaskSuccess(response.message??""));
        }else {
          emit(WorkoutActivityError(
            response.message,
          ));
        }
      } catch (e) {
        emit(WorkoutActivityError(e.toString()
        ));
      }
    } else {
      emit(WorkoutActivityNoInternet());
    }
  }
}
