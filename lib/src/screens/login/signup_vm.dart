import 'package:curate/src/data/models/apis/UIResponse.dart';
import 'package:curate/src/data/models/response/authenticate/VerifyOtpResponse.dart';
import 'package:curate/src/data/repository/user_repo/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupVM extends ChangeNotifier {
  SignupVM();

  UIResponse<VerifyOtpResponse>? verifyOtpResponse;
  UIResponse<VerifyOtpResponse>? resendResponse;

  final _myRepo = UserRepositoryImpl();

/*  Future<void> verifyOTP(String otp,String token) async {
    _setVerifyOTP(UIResponse.loading());
    _myRepo.verifyOTP(otp,token)
        .then((value) => _setVerifyOTP(value))
        .onError((error, stackTrace) => _setVerifyOTP(UIResponse.error(error.toString())));
  }

  void _setVerifyOTP(UIResponse<VerifyOtpResponse> response) {
    verifyOtpResponse = response;
    notifyListeners();
  }*/

  Future<UIResponse<void>> resendOTP(String token) async {
    return _myRepo
        .resendOtp(token)
        .then((value) => (value))
        .onError((error, stackTrace) => UIResponse.error(error.toString()));
  }
}
