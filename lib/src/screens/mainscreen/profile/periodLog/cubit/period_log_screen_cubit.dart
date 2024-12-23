import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'period_log_screen_state.dart';

class PeriodLogScreenCubit extends Cubit<PeriodLogScreenState> {
  final _userRepository = GetIt.I<UserRepository>();
  List<HealthLogData> periodData = [];
  int pageNumber = 1;
  bool isLastPage = false;
  bool isRefresh = false;
  bool isLoading = false;

  PeriodLogScreenCubit() : super(PeriodLogScreenInitial()) {
    emit(PeriodLogScreenLoading());
    getPeriodData();
  }

  Future<void> getPeriodData({bool isRefresh = false}) async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        this.isRefresh = isRefresh;
        if (isRefresh) {
          pageNumber = 1;
          isLastPage = false;
        }
        Map<String, dynamic> map = {
          "type": AppConstants.patientPeriodLog,
          "perPage": 10,
          "page": pageNumber
        };
        var response = await _userRepository.getPatientLog(map);
        if (response.status == Status.COMPLETED) {
          periodData = response.data?.data ?? [];
          if (pageNumber < (response.data!.totalPage ?? 0)) {
            pageNumber++;
          } else {
            isLastPage = true;
          }
          emit(PeriodLogScreenSuccess());
          //emit(WeightScreenError("Kuch bhi"));
        } else {
          emit(PeriodLogScreenError(response.message));
        }
      } catch (e) {
        emit(PeriodLogScreenError(e.toString()));
      }
    } else {
      emit(PeriodLogScreenNoInternet());
    }
    isLoading = false;
  }

  String? getNumberOfDays(HealthLogData periodData) {
    return null;
  }
}
