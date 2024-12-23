import '../profile/PersonalInfo.dart';
import 'DailyMood.dart';
import 'Data.dart';
import 'dart:convert';

/// totalDays : 7
/// isPendingAssessment : false
/// dailyMood : {"id":10,"code":"Q10","type":1,"min":1,"max":1,"order":1,"status":1,"createdAt":"2023-04-26T13:01:44.000Z","updatedAt":"2023-04-26T13:01:44.000Z","title":"How are you feeling today?","description":null,"options":[{"id":40,"score":4,"status":1,"optionTitle":"Joyful","optionDescription":null},{"id":41,"score":3,"status":1,"optionTitle":"Happy","optionDescription":null},{"id":42,"score":2,"status":1,"optionTitle":"Normal","optionDescription":null},{"id":43,"score":1,"status":1,"optionTitle":"Upset","optionDescription":null},{"id":44,"score":0,"status":1,"optionTitle":"sad","optionDescription":null}]}
/// lastSubmitDate : null
/// data : {"id":2,"day":2,"orderId":null,"todoListId":2,"userId":1,"createdAt":"2023-04-26T13:06:51.000Z","updatedAt":"2023-04-26T13:06:51.000Z","deletedAt":null,"todoList":{"id":2,"code":"tl2","order":2,"trialDay":2,"isTrial":true,"status":1,"createdAt":"2023-04-26T13:01:45.000Z","updatedAt":"2023-04-26T13:01:45.000Z","title":"Introduction","description":"Beginner shot","todoListTasks":[{"id":5,"type":0,"timing":"06:30:00","status":1,"taskTitle":"Drink cinnamon water","taskDescription":"As per PCOS Awareness Association, cinnamon infused water along with some honey may help in reducing the effects of PCOS. According to a study published in the Journal Fertility and Sterility, cinnamon water reduced insulin resistance in woman with PCOS","tag":"Habit","metaData":null,"todoListResponses":[{"id":1,"orderId":null,"todoListId":2,"todoListTaskId":5,"userId":1,"text":null,"watchTime":null,"status":1,"createdAt":"2023-04-27T11:33:30.000Z","updatedAt":"2023-04-27T11:33:30.000Z","deletedAt":null}]},{"id":6,"type":1,"timing":"06:40:00","status":1,"taskTitle":"Start gratitude journal","taskDescription":"Write about one thing in your life that you are grateful for today. The purpose of gratitude journaling is to help you focus on the positive aspects of your life and cultivate an overall sense of gratitude and well-being","tag":"For mind","metaData":null,"todoListResponses":[]},{"id":7,"type":2,"timing":"07:00:00","status":1,"taskTitle":"10 Minutes of Yoga session","taskDescription":"can add descriptive description by text editor","tag":"Workout","metaData":{"level":"Beginner","proTips":["1. Use headphone or a speaker for best results","2. Wear loose or comfortable clothing","3. Put your phone on \"Do not disturb\" mode"],"duration":"10 minutes","language":"English","sessionIncludes":["1. Stretching Exercise","2. Beginner level Yoga poses","3. Breathing Practices"]},"todoListResponses":[]},{"id":8,"type":3,"timing":"08:00:00","status":1,"taskTitle":"Breakfast","taskDescription":null,"tag":"Nutrition","metaData":[{"key":"Glyceimic Load","title":"Variant 1","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 2","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 3","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]}],"todoListResponses":[]}]}}
/// currDay : 2
/// perPage : null
/// page : null
/// totalPages : null

HomeApiResponse homeApiResponseFromJson(String str) => HomeApiResponse.fromJson(json.decode(str));
String homeApiResponseToJson(HomeApiResponse data) => json.encode(data.toJson());
class HomeApiResponse {
  HomeApiResponse({
      num? planDays,
      num? totalDays,
      bool? isPendingAssessment, 
      bool? isAllNotificationSeen,
      DailyMood? dailyMood,
      PersonalInfo? personalInfo,
      String? lastSubmitDate,
      Data? data, 
      num? currDay, 
      dynamic perPage, 
      dynamic page, 
      dynamic totalPages,}){
    _totalDays = totalDays;
    _personalInfo = personalInfo;
    _planDays = planDays;
    _isPendingAssessment = isPendingAssessment;
    _isAllNotificationSeen = isAllNotificationSeen;
    _dailyMood = dailyMood;
    _lastSubmitDate = lastSubmitDate;
    _data = data;
    _currDay = currDay;
    _perPage = perPage;
    _page = page;
    _totalPages = totalPages;
}

  HomeApiResponse.fromJson(dynamic json) {
    _personalInfo = json['profile'] != null
        ? PersonalInfo.fromJson(json['profile'])
        : null;
    _totalDays = json['totalDays'];
    _planDays = json['planDays'];
    _isPendingAssessment = json['isPendingAssessment'];
    _isAllNotificationSeen = json['isAllNotificationSeen'];
    _dailyMood = json['dailyMood'] != null ? DailyMood.fromJson(json['dailyMood']) : null;
    _lastSubmitDate = json['lastSubmitDate'];
    _data = (json['data'] != null  ) ? Data.fromJson(json['data']) : null;
    _currDay = json['currDay'];
    _perPage = json['perPage'];
    _page = json['page'];
    _totalPages = json['totalPages'];
  }
  num? _totalDays;
  num? _planDays;
  bool? _isPendingAssessment;
  bool? _isAllNotificationSeen;
  DailyMood? _dailyMood;
  PersonalInfo? _personalInfo;
  String? _lastSubmitDate;
  Data? _data;
  num? _currDay;
  dynamic _perPage;
  dynamic _page;
  dynamic _totalPages;
HomeApiResponse copyWith({  num? totalDays,
  num? planDays,
  bool? isPendingAssessment,
  bool? isAllNotificationSeen,
  DailyMood? dailyMood,
  PersonalInfo? personalInfo,
  String? lastSubmitDate,
  Data? data,
  num? currDay,
  dynamic perPage,
  dynamic page,
  dynamic totalPages,
}) => HomeApiResponse(  totalDays: totalDays ?? _totalDays,
  planDays: planDays ?? _planDays,
  isPendingAssessment: isPendingAssessment ?? _isPendingAssessment,
  isAllNotificationSeen: isAllNotificationSeen ?? _isAllNotificationSeen,
  dailyMood: dailyMood ?? _dailyMood,
  personalInfo: personalInfo ?? _personalInfo,
  lastSubmitDate: lastSubmitDate ?? _lastSubmitDate,
  data: data ?? _data,
  currDay: currDay ?? _currDay,
  perPage: perPage ?? _perPage,
  page: page ?? _page,
  totalPages: totalPages ?? _totalPages,
);
  num? get totalDays => _totalDays;
  num? get planDays => _planDays;
  bool? get isPendingAssessment => _isPendingAssessment;
  bool? get isAllNotificationSeen => _isAllNotificationSeen;
  DailyMood? get dailyMood => _dailyMood;
  PersonalInfo? get personalInfo => _personalInfo;
  String? get lastSubmitDate => _lastSubmitDate;
  set lastSubmitDate(String? lastSubmitDate) {
    _lastSubmitDate = lastSubmitDate;
  }


  Data? get data => _data;
  num? get currDay => _currDay;
  dynamic get perPage => _perPage;
  dynamic get page => _page;
  dynamic get totalPages => _totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_personalInfo != null) {
      map['profile'] = _personalInfo?.toJson();
    }
    map['totalDays'] = _totalDays;
    map['planDays'] = _planDays;
    map['isPendingAssessment'] = _isPendingAssessment;
    map['isAllNotificationSeen'] = _isAllNotificationSeen;
    if (_dailyMood != null) {
      map['dailyMood'] = _dailyMood?.toJson();
    }
    map['lastSubmitDate'] = _lastSubmitDate;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['currDay'] = _currDay;
    map['perPage'] = _perPage;
    map['page'] = _page;
    map['totalPages'] = _totalPages;
    return map;
  }

}