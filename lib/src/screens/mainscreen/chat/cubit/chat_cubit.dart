import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/chat/HealthCoachResponse.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {

  final _userRepository = GetIt.I<UserRepository>();
  final _preferences = GetIt.I<PreferencesManager>();
  HealthCoachResponse? healthData;
  PersonalInfo? profileData;

  ChatCubit() : super(ChatLoading()){
   // Future.delayed(Duration(milliseconds: 100),(){emit(ChatLoading());});
    getData();
  }

  getData() async {
   /* profileData = await _preferences.getUserProfile();
    if(profileData !=null && profileData!.product != null){
      isPlanPurchased = ((profileData?.purchaseCount??0)!=0);
    }*/

    getHealthCoach();
   /* if(isPlanPurchased){

    }
    else{
      emit(ChatSuccess());
    }*/


  }

  Future<void> getHealthCoach() async {
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getHealthCoachData();
        if (response.status == Status.COMPLETED) {
          healthData=response.data;
          emit(ChatSuccess());
        }else {
          emit(ChatError(response.message));
        }
      } catch (e) {
        emit(ChatError(e.toString()
        ));
      }
    } else {
      Future.delayed(const Duration(milliseconds: 100),(){emit(ChatNoInternet());});
    }
  }
}
