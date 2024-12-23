import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/profile/MyProfileDto.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final _userRepository = GetIt.I<UserRepository>();
  PersonalInfo? profileData;
  final _preferences = GetIt.I<PreferencesManager>();

  EditProfileCubit() : super(EditProfileInitial()) {
    //getProfileData();.
    getPersonalData();
  }

  /* Future<void> getProfileData() async {
    Future.delayed(Duration(milliseconds: 100),(){emit(EditProfileLoading());});
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getProfileData();
        if (response.status == Status.COMPLETED) {
         // profileData=response.data;
          emit(EditProfileSuccess());
        }else {
          emit(EditProfileError(response.message));
        }
      } catch (e) {
        emit(EditProfileError(e.toString()
        ));
      }
    } else {
      Future.delayed(Duration(milliseconds: 100),(){emit(EditProfileNoInternet());});
    }
  }*/

  Future<void> getPersonalData() async {
    profileData = await _preferences.getUserProfile();
    emit(EditProfileSuccess());
  }
}
