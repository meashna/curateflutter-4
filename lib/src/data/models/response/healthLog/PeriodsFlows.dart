import 'dart:convert';

/// id : 1
/// order : 1
/// status : 1
/// createdAt : "2023-05-22T07:28:50.000Z"
/// updatedAt : "2023-05-22T07:28:50.000Z"
/// title : "Very less"

PeriodsFlows periodsFlowsFromJson(String str) => PeriodsFlows.fromJson(json.decode(str));
String periodsFlowsToJson(PeriodsFlows data) => json.encode(data.toJson());
class PeriodsFlows {
  PeriodsFlows({
      num? id, 
      num? order, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? title,}){
    _id = id;
    _order = order;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _title = title;
}

  PeriodsFlows.fromJson(dynamic json) {
    _id = json['id'];
    _order = json['order'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _title = json['title'];
  }
  num? _id;
  num? _order;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _title;
PeriodsFlows copyWith({  num? id,
  num? order,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? title,
}) => PeriodsFlows(  id: id ?? _id,
  order: order ?? _order,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  title: title ?? _title,
);
  num? get id => _id;
  num? get order => _order;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order'] = _order;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['title'] = _title;
    return map;
  }

}