import 'dart:convert';

/// id : 49
/// orderId : null
/// userId : 48
/// week : 1
/// score : 15
/// percentIncrement : 81
/// status : 1
/// createdAt : "2023-05-24T08:29:36.000Z"
/// updatedAt : "2023-05-24T08:29:36.000Z"
/// deletedAt : null

AssessmentHistory assessmentHistoryFromJson(String str) => AssessmentHistory.fromJson(json.decode(str));
String assessmentHistoryToJson(AssessmentHistory data) => json.encode(data.toJson());
class AssessmentHistory {
  AssessmentHistory({
      num? id, 
      dynamic orderId, 
      num? userId, 
      num? week, 
      num? score, 
      num? percentIncrement, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _orderId = orderId;
    _userId = userId;
    _week = week;
    _score = score;
    _percentIncrement = percentIncrement;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  AssessmentHistory.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _userId = json['userId'];
    _week = json['week'];
    _score = json['score'];
    _percentIncrement = json['percentIncrement'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  dynamic _orderId;
  num? _userId;
  num? _week;
  num? _score;
  num? _percentIncrement;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
AssessmentHistory copyWith({  num? id,
  dynamic orderId,
  num? userId,
  num? week,
  num? score,
  num? percentIncrement,
  num? status,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => AssessmentHistory(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  userId: userId ?? _userId,
  week: week ?? _week,
  score: score ?? _score,
  percentIncrement: percentIncrement ?? _percentIncrement,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  dynamic get orderId => _orderId;
  num? get userId => _userId;
  num? get week => _week;
  num? get score => _score;
  num? get percentIncrement => _percentIncrement;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderId'] = _orderId;
    map['userId'] = _userId;
    map['week'] = _week;
    map['score'] = _score;
    map['percentIncrement'] = _percentIncrement;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}