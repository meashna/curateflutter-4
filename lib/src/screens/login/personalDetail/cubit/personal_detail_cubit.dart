    import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/user_repo/user_repository.dart';

part 'personal_detail_state.dart';

class PersonalDetailCubit extends Cubit<PersonalDetailState> {


  final userRepository = GetIt.I<UserRepository>();
  late PersonalInfo? profileResponse;

  PersonalDetailCubit() : super(PersonalDetailInitial());

  Future<void> getProfileData(String name,String dob,String height,String weight) async {
    emit(PersonalDetailLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await userRepository.saveProfileData(name,dob,height,weight);
        if (response.status == Status.COMPLETED) {
          profileResponse=response.data;
          emit(PersonalDetailSuccess(response.message??""));
        }else {
          emit(PersonalDetailError(
            response.message,
          ));
        }
      } catch (e) {
          emit(PersonalDetailError(e.toString()
        ));
      }
    } else {
      emit(PersonalDetailNoInternet());
    }
  }

}
