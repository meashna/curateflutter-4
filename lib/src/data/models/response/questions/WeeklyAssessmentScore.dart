import 'dart:convert';

/// id : 2
/// orderId : null
/// userId : 1
/// week : 6
/// score : 3
/// percentIncrement : 1
/// status : 1
/// createdAt : "2023-05-11T07:07:05.000Z"
/// updatedAt : "2023-05-11T07:07:05.000Z"
/// deletedAt : null

WeeklyAssessmentScore weeklyAssessmentScoreFromJson(String str) => WeeklyAssessmentScore.fromJson(json.decode(str));
String weeklyAssessmentScoreToJson(WeeklyAssessmentScore data) => json.encode(data.toJson());
class WeeklyAssessmentScore {
  WeeklyAssessmentScore({
     d,
      num? week,
      num? percentIncrement, 
     }){

    _week = week;
    _percentIncrement = percentIncrement;
}

  WeeklyAssessmentScore.fromJson(dynamic json) {
    _week = json['week'];
    _percentIncrement = json['percentIncrement'];
  }

  num? _week;
  num? _percentIncrement;

WeeklyAssessmentScore copyWith({  num? id,

  num? week,
  num? percentIncrement,

}) => WeeklyAssessmentScore(
  week: week ?? _week,
  percentIncrement: percentIncrement ?? _percentIncrement,
);

  num? get week => _week;
  num? get percentIncrement => _percentIncrement;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = _week;
    map['percentIncrement'] = _percentIncrement;

    return map;
  }

}