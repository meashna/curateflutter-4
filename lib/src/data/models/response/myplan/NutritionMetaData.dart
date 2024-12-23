import 'dart:convert';

/// key : "Glyceimic Load"
/// title : "Variant 1"
/// value : 130
/// points : ["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]

NutritionMetaData nutritionMetaDataFromJson(String str) =>
    NutritionMetaData.fromJson(json.decode(str));

String nutritionMetaDataToJson(NutritionMetaData data) =>
    json.encode(data.toJson());

class NutritionMetaData {
  NutritionMetaData({
    String? key,
    String? title,
    dynamic value,
    List<String>? points,
  }) {
    _key = key;
    _title = title;
    _value = value;
    _points = points;
  }

  NutritionMetaData.fromJson(dynamic json) {
    _key = json['key'];
    _title = json['title'];
    _value = json['value'];
    _points = json['points'] != null ? json['points'].cast<String>() : [];
  }

  String? _key;
  String? _title;
  dynamic _value;
  List<String>? _points;

  NutritionMetaData copyWith({
    String? key,
    String? title,
    dynamic value,
    List<String>? points,
  }) =>
      NutritionMetaData(
        key: key ?? _key,
        title: title ?? _title,
        value: value ?? _value,
        points: points ?? _points,
      );

  String? get key => _key;

  String? get title => _title;

  dynamic get value => _value;

  List<String>? get points => _points;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['title'] = _title;
    map['value'] = _value;
    map['points'] = _points;
    return map;
  }
}
