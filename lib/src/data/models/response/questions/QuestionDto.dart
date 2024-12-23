import 'package:curate/src/data/models/response/questions/QuestionImageDto.dart';

import 'OptionDto.dart';

/// id : 1
/// code : "Q1"
/// type : 0
/// min : 1
/// max : 1
/// order : 1
/// status : 1
/// createdAt : "2023-04-04T10:45:35.000Z"
/// updatedAt : "2023-04-04T10:45:35.000Z"
/// title : "Have you been diagnosed with PCOS before?"
/// description : "(PCOS is diagonsed by a medical professional on the basis of medical history, ultrasonography test, and or blood tests to measure hormone levels.)"
/// OptionDto : [{"id":1,"score":0,"status":1,"optionTitle":"Yes","optionDescription":null},{"id":2,"score":0,"status":1,"optionTitle":"No","optionDescription":null}]

class QuestionDto {
  QuestionDto({
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
      String? description,
      List<num>? selectedOptions,
      QuestionImageDto? questionImage,
      List<OptionDto>? Options,}){
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
    _selectedOptions=selectedOptions;
    _questionImage = questionImage;
    _Options = Options;
}

  QuestionDto.fromJson(dynamic json) {
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
    if (json['Options'] != null) {
      _Options = [];
      json['Options'].forEach((v) {
        _Options?.add(OptionDto.fromJson(v));
      });
    }
    _questionImage = json['questionImage'] != null ? QuestionImageDto.fromJson(json['questionImage']) : null;

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
  String? _description;
  List<OptionDto>? _Options;
  List<num>? _selectedOptions=[];
  QuestionImageDto? _questionImage;

QuestionDto copyWith({  num? id,
  String? code,
  num? type,
  num? min,
  num? max,
  num? order,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? title,
  String? description,
  List<OptionDto>? Options,
  List<num>? selectedOptions,
  QuestionImageDto? questionImage,
}) => QuestionDto(  id: id ?? _id,
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
  Options: Options ?? _Options,
  selectedOptions: selectedOptions ?? _selectedOptions,
  questionImage: questionImage ?? _questionImage,
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
  String? get description => _description;
  List<OptionDto>? get Options => _Options;
  List<num>? get selectedOptions => _selectedOptions;
  QuestionImageDto? get questionImage => _questionImage;


  set selectedOptions(List<num>? value) {
    _selectedOptions = value;
  }

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
    map['questionImage'] = _questionImage;
    if (_Options!= null) {
      map['OptionDto'] = _Options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}