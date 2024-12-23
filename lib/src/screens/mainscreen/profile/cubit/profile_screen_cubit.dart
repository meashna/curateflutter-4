import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/models/response/profile/HabitLog.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/models/response/questions/WeeklyAssessmentScore.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/WellBeingMessage.dart';
import '../../../../data/models/response/profile/MyProfileDto.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final _userRepository = GetIt.I<UserRepository>();
  MyProfileDto? profileResponse;
  PersonalInfo? personalInfo;
  List<HealthLogData>? healthLog;
  HabitLog? habitLog;
  List<WeeklyAssessmentScore>? assessmentHistory = [];
  List<String> weeks = [];
  List<FlSpot> flSpots = [];
  bool? isTaskSubmitted;
  WellBeingMessage? wellBeingMessage;

  ProfileScreenCubit() : super(ProfileScreenLoading()) {
    emit(ProfileScreenLoading());
    getProfileData();
  }

  Future<void> getProfileData() async {
    //emit(ProfileScreenLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getProfileData();
        if (response.status == Status.COMPLETED) {
          profileResponse = response.data;
          personalInfo = profileResponse?.personalInfo;
          healthLog = profileResponse?.healthLog;
          habitLog = profileResponse?.habitLog;
          isTaskSubmitted = profileResponse?.isTaskSubmitted;
          wellBeingMessage = profileResponse?.wellBeingMessage;
          assessmentHistory = profileResponse?.assessmentHistory ?? [];
          if ((assessmentHistory?.length ?? 0) < 5) {
            int temp = 0;
            if ((assessmentHistory?.length ?? 0) == 0) {
              temp = 0;
              for (int i = temp; i < 5; i++) {
                assessmentHistory?.add(
                    WeeklyAssessmentScore(week: i + 1, percentIncrement: null));
              }
            } else {
              temp = (assessmentHistory?.length ?? 0) - 1;
              for (int i = temp; i < 5; i++) {
                assessmentHistory?.add(WeeklyAssessmentScore(
                    week: (assessmentHistory?[i].week ?? 0) + 1,
                    percentIncrement: null));
              }
            }
          }
          weeks.clear();
          assessmentHistory?.forEach((element) {
            weeks.add("W${element.week ?? 1}");
          });
          flSpots.clear();
          for (int i = 0; i < (assessmentHistory?.length ?? 0); i++) {
            if (assessmentHistory?[i].percentIncrement != null) {
              flSpots.add(FlSpot(i.toDouble(),
                  (assessmentHistory?[i].percentIncrement ?? 0).toDouble()));
            }
          }

          emit(ProfileScreenSuccess());
        } else {
          emit(ProfileScreenError(response.message));
        }
      } catch (e) {
        emit(ProfileScreenError(e.toString()));
      }
    } else {
      emit(ProfileScreenNoInternet());
    }
  }
}
