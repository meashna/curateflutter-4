import 'package:curate/src/data/models/response/healthLog/PeriodsFlows.dart';
import 'dart:convert';

/// id : 4
/// code : "hl-4"
/// userId : 53
/// type : "1"
/// periodCycleFrom : "2023-01-02T12:18:55.000Z"
/// periodCycleTo : "2023-05-02T12:18:55.000Z"
/// periodFlowId : 1
/// weight : null
/// waist : null
/// status : 1
/// createdAt : "2023-05-22T12:11:39.000Z"
/// updatedAt : "2023-05-22T12:11:39.000Z"
/// deletedAt : null
/// periodFlow : {"id":1,"order":1,"status":1,"title":"Very less"}

HealthLogData dataFromJson(String str) => HealthLogData.fromJson(json.decode(str));
String dataToJson(HealthLogData data) => json.encode(data.toJson());

class HealthLogData {
  HealthLogData({
      num? id, 
      String? code, 
      num? userId, 
      String? type, 
      String? periodCycleFrom, 
      String? periodCycleTo, 
      num? periodFlowId, 
      dynamic weight, 
      dynamic waist, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      PeriodsFlows? periodFlow,}){
    _id = id;
    _code = code;
    _userId = userId;
    _type = type;
    _periodCycleFrom = periodCycleFrom;
    _periodCycleTo = periodCycleTo;
    _periodFlowId = periodFlowId;
    _weight = weight;
    _waist = waist;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _periodFlow = periodFlow;
}

  HealthLogData.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _userId = json['userId'];
    _type = json['type'];
    _periodCycleFrom = json['periodCycleFrom'];
    _periodCycleTo = json['periodCycleTo'];
    _periodFlowId = json['periodFlowId'];
    _weight = json['weight'];
    _waist = json['waist'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    _periodFlow = json['periodFlow'] != null ? PeriodsFlows.fromJson(json['periodFlow']) : null;
  }
  num? _id;
  String? _code;
  num? _userId;
  String? _type;
  String? _periodCycleFrom;
  String? _periodCycleTo;
  num? _periodFlowId;
  dynamic _weight;
  dynamic _waist;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  PeriodsFlows? _periodFlow;
HealthLogData copyWith({  num? id,
  String? code,
  num? userId,
  String? type,
  String? periodCycleFrom,
  String? periodCycleTo,
  num? periodFlowId,
  dynamic weight,
  dynamic waist,
  num? status,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  PeriodsFlows? periodFlow,
}) => HealthLogData(  id: id ?? _id,
  code: code ?? _code,
  userId: userId ?? _userId,
  type: type ?? _type,
  periodCycleFrom: periodCycleFrom ?? _periodCycleFrom,
  periodCycleTo: periodCycleTo ?? _periodCycleTo,
  periodFlowId: periodFlowId ?? _periodFlowId,
  weight: weight ?? _weight,
  waist: waist ?? _waist,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  periodFlow: periodFlow ?? _periodFlow,
);
  num? get id => _id;
  String? get code => _code;
  num? get userId => _userId;
  String? get type => _type;
  String? get periodCycleFrom => _periodCycleFrom;
  String? get periodCycleTo => _periodCycleTo;
  num? get periodFlowId => _periodFlowId;
  dynamic get weight => _weight;
  dynamic get waist => _waist;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  PeriodsFlows? get periodFlow => _periodFlow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['userId'] = _userId;
    map['type'] = _type;
    map['periodCycleFrom'] = _periodCycleFrom;
    map['periodCycleTo'] = _periodCycleTo;
    map['periodFlowId'] = _periodFlowId;
    map['weight'] = _weight;
    map['waist'] = _waist;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    if (_periodFlow != null) {
      map['periodFlow'] = _periodFlow?.toJson();
    }
    return map;
  }

}