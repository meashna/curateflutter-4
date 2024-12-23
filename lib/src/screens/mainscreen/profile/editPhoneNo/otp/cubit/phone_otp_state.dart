
import 'package:flutter/material.dart';

@immutable
abstract class OTPPhoneState {}

class OTPPhoneInitial extends OTPPhoneState {

}

class OTPPhoneLoading extends OTPPhoneState {
}

class OTPPhoneSuccess extends OTPPhoneState {

}

class OTPPhoneError extends OTPPhoneState {
  String? errorMessage;
  OTPPhoneError(this.errorMessage);
}

class OTPPhoneNoInternet extends OTPPhoneState {}

class OTPPhoneEmpty extends OTPPhoneState {}