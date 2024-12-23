import 'Option.dart';
import 'Moods.dart';
import 'dart:convert';

/// option : {"id":42,"score":2,"optionTitle":"Normal","optionDescription":"Slow progress is better than no progress stay positive and never give up."}
/// week : 1
/// moods : [{"id":35,"day":1,"optionId":41,"userId":2,"createdAt":"2023-04-28T06:19:01.000Z","score":3},{"id":19,"day":2,"optionId":42,"userId":2,"createdAt":"2023-04-29T06:19:01.000Z","score":2},{"id":36,"day":3,"optionId":40,"userId":2,"createdAt":"2023-04-30T06:19:01.000Z","score":4},{"id":37,"day":4,"optionId":40,"userId":2,"createdAt":"2023-05-01T06:19:01.000Z","score":4},{"id":38,"day":5,"optionId":42,"userId":2,"createdAt":"2023-05-02T08:54:08.000Z","score":2},{"id":39,"day":6,"optionId":42,"userId":2,"createdAt":"2023-05-03T05:35:08.000Z","score":2}]

MoodDetailResponse moodDetailResponseFromJson(String str) => MoodDetailResponse.fromJson(json.decode(str));
String moodDetailResponseToJson(MoodDetailResponse data) => json.encode(data.toJson());
class MoodDetailResponse {
  MoodDetailResponse({
      Option? option, 
      num? week, 
      List<Moods>? moods,}){
    _option = option;
    _week = week;
    _moods = moods;
}

  MoodDetailResponse.fromJson(dynamic json) {
    _option = json['option'] != null ? Option.fromJson(json['option']) : null;
    _week = json['week'];
    if (json['moods'] != null) {
      _moods = [];
      json['moods'].forEach((v) {
        _moods?.add(Moods.fromJson(v));
      });
    }
  }
  Option? _option;
  num? _week;
  List<Moods>? _moods;
MoodDetailResponse copyWith({  Option? option,
  num? week,
  List<Moods>? moods,
}) => MoodDetailResponse(  option: option ?? _option,
  week: week ?? _week,
  moods: moods ?? _moods,
);
  Option? get option => _option;
  num? get week => _week;
  List<Moods>? get moods => _moods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_option != null) {
      map['option'] = _option?.toJson();
    }
    map['week'] = _week;
    if (_moods != null) {
      map['moods'] = _moods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}