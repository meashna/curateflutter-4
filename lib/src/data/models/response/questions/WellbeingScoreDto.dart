import 'package:curate/src/data/models/response/mood/Moods.dart';
import 'dart:convert';

import 'package:curate/src/data/models/response/questions/WeeklyAssessmentScore.dart';

/// score : 2
/// moods : [{"id":11,"day":1,"userId":2,"createdAt":"2023-05-01T10:53:09.000Z","score":2}]

WellbeingScoreDto wellbeingScoreDto1FromJson(String str) =>
    WellbeingScoreDto.fromJson(json.decode(str));

String wellbeingScoreDto1ToJson(WellbeingScoreDto data) =>
    json.encode(data.toJson());

class WellbeingScoreDto {
  WellbeingScoreDto({
    num? score,
    num? scorePercentage,
    String? message,
    List<Moods>? moods,
    List<WeeklyAssessmentScore>? assessmentHistory,
  }) {
    _score = score;
    _scorePercentage = scorePercentage;
    _message = message;
    _moods = moods;
    _assessmentHistory = assessmentHistory;
  }

  WellbeingScoreDto.fromJson(dynamic json) {
    _score = json['score'];
    _scorePercentage = json['scorePercentage'];
    if (json.containsKey("message")) {
      _message = json['message'];
    }

    if (json['moods'] != null) {
      _moods = [];
      json['moods'].forEach((v) {
        _moods?.add(Moods.fromJson(v));
      });
    }
    if (json['assessmentHistory'] != null) {
      _assessmentHistory = [];
      json['assessmentHistory'].forEach((v) {
        _assessmentHistory?.add(WeeklyAssessmentScore.fromJson(v));
      });
    }
  }

  num? _score;
  num? _scorePercentage;
  String? _message;
  List<Moods>? _moods;
  List<WeeklyAssessmentScore>? _assessmentHistory;

  WellbeingScoreDto copyWith(
          {num? score,
          num? scorePercentage,
          List<Moods>? moods,
          List<WeeklyAssessmentScore>? assessmentHistory}) =>
      WellbeingScoreDto(
          score: score ?? _score,
          scorePercentage: scorePercentage ?? _scorePercentage,
          message: message ?? _message,
          moods: moods ?? _moods,
          assessmentHistory: assessmentHistory ?? _assessmentHistory);

  num? get score => _score;
  num? get scorePercentage => _scorePercentage;
  String? get message => _message;

  List<Moods>? get moods => _moods;

  List<WeeklyAssessmentScore>? get assessmentHistory => _assessmentHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['score'] = _score;
    map['scorePercentage'] = _scorePercentage;
    map['message'] = _message;
    if (_moods != null) {
      map['moods'] = _moods?.map((v) => v.toJson()).toList();
    }
    if (_assessmentHistory != null) {
      map['assessmentHistory'] =
          _assessmentHistory?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
