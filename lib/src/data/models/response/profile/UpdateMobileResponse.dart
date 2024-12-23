import 'package:curate/src/data/models/PhoneNoDto.dart';
import 'dart:convert';

/// message : "successfully"
/// user : {"id":84,"countryCode":"+91","mobile":"5454545401"}

UpdateMobileResponse updateMobileResponseFromJson(String str) =>
    UpdateMobileResponse.fromJson(json.decode(str));

String updateMobileResponseToJson(UpdateMobileResponse data) =>
    json.encode(data.toJson());

class UpdateMobileResponse {
  UpdateMobileResponse({
    String? message,
    PhoneNoDto? user,
  }) {
    _message = message;
    _user = user;
  }

  UpdateMobileResponse.fromJson(dynamic json) {
    _message = json['message'];
    _user = json['user'] != null ? PhoneNoDto.fromJson(json['user']) : null;
  }

  String? _message;
  PhoneNoDto? _user;

  UpdateMobileResponse copyWith({
    String? message,
    PhoneNoDto? user,
  }) =>
      UpdateMobileResponse(
        message: message ?? _message,
        user: user ?? _user,
      );

  String? get message => _message;

  PhoneNoDto? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
