import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'waist_log_screen_state.dart';

class WaistLogScreenCubit extends Cubit<WaistLogScreenState> {

  final _userRepository = GetIt.I<UserRepository>();
  List<HealthLogData> waistData = [];
  int pageNumber = 1;
  bool isLastPage = false;
  bool isRefresh = false;
  bool isLoading = false;

  WaistLogScreenCubit() : super(WaistLogScreenInitial()){
    emit(WaistLogScreenLoading());
    getWaistData();
  }

  Future<void> getWaistData({bool isRefresh = false}) async {
    if(isLoading){
      return;
    }
    isLoading = true;
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {

        this.isRefresh = isRefresh;
        if(isRefresh){
          pageNumber = 1;
          isLastPage = false;
        }
        Map<String,dynamic> map={
          "type":AppConstants.patientWaistLog,
          "perPage":10,"page":pageNumber
        };
        var response = await _userRepository.getPatientLog(map);
        if (response.status == Status.COMPLETED) {
          waistData=response.data?.data??[];
          if(pageNumber < (response.data!.totalPage ?? 0)){
            pageNumber++;
          }else{
            isLastPage = true;
          }
          emit(WaistLogScreenSuccess());
          //emit(WeightScreenError("Kuch bhi"));
        }else {
          emit(WaistLogScreenError(response.message));
        }
      } catch (e) {
        emit(WaistLogScreenError(e.toString()
        ));
      }
    } else {
      emit(WaistLogScreenNoInternet());
    }
    isLoading = false;
  }

  Future<void> saveWaistData(double waistData) async {
    emit(SaveWaistDataLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
          "type": AppConstants.patientWaistLog,
          "waist": waistData,
        };
        var response = await _userRepository.addPatientLog(json);
        if (response.status == Status.COMPLETED) {
          emit(SaveWaistDataSuccess());
        }else {
          emit(WaistLogScreenError(response.message));
        }
      } catch (e) {
        emit(WaistLogScreenError(e.toString()
        ));
      }
    } else {
      emit(WaistLogScreenNoInternet());
    }
  }
  Future<void> updateWaistData(double waistData, num id) async {
    emit(SaveWaistDataLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
          "type": AppConstants.patientWaistLog,
          "waist": waistData,
        };
        var response = await _userRepository.updatePatientLog(json,id);
        if (response.status == Status.COMPLETED) {
          emit(SaveWaistDataSuccess());
        }else {
          emit(WaistLogScreenError(response.message));
        }
      } catch (e) {
        emit(WaistLogScreenError(e.toString()
        ));
      }
    } else {
      emit(WaistLogScreenNoInternet());
    }
  }
}
