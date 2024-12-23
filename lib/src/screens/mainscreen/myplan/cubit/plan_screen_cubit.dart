import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/myplan/PlanResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/manager/preferences_manager.dart';
import '../../../../data/models/response/home2/Data.dart';
import '../../../../data/models/response/profile/PersonalInfo.dart';

part 'plan_screen_state.dart';

class PlanScreenCubit extends Cubit<PlanScreenState> {

  final _userRepository = GetIt.I<UserRepository>();
  final _preferences = GetIt.I<PreferencesManager>();

  UIResponse<PlanResponse>? planResponse;
  List<Data?>? dayList;
  int totalWeek=0;
  int currentWeek = 0;
  int? currentDay=0;
  int startWeek=1;
  int endWeek=1;
  int dataFetchofWeeks=1;
  PersonalInfo? profileData;
  bool isPlanPurchased = false;
  List<List<Data?>> weeksList=[];

  PlanScreenCubit() : super(PlanSkeletonLoading(true)){
    getData();
  }

  Future<PersonalInfo?> getProfileData() async {
    return await _preferences.getUserProfile() ;
  }

  getData() async {
    profileData = await getProfileData();
    if(profileData !=null && profileData!.product != null){
        isPlanPurchased = ((profileData?.purchaseCount??0)!=0);
    }
    getPlanData(null);
  }

  Future<void> getPlanData(int? selectedWeek) async {

    print("Current Week");
    print(currentWeek);
    if(selectedWeek != null  && endWeek != 1 && selectedWeek>=startWeek && selectedWeek<=endWeek){
        currentWeek=selectedWeek;
        if((currentWeek -startWeek)<=(weeksList.length-1)) {
          dayList = weeksList[(currentWeek - startWeek)];
        }
        else{
          dayList=[];
        }

        emit(PlanScreenInitial());
    }
    else if(selectedWeek!=null && selectedWeek > endWeek){
      int tempWeek=((planResponse?.data?.currDay ?? 0) / 7).ceil();
      currentWeek=selectedWeek;
      if(selectedWeek<=tempWeek){
        dayList=[];
        emit(PlanScreenInitial());
      }
      else{
          emit(PlanScreenLock());
      }
    }
    else {
      //we used t this temp because we can maintain the state of selected tab. Tab's selection working on the basis of  current week

      Future.delayed(const Duration(milliseconds: 50), () async {
        if(selectedWeek==null){
          emit(PlanSkeletonLoading(true));
        }
        else{
          emit(PlanSkeletonLoading(false));
        }

        var checkNetwork = await NetworkCheck.check();
        if (checkNetwork) {
          try {
            var response = await _userRepository.getPlanData(selectedWeek);
            if (response.status == Status.COMPLETED) {
              print("Current Week");
              print(currentWeek);
              planResponse = response;
              if(selectedWeek==null) {
                currentWeek = ((planResponse?.data?.currDay ?? 0) / 7).ceil();
                selectedWeek=currentWeek;
                print("Current Week");
                print(currentWeek);
                totalWeek = ((planResponse?.data?.planDays ?? 0) / 7).ceil();
                currentDay = (planResponse?.data?.currDay ?? 0).toInt();

              }

              if ((planResponse?.data?.data?.length ?? 0) > 7) {
                startWeek =
                    ((planResponse?.data?.data?.first.day ?? 0).toInt() / 7)
                        .ceil();
                endWeek =
                    ((planResponse?.data?.data?.last.day ?? 0).toInt() / 7)
                        .ceil();

                dataFetchofWeeks=((planResponse?.data?.data?.length ?? 0)/7).ceil();
                int index = 0;

                for (int i = 0; i < dataFetchofWeeks; i++) {
                  List<Data?> tempDays = [];
                  for (int j = 0; j < 7; j++) {

                    if (((planResponse?.data?.data?.length??0)-1)>=index && planResponse?.data?.data?[index] != null) {
                      tempDays.insert(j, planResponse?.data?.data?[index]);
                      index++;
                    }
                  }
                  weeksList.add(tempDays);
                }
                if((currentWeek - startWeek)<weeksList.length) {
                  dayList = weeksList[(currentWeek - startWeek)];
                }
                else{
                  dayList=[];
                }
              }
              else{

                currentWeek=selectedWeek??1;
                dayList=planResponse?.data?.data;
              }

              emit(PlanScreenInitial());
            }
            else {
              emit(PlanScreenError(
                response.message,
              ));
            }
          } catch (e) {
            emit(PlanScreenError(e.toString()
            ));
          }
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            emit(PlanScreenNoInternet());
          });
        }
      });

    }
  }

  void refreshData(){
    emit(PlanScreenInitial());
  }



}
