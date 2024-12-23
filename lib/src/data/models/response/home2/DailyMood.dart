import 'Options.dart';
import 'dart:convert';

/// id : 10
/// code : "Q10"
/// type : 1
/// min : 1
/// max : 1
/// order : 1
/// status : 1
/// createdAt : "2023-04-26T13:01:44.000Z"
/// updatedAt : "2023-04-26T13:01:44.000Z"
/// title : "How are you feeling today?"
/// description : null
/// options : [{"id":40,"score":4,"status":1,"optionTitle":"Joyful","optionDescription":null},{"id":41,"score":3,"status":1,"optionTitle":"Happy","optionDescription":null},{"id":42,"score":2,"status":1,"optionTitle":"Normal","optionDescription":null},{"id":43,"score":1,"status":1,"optionTitle":"Upset","optionDescription":null},{"id":44,"score":0,"status":1,"optionTitle":"sad","optionDescription":null}]

DailyMood dailyMoodFromJson(String str) => DailyMood.fromJson(json.decode(str));
String dailyMoodToJson(DailyMood data) => json.encode(data.toJson());
class DailyMood {
  DailyMood({
      num? id, 
      String? code, 
      num? type, 
      num? min, 
      num? max, 
      num? order, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? title, 
      dynamic description, 
      List<Options>? options,}){
    _id = id;
    _code = code;
    _type = type;
    _min = min;
    _max = max;
    _order = order;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _title = title;
    _description = description;
    _options = options;
}

  DailyMood.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _type = json['type'];
    _min = json['min'];
    _max = json['max'];
    _order = json['order'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _title = json['title'];
    _description = json['description'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  num? _id;
  String? _code;
  num? _type;
  num? _min;
  num? _max;
  num? _order;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _title;
  dynamic _description;
  List<Options>? _options;
DailyMood copyWith({  num? id,
  String? code,
  num? type,
  num? min,
  num? max,
  num? order,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? title,
  dynamic description,
  List<Options>? options,
}) => DailyMood(  id: id ?? _id,
  code: code ?? _code,
  type: type ?? _type,
  min: min ?? _min,
  max: max ?? _max,
  order: order ?? _order,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  title: title ?? _title,
  description: description ?? _description,
  options: options ?? _options,
);
  num? get id => _id;
  String? get code => _code;
  num? get type => _type;
  num? get min => _min;
  num? get max => _max;
  num? get order => _order;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get title => _title;
  dynamic get description => _description;
  List<Options>? get options => _options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['type'] = _type;
    map['min'] = _min;
    map['max'] = _max;
    map['order'] = _order;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['title'] = _title;
    map['description'] = _description;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}