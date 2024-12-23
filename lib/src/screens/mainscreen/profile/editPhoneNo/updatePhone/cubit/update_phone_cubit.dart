import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/authenticate/SignUpResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'update_phone_state.dart';

class UpdatePhoneCubit extends Cubit<UpdatePhoneState> {


  final _userRepository = GetIt.I<UserRepository>();
  String countryCode="";
  String countryName="";
  String code="";
  String phoneNo="";
  late SignUpResponse? signUpResponse;

  UpdatePhoneCubit() : super(UpdatePhoneInitial());


  Future<void> signInApi() async {
    emit(UpdatePhoneLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.updateMobile(countryCode, countryName, code, phoneNo);
        if (response.status == Status.COMPLETED) {
          signUpResponse=response.data;
          emit(UpdatePhoneSuccess(response.message??""));
        }else {
          emit(UpdatePhoneError(
            response.message,
          ));
        }
      } catch (e) {
        emit(UpdatePhoneError(e.toString()
        ));
      }
    } else {
      emit(UpdatePhoneNoInternet());
    }
  }

}
