import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/healthLog/PeriodsFlows.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'add_flow_state.dart';

class AddFlowCubit extends Cubit<AddFlowState> {
  final _userRepository = GetIt.I<UserRepository>();
  List<PeriodsFlows> flowTypes=[];
  num selectedReason=-1;

  AddFlowCubit() : super(AddFlowInitial()){
    Future.delayed(Duration(milliseconds: 100),(){
      getPeriodFlows();
    });

  }

  Future<void> getPeriodFlows() async {
    emit(AddFlowLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getPeriodFlows();
        if (response.status == Status.COMPLETED) {
          flowTypes=response.data?.periodsFlows??[];
          emit(AddFlowSuccess());
        }else {
          emit(AddFlowError(response.message));
        }
      } catch (e) {
        emit(AddFlowError(e.toString()
        ));
      }
    } else {
      emit(AddFlowNoInternet());
    }
  }

  Future<void> savePeriodData(List<DateTime?> dates) async {
    emit(AddFlowLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
            "type": 1,
            "periodCycleFrom": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dates.first??DateTime.now()),
            "periodCycleTo": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dates.last??DateTime.now()),
            "periodFlowId": selectedReason,
          };
        var response = await _userRepository.addPatientLog(json);
        if (response.status == Status.COMPLETED) {
          emit(SubmitFlowSuccess());
        }else {
          emit(AddFlowError(response.message));
        }
      } catch (e) {
        emit(AddFlowError(e.toString()
        ));
      }
    } else {
      emit(AddFlowNoInternet());
    }
  }

  Future<void> updatePeriodData(List<DateTime?> dates,num id) async {
    emit(AddFlowLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
          "type": 1,
          "periodCycleFrom": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dates.first??DateTime.now()),
          "periodCycleTo": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dates.last??DateTime.now()),
          "periodFlowId": selectedReason,
        };
        var response = await _userRepository.updatePatientLog(json,id);
        if (response.status == Status.COMPLETED) {
          emit(SubmitFlowSuccess());
        }else {
          emit(AddFlowError(response.message));
        }
      } catch (e) {
        emit(AddFlowError(e.toString()
        ));
      }
    } else {
      emit(AddFlowNoInternet());
    }
  }

  Future<void> saveSelectedReason(num reason) async{
    selectedReason=reason;
    emit(AddFlowSuccess());
  }

}
