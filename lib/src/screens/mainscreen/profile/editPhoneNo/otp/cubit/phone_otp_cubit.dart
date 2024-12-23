import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/authenticate/VerifyOtpResponse.dart';
import 'package:curate/src/data/models/response/profile/UpdateMobileResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'phone_otp_state.dart';

class PhoneOTPCubit extends Cubit<OTPPhoneState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _preferences = GetIt.I<PreferencesManager>();
  UIResponse<UpdateMobileResponse>? verifyOtpResponse;
  bool isLoading = false;
  Map<String, dynamic> data;

  PhoneOTPCubit({required this.data}) : super(OTPPhoneInitial());

  Future<void> verifyOTP(String otp, String token) async {
    emit(OTPPhoneLoading());
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.verifyUpdatePhone(otp, token);
        if (response.status == Status.COMPLETED) {
          verifyOtpResponse = response;
          emit(OTPPhoneSuccess());
        } else {
          emit(OTPPhoneError(
            response.message,
          ));
        }
      } catch (e) {
        emit(OTPPhoneError(e.toString()));
      }
    } else {
      emit(OTPPhoneNoInternet());
    }
  }

  Future<UIResponse<dynamic>> resendOTP(String token) async {
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.resendOtp(token);
        if (response.status == Status.COMPLETED) {
          return response;
          // emit(OTPScreenState(isDataLoaded: true));
        } else {
          return UIResponse.error("Not completed");
        }
      } catch (e) {
        return UIResponse.error(e.toString());
      }
    } else {
      return UIResponse.error("No Internet");
    }
  }
}
