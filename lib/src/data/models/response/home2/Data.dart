import 'dart:convert';

import 'package:curate/src/data/models/response/home2/TodoList.dart';

/// id : 2
/// day : 2
/// orderId : null
/// todoListId : 2
/// userId : 1
/// createdAt : "2023-04-26T13:06:51.000Z"
/// updatedAt : "2023-04-26T13:06:51.000Z"
/// deletedAt : null
/// todoList : {"id":2,"code":"tl2","order":2,"trialDay":2,"isTrial":true,"status":1,"createdAt":"2023-04-26T13:01:45.000Z","updatedAt":"2023-04-26T13:01:45.000Z","title":"Introduction","description":"Beginner shot","todoListTasks":[{"id":5,"type":0,"timing":"06:30:00","status":1,"taskTitle":"Drink cinnamon water","taskDescription":"As per PCOS Awareness Association, cinnamon infused water along with some honey may help in reducing the effects of PCOS. According to a study published in the Journal Fertility and Sterility, cinnamon water reduced insulin resistance in woman with PCOS","tag":"Habit","metaData":null,"todoListResponses":[{"id":1,"orderId":null,"todoListId":2,"todoListTaskId":5,"userId":1,"text":null,"watchTime":null,"status":1,"createdAt":"2023-04-27T11:33:30.000Z","updatedAt":"2023-04-27T11:33:30.000Z","deletedAt":null}]},{"id":6,"type":1,"timing":"06:40:00","status":1,"taskTitle":"Start gratitude journal","taskDescription":"Write about one thing in your life that you are grateful for today. The purpose of gratitude journaling is to help you focus on the positive aspects of your life and cultivate an overall sense of gratitude and well-being","tag":"For mind","metaData":null,"todoListResponses":[]},{"id":7,"type":2,"timing":"07:00:00","status":1,"taskTitle":"10 Minutes of Yoga session","taskDescription":"can add descriptive description by text editor","tag":"Workout","metaData":{"level":"Beginner","proTips":["1. Use headphone or a speaker for best results","2. Wear loose or comfortable clothing","3. Put your phone on \"Do not disturb\" mode"],"duration":"10 minutes","language":"English","sessionIncludes":["1. Stretching Exercise","2. Beginner level Yoga poses","3. Breathing Practices"]},"todoListResponses":[]},{"id":8,"type":3,"timing":"08:00:00","status":1,"taskTitle":"Breakfast","taskDescription":null,"tag":"Nutrition","metaData":[{"key":"Glyceimic Load","title":"Variant 1","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 2","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 3","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]}],"todoListResponses":[]}]}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? day, 
      dynamic orderId, 
      num? todoListId, 
      num? userId,
      num? status,
      String? createdAt,
      String? updatedAt, 
      dynamic deletedAt, 
      TodoList? todoList,}){
    _id = id;
    _day = day;
    _orderId = orderId;
    _todoListId = todoListId;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _todoList = todoList;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _day = json['day'];
    _orderId = json['orderId'];
    _todoListId = json['todoListId'];
    _userId = json['userId'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    _todoList =  _todoList = json['todoList'] != null
        ?  TodoList.fromJson(json['todoList'])
        : null;
  }
  num? _id;
  num? _day;
  dynamic _orderId;
  num? _todoListId;
  num? _userId;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  TodoList? _todoList;
Data copyWith({  num? id,
  num? day,
  dynamic orderId,
  num? todoListId,
  num? userId,
  num? status,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  TodoList? todoList,
}) => Data(  id: id ?? _id,
  day: day ?? _day,
  orderId: orderId ?? _orderId,
  todoListId: todoListId ?? _todoListId,
  userId: userId ?? _userId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  todoList: todoList ?? _todoList,
);
  num? get id => _id;
  num? get day => _day;
  dynamic get orderId => _orderId;
  num? get todoListId => _todoListId;
  num? get userId => _userId;
  num? get status => _status;

  set status(num? value) {
    _status = value;
  }
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  TodoList? get todoList => _todoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['day'] = _day;
    map['orderId'] = _orderId;
    map['todoListId'] = _todoListId;
    map['userId'] = _userId;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    map['todoList'] = _todoList;
    return map;
  }

}