import 'dart:convert';

/// level : "Beginner"
/// proTips : ["1. Use headphone or a speaker for best results","2. Wear loose or comfortable clothing","3. Put your phone on \"Do not disturb\" mode"]
/// duration : "10 minutes"
/// language : "English"
/// sessionIncludes : ["1. Stretching Exercise","2. Beginner level Yoga poses","3. Breathing Practices"]

WorkoutMetaData workoutMetaDataFromJson(String str) =>
    WorkoutMetaData.fromJson(json.decode(str));

String workoutMetaDataToJson(WorkoutMetaData data) =>
    json.encode(data.toJson());

class WorkoutMetaData {
  WorkoutMetaData({
    String? level,
    String? link,
    List<String>? proTips,
    String? duration,
    String? language,
    List<String>? sessionIncludes,
  }) {
    _level = level;
    _link = link;
    _proTips = proTips;
    _duration = duration;
    _language = language;
    _sessionIncludes = sessionIncludes;
  }

  WorkoutMetaData.fromJson(dynamic json) {
    _level = json['level'];
    _link = json['link'];
    _proTips = json['proTips'] != null ? json['proTips'].cast<String>() : [];
    _duration = json['duration'];
    _language = json['language'];
    _sessionIncludes = json['sessionIncludes'] != null
        ? json['sessionIncludes'].cast<String>()
        : [];
  }

  String? _level;
  String? _link;
  List<String>? _proTips;
  String? _duration;
  String? _language;
  List<String>? _sessionIncludes;

  WorkoutMetaData copyWith({
    String? level,
    String? link,
    List<String>? proTips,
    String? duration,
    String? language,
    List<String>? sessionIncludes,
  }) =>
      WorkoutMetaData(
        level: level ?? _level,
        link: link ?? _link,
        proTips: proTips ?? _proTips,
        duration: duration ?? _duration,
        language: language ?? _language,
        sessionIncludes: sessionIncludes ?? _sessionIncludes,
      );

  String? get level => _level;
  String? get link => _link;
  List<String>? get proTips => _proTips;

  String? get duration => _duration;

  String? get language => _language;

  List<String>? get sessionIncludes => _sessionIncludes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['level'] = _level;
    map['link'] = _link;
    map['proTips'] = _proTips;
    map['duration'] = _duration;
    map['language'] = _language;
    map['sessionIncludes'] = _sessionIncludes;
    return map;
  }
}
