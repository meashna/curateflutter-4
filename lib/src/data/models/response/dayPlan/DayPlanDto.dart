import 'dart:convert';

import '../home2/Data.dart';
/// data : {"id":1328,"day":6,"orderId":null,"todoListId":6,"userId":185,"status":0,"createdAt":"2023-06-17T15:39:32.000Z","updatedAt":"2023-06-17T15:39:32.000Z","deletedAt":null,"todoList":{"id":6,"code":"tl6","order":6,"trialDay":6,"isTrial":true,"status":1,"createdAt":"2023-05-04T07:20:23.000Z","updatedAt":"2023-05-04T07:20:23.000Z","title":"Introduction","description":"Your first day at Curate","todoListTasks":[{"id":26,"type":0,"subType":null,"timing":"06:30:00","status":1,"taskTitle":"Drink cinnamon water","taskDescription":"As per PCOS Awareness Association, cinnamon infused water along with some honey may help in reducing the effects of PCOS. According to a study published in the Journal Fertility and Sterility, cinnamon water reduced insulin resistance in woman with PCOS","tag":"Habit","metaData":null,"todoListResponses":[]},{"id":27,"type":1,"subType":null,"timing":"06:40:00","status":1,"taskTitle":"Start gratitude journal","taskDescription":"Write about one thing in your life that you are grateful for today. The purpose of gratitude journaling is to help you focus on the positive aspects of your life and cultivate an overall sense of gratitude and well-being","tag":"For mind","metaData":null,"todoListResponses":[]},{"id":28,"type":2,"subType":null,"timing":"07:00:00","status":1,"taskTitle":"10 Minutes of Yoga session","taskDescription":"can add descriptive description by text editor","tag":"Workout","metaData":{"link":"https://youtu.be/4xrDxxg5jv4","level":"Beginner","proTips":["Use headphone or a speaker for best results","Wear loose or comfortable clothing","Put your phone on \"Do not disturb\" mode"],"duration":"10 minutes","language":"English","sessionIncludes":["Stretching Exercise","Beginner level Yoga poses","Breathing Practices"]},"todoListResponses":[]},{"id":29,"type":3,"subType":null,"timing":"08:00:00","status":1,"taskTitle":"Breakfast","taskDescription":null,"tag":"Nutrition","metaData":[{"key":"Glyceimic Load","title":"Variant 1","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 2","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 3","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]}],"todoListResponses":[]},{"id":30,"type":4,"subType":null,"timing":"17:00:00","status":1,"taskTitle":"Pushyannga churna with lukewarm water (1 glass)","taskDescription":null,"tag":"Remedy","metaData":[{"key":"Method of use","value":"After food"},{"key":"QTY","value":"2 teaspoon"}],"todoListResponses":[]}]}}
/// currDay : 6
/// isExpiry : false

DayPlanDto dayPlanDtoFromJson(String str) => DayPlanDto.fromJson(json.decode(str));
String dayPlanDtoToJson(DayPlanDto data) => json.encode(data.toJson());
class DayPlanDto {
  DayPlanDto({
      Data? data, 
      num? currDay, 
      bool? isExpiry,}){
    _data = data;
    _currDay = currDay;
    _isExpiry = isExpiry;
}

  DayPlanDto.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _currDay = json['currDay'];
    _isExpiry = json['isExpiry'];
  }
  Data? _data;
  num? _currDay;
  bool? _isExpiry;
DayPlanDto copyWith({  Data? data,
  num? currDay,
  bool? isExpiry,
}) => DayPlanDto(  data: data ?? _data,
  currDay: currDay ?? _currDay,
  isExpiry: isExpiry ?? _isExpiry,
);
  Data? get data => _data;
  num? get currDay => _currDay;
  bool? get isExpiry => _isExpiry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['currDay'] = _currDay;
    map['isExpiry'] = _isExpiry;
    return map;
  }

}
