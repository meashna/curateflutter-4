

import 'package:curate/src/data/models/response/profile/PersonalInfo.dart';

class ProfileDto {
  ProfileDto({
      this.token, 
      this.refreshToken, 
      this.profile,});

  ProfileDto.fromJson(dynamic json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    profile = json['profile'] != null ? PersonalInfo.fromJson(json['profile']) : null;
  }
  String? token;
  String? refreshToken;
  PersonalInfo? profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    return map;
  }

}