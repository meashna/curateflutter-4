import 'package:curate/src/constants/network_check.dart';
import 'package:curate/src/data/manager/preferences_manager.dart';
import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/authenticate/VerifyOtpResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'otp_screen_state.dart';

class OTPScreenCubit extends Cubit<OTPScreenState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _preferences = GetIt.I<PreferencesManager>();
  UIResponse<VerifyOtpResponse>? verifyOtpResponse;
  bool isLoading = false;
  Map<String, dynamic> data;

  OTPScreenCubit({required this.data}) : super(OTPScreenState(isLoading: true));

  Future<void> verifyOTP(String otp, String token) async {
    emit(OTPScreenState(isLoading: true));
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        var response = await _userRepository.verifyOTP(otp, token);
        if (response.status == Status.COMPLETED) {
          verifyOtpResponse = response;
          emit(OTPScreenState(isCompleted: true));
        } else {
          emit(OTPScreenState(
            error: response.message,
            isError: true,
          ));
        }
      } catch (e) {
        emit(OTPScreenState(
          error: e.toString(),
          isError: true,
        ));
      }
    } else {
      emit(OTPScreenState(isNoInternet: true));
    }
  }

  Future<UIResponse<dynamic>> resendOTP(String token) async {
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
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
