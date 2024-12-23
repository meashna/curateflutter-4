
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/response/mood/MoodDetailResponse.dart';

part 'mood_detail_state.dart';

class MoodDetailCubit extends Cubit<MoodDetailState> {



  final _userRepository = GetIt.I<UserRepository>();

  int currentDay=0;
  int currentWeekDay=0;
  int totaldays=0;
  MoodDetailResponse? responseData;

  MoodDetailCubit(this.currentDay,this.totaldays) : super(MoodDetailInitial()){
    currentWeekDay=((currentDay??0) / 7).ceil();

    Future.delayed(Duration(milliseconds: 50),(){
      getMoodData(currentWeekDay);
    });
    //getMoodData(currentWeekDay);
  }


  Future<void> getMoodData(weekCount) async {
    emit(MoodDetailLoading());
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        var response = await _userRepository.getMoodDetails(weekCount);
        if (response.status == Status.COMPLETED) {
          responseData=response.data;
          emit(MoodDetailInitial());
        }else {
          emit(MoodDetailError(
            response.message,
          ));
        }
      } catch (e) {
        emit(MoodDetailError(e.toString()
        ));
      }
    } else {
      emit(MoodDetailnNoInternet());
    }
  }



}
