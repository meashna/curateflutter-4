import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'weight_screen_state.dart';

class WeightScreenCubit extends Cubit<WeightScreenState> {

  final _userRepository = GetIt.I<UserRepository>();
  List<HealthLogData> weightData=[];
  int pageNumber = 1;
  bool isLastPage = false;
  bool isRefresh = false;
  bool isLoading = false;

  WeightScreenCubit() : super(WeightScreenInitial()){
    emit(WeightScreenLoading());
     getWeightData(); 
  }

  Future<void> getWeightData({bool isRefresh = false}) async {
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
          "type":AppConstants.patientWeightLog,"perPage":10,"page":pageNumber
        };
        var response = await _userRepository.getPatientLog(map);
        if (response.status == Status.COMPLETED) {
          weightData = response.data?.data ?? [];
          if(pageNumber < (response.data!.totalPage ?? 0)){
            pageNumber++;
          }else{
            isLastPage = true;
          }
          emit(WeightScreenSuccess());
          //emit(WeightScreenError("Kuch bhi"));
        }else {
          emit(WeightScreenError(response.message));
        }
      } catch (e) {
        emit(WeightScreenError(e.toString()
        ));
      }
    } else {
      emit(WeightScreenNoInternet());
    }
    isLoading = false;
  }


  Future<void> saveWeightData(double weightData) async {
    emit(SaveWeightDataLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
          "type": AppConstants.patientWeightLog,
          "weight": weightData,
        };
        var response = await _userRepository.addPatientLog(json);
        if (response.status == Status.COMPLETED) {
          emit(SaveWeightDataSuccess());
        }else {
          emit(WeightScreenError(response.message));
        }
      } catch (e) {
        emit(WeightScreenError(e.toString()
        ));
      }
    } else {
      WeightScreenNoInternet();
    }
  }

  Future<void> updateWeightData(double weightData, num id) async {
    emit(SaveWeightDataLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var json={
          "type": AppConstants.patientWeightLog,
          "weight": weightData,
        };
        var response = await _userRepository.updatePatientLog(json,id);
        if (response.status == Status.COMPLETED) {
          emit(SaveWeightDataSuccess());
        }else {
          emit(WeightScreenError(response.message));
        }
      } catch (e) {
        emit(WeightScreenError(e.toString()
        ));
      }
    } else {
      WeightScreenNoInternet();
    }
  }

}
