import 'dart:convert';
/// id : 1
/// androidSoft : "1.2.0"
/// androidCritical : "1.0.0"
/// iosSoft : "3.0.0"
/// iosCritical : "2.0.1"
/// createdAt : "2023-05-05T13:38:34.000Z"
/// updatedAt : "2023-05-05T13:38:34.000Z"
/// deletedAt : null

AppVersionResponse appVersionResponseFromJson(String str) => AppVersionResponse.fromJson(json.decode(str));
String appVersionResponseToJson(AppVersionResponse data) => json.encode(data.toJson());
class AppVersionResponse {
  AppVersionResponse({
      num? id, 
      String? androidSoft, 
      String? androidCritical, 
      String? iosSoft, 
      String? iosCritical, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _androidSoft = androidSoft;
    _androidCritical = androidCritical;
    _iosSoft = iosSoft;
    _iosCritical = iosCritical;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  AppVersionResponse.fromJson(dynamic json) {
    _id = json['id'];
    _androidSoft = json['androidSoft'];
    _androidCritical = json['androidCritical'];
    _iosSoft = json['iosSoft'];
    _iosCritical = json['iosCritical'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  String? _androidSoft;
  String? _androidCritical;
  String? _iosSoft;
  String? _iosCritical;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
AppVersionResponse copyWith({  num? id,
  String? androidSoft,
  String? androidCritical,
  String? iosSoft,
  String? iosCritical,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => AppVersionResponse(  id: id ?? _id,
  androidSoft: androidSoft ?? _androidSoft,
  androidCritical: androidCritical ?? _androidCritical,
  iosSoft: iosSoft ?? _iosSoft,
  iosCritical: iosCritical ?? _iosCritical,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  String? get androidSoft => _androidSoft;
  String? get androidCritical => _androidCritical;
  String? get iosSoft => _iosSoft;
  String? get iosCritical => _iosCritical;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['androidSoft'] = _androidSoft;
    map['androidCritical'] = _androidCritical;
    map['iosSoft'] = _iosSoft;
    map['iosCritical'] = _iosCritical;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}