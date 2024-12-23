import 'package:curate/src/data/models/response/healthLog/HealthLogData.dart';
import 'package:curate/src/data/models/response/questions/WeeklyAssessmentScore.dart';

import '../../WellBeingMessage.dart';
import 'PersonalInfo.dart';
import 'HabitLog.dart';
import 'dart:convert';

/// personalInfo : {"id":34,"userId":48,"name":"Harsh","dob":"1996-05-08","height":79.55,"weight":134.37,"wellBeingScore":81,"productStatus":null,"productId":null,"productStart":null,"productDuration":null,"trialStart":"2023-05-13T05:09:12.000Z","trialDuration":7,"purchaseCount":0,"createdAt":"2023-05-13T05:09:12.000Z","updatedAt":"2023-05-24T08:29:36.000Z","deletedAt":null}
/// assessmentHistory : [{"id":49,"orderId":null,"userId":48,"week":1,"score":15,"percentIncrement":81,"status":1,"createdAt":"2023-05-24T08:29:36.000Z","updatedAt":"2023-05-24T08:29:36.000Z","deletedAt":null},{"id":49,"orderId":null,"userId":48,"week":2,"score":15,"percentIncrement":81,"status":1,"createdAt":"2023-05-24T08:29:36.000Z","updatedAt":"2023-05-24T08:29:36.000Z","deletedAt":null}]
/// healthLog : [{"id":24,"code":"hl-24","userId":48,"type":"0","periodCycleFrom":null,"periodCycleTo":null,"periodFlowId":null,"weight":80,"waist":null,"status":1,"createdAt":"2023-05-26T13:49:32.000Z","updatedAt":"2023-05-26T13:49:32.000Z","deletedAt":null,"self":[]},{"id":27,"code":"hl-27","userId":48,"type":"2","periodCycleFrom":null,"periodCycleTo":null,"periodFlowId":null,"weight":null,"waist":45,"status":1,"createdAt":"2023-05-26T14:44:05.000Z","updatedAt":"2023-05-26T14:44:05.000Z","deletedAt":null,"self":[]}]
/// habitLog : {"nper":100,"mper":42.857142857142854,"fper":null}

MyProfileDto profileResponseFromJson(String str) =>
    MyProfileDto.fromJson(json.decode(str));

String profileResponseToJson(MyProfileDto data) => json.encode(data.toJson());

class MyProfileDto {
  MyProfileDto({
    PersonalInfo? personalInfo,
    List<WeeklyAssessmentScore>? assessmentHistory,
    List<HealthLogData>? healthLog,
    HabitLog? habitLog,
    bool? isTaskSubmitted,
    WellBeingMessage? wellBeingMessage,
  }) {
    _personalInfo = personalInfo;
    _assessmentHistory = assessmentHistory;
    _healthLog = healthLog;
    _habitLog = habitLog;
    _isTaskSubmitted = isTaskSubmitted;
    _wellBeingMessage = wellBeingMessage;
  }

  MyProfileDto.fromJson(dynamic json) {
    _personalInfo = json['personalInfo'] != null
        ? PersonalInfo.fromJson(json['personalInfo'])
        : null;
    if (json['assessmentHistory'] != null) {
      _assessmentHistory = [];
      json['assessmentHistory'].forEach((v) {
        _assessmentHistory?.add(WeeklyAssessmentScore.fromJson(v));
      });
    }
    if (json['healthLog'] != null) {
      _healthLog = [];
      json['healthLog'].forEach((v) {
        _healthLog?.add(HealthLogData.fromJson(v));
      });
    }
    _habitLog =
        json['habitLog'] != null ? HabitLog.fromJson(json['habitLog']) : null;
    _isTaskSubmitted = json['isTaskSubmitted'];
    _wellBeingMessage = json['wellBeingMessage'] != null
        ? WellBeingMessage.fromJson(json['wellBeingMessage'])
        : null;
  }

  PersonalInfo? _personalInfo;
  List<WeeklyAssessmentScore>? _assessmentHistory;
  List<HealthLogData>? _healthLog;
  HabitLog? _habitLog;
  bool? _isTaskSubmitted;
  WellBeingMessage? _wellBeingMessage;

  MyProfileDto copyWith({
    PersonalInfo? personalInfo,
    List<WeeklyAssessmentScore>? assessmentHistory,
    List<HealthLogData>? healthLog,
    HabitLog? habitLog,
    bool? isTaskSubmitted,
    WellBeingMessage? wellBeingMessage,
  }) =>
      MyProfileDto(
        personalInfo: personalInfo ?? _personalInfo,
        assessmentHistory: assessmentHistory ?? _assessmentHistory,
        healthLog: healthLog ?? _healthLog,
        habitLog: habitLog ?? _habitLog,
        isTaskSubmitted: isTaskSubmitted ?? _isTaskSubmitted,
        wellBeingMessage: wellBeingMessage ?? _wellBeingMessage,
      );

  PersonalInfo? get personalInfo => _personalInfo;

  List<WeeklyAssessmentScore>? get assessmentHistory => _assessmentHistory;

  List<HealthLogData>? get healthLog => _healthLog;

  HabitLog? get habitLog => _habitLog;
  bool? get isTaskSubmitted => _isTaskSubmitted;
  WellBeingMessage? get wellBeingMessage => _wellBeingMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_personalInfo != null) {
      map['personalInfo'] = _personalInfo?.toJson();
    }
    if (_assessmentHistory != null) {
      map['assessmentHistory'] =
          _assessmentHistory?.map((v) => v.toJson()).toList();
    }
    if (_healthLog != null) {
      map['healthLog'] = _healthLog?.map((v) => v.toJson()).toList();
    }
    map['isTaskSubmitted'] = _isTaskSubmitted;
    if (_habitLog != null) {
      map['habitLog'] = _habitLog?.toJson();
    }
    if (_wellBeingMessage != null) {
      map['wellBeingMessage'] = _wellBeingMessage?.toJson();
    }
    return map;
  }
}
