import 'dart:convert';

import 'package:curate/src/data/models/LanguageResponse.dart';

import 'AttachmentResponse.dart';
/// firstName : "vishal"
/// lastName : "Mahajan"
/// title : "Mr"
/// attachment : {"id":68,"path":"resources/attachments/2022/10/25/079544d0-6cca-11ed-8a56-f3ad937d1f8d.jpg","size":181,"inUse":0,"userId":10,"mimeType":"image/jpeg","createdAt":"2022-11-25T14:04:08.583Z","extension":".jpg","updatedAt":"2022-11-25T14:04:08.583Z","uniqueName":"079544d0-6cca-11ed-8a56-f3ad937d1f8d.jpg","originalName":"scaled_image_picker5979746159739403302.jpg"}
/// dob : null
/// gender : 1
/// languages : [{"id":2,"code":"ar","countery":"Saudi Arab","counteryCode":"sa","name":"Arabic"}]

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());
class UserProfile {
  UserProfile({
    String? firstName,
    String? lastName,
    String? title,
    AttachmentResponse? attachment,
    dynamic dob,
    num? gender,
    List<Languages>? languages,}){
    _firstName = firstName;
    _lastName = lastName;
    _title = title;
    _attachment = attachment;
    _dob = dob;
    _gender = gender;
    _languages = languages;
  }

  UserProfile.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _title = json['title'];
    _attachment = json['attachment'] != null ? AttachmentResponse.fromJson(json['attachment']) : null;
    _dob = json['dob'];
    _gender = json['gender'];
    if (json['languages'] != null) {
      _languages = [];
      json['languages'].forEach((v) {
        _languages?.add(Languages.fromJson(v));
      });
    }
  }
  String? _firstName;
  String? _lastName;
  String? _title;
  AttachmentResponse? _attachment;
  dynamic _dob;
  num? _gender;
  List<Languages>? _languages;
  UserProfile copyWith({  String? firstName,
    String? lastName,
    String? title,
    AttachmentResponse? attachment,
    dynamic dob,
    num? gender,
    List<Languages>? languages,
  }) => UserProfile(  firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    title: title ?? _title,
    attachment: attachment ?? _attachment,
    dob: dob ?? _dob,
    gender: gender ?? _gender,
    languages: languages ?? _languages,
  );
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get title => _title;
  AttachmentResponse? get attachment => _attachment;
  dynamic get dob => _dob;
  num? get gender => _gender;
  List<Languages>? get languages => _languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['title'] = _title;
    if (_attachment != null) {
      map['attachment'] = _attachment?.toJson();
    }
    map['dob'] = _dob;
    map['gender'] = _gender;
    if (_languages != null) {
      map['languages'] = _languages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}