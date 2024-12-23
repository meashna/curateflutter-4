import 'package:bloc/bloc.dart';
import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/authenticate/SignUpResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {


  final _userRepository = GetIt.I<UserRepository>();
  String countryCode="";
  String countryName="";
  String code="";
  String phoneNo="";
  late SignUpResponse? signUpResponse;
/*CountryCode(name: "India", code: "IN", dialCode: "+91");*/
  SignInCubit() : super(SignInInitial());


  Future<void> signInApi() async {
    emit(SignInLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.signUp(countryCode, countryName, code, phoneNo);
        if (response.status == Status.COMPLETED) {
          signUpResponse=response.data;
          emit(SignInSuccess(response.message??""));
        }else {
          emit(SignInError(
            response.message,
          ));
        }
      } catch (e) {
        emit(SignInError(e.toString()
        ));
      }
    } else {
      emit(SignInNoInternet());
    }
  }

}
