import 'dart:convert';

import 'package:curate/src/data/models/LanguageResponse.dart';

import 'user_profile_model.dart';

/// id : 10
/// email : "vishal.m@illuminz.com"
/// UserProfile : {"id":10,"userId":10,"isSingpassProfile":null,"firstName":"bsbssbbz","lastName":"bsbsbshb","title":"Mr","attachment":null,"dob":null,"gender":null,"createdBy":10,"reason":null,"about":null,"vita":null,"video":null,"lastUpdatedBy":10,"createdAt":"2022-11-22T12:16:22.000Z","updatedAt":"2022-11-22T12:16:22.000Z","deletedAt":null}
/// languages : [1,2,3]

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));
String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  GetProfileResponse({
    num? id,
    String? email,
    UserProfile? userProfile,
    List<Languages>? languages,
  }) {
    _id = id;
    _email = email;
    _userProfile = userProfile;
    _languages = languages;
  }

  GetProfileResponse.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _userProfile = json['UserProfile'] != null
        ? UserProfile.fromJson(json['UserProfile'])
        : null;
    if (json['languages'] != null) {
      _languages = [];
      json['languages'].forEach((v) {
        _languages?.add(Languages.fromJson(v));
      });
    }
    //_languages = json['languages'] != null ? json['languages'].cast<num>() : [];
  }
  num? _id;
  String? _email;
  UserProfile? _userProfile;
  List<Languages>? _languages;
  GetProfileResponse copyWith({
    num? id,
    String? email,
    UserProfile? userProfile,
    List<Languages>? languages,
  }) =>
      GetProfileResponse(
        id: id ?? _id,
        email: email ?? _email,
        userProfile: userProfile ?? _userProfile,
        languages: languages ?? _languages,
      );
  num? get id => _id;
  String? get email => _email;
  UserProfile? get userProfile => _userProfile;
  List<Languages>? get languages => _languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    if (_userProfile != null) {
      map['UserProfile'] = _userProfile?.toJson();
    }
    if (_languages != null) {
      map['languages'] = _languages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
