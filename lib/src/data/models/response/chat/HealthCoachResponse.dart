import 'HealthCoach.dart';
import 'dart:convert';

/// id : 1
/// userId : 84
/// healthCoachId : 2
/// link : "dnasjkd"
/// createdAt : "2023-05-15T07:24:57.000Z"
/// updatedAt : "2023-05-15T07:24:57.000Z"
/// deletedAt : null
/// healthCoach : {"id":2,"countryCode":"+91","mobile":"9653005599","name":"Ashutosh"}

HealthCoachResponse healthCoachResponseFromJson(String str) => HealthCoachResponse.fromJson(json.decode(str));
String healthCoachResponseToJson(HealthCoachResponse data) => json.encode(data.toJson());
class HealthCoachResponse {
  HealthCoachResponse({
      num? id, 
      num? userId, 
      num? healthCoachId, 
      String? link, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      HealthCoach? healthCoach,}){
    _id = id;
    _userId = userId;
    _healthCoachId = healthCoachId;
    _link = link;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _healthCoach = healthCoach;
}

  HealthCoachResponse.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _healthCoachId = json['healthCoachId'];
    _link = json['link'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    _healthCoach = json['healthCoach'] != null ? HealthCoach.fromJson(json['healthCoach']) : null;
  }
  num? _id;
  num? _userId;
  num? _healthCoachId;
  String? _link;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  HealthCoach? _healthCoach;
HealthCoachResponse copyWith({  num? id,
  num? userId,
  num? healthCoachId,
  String? link,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  HealthCoach? healthCoach,
}) => HealthCoachResponse(  id: id ?? _id,
  userId: userId ?? _userId,
  healthCoachId: healthCoachId ?? _healthCoachId,
  link: link ?? _link,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  healthCoach: healthCoach ?? _healthCoach,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get healthCoachId => _healthCoachId;
  String? get link => _link;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  HealthCoach? get healthCoach => _healthCoach;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['healthCoachId'] = _healthCoachId;
    map['link'] = _link;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_healthCoach != null) {
      map['healthCoach'] = _healthCoach?.toJson();
    }
    return map;
  }

}