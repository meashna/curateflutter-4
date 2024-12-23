import 'dart:convert';

import 'package:curate/src/data/models/response/home2/TodoListTasks.dart';

/// id : 2
/// code : "tl2"
/// order : 2
/// trialDay : 2
/// isTrial : true
/// status : 1
/// createdAt : "2023-04-26T13:01:45.000Z"
/// updatedAt : "2023-04-26T13:01:45.000Z"
/// title : "Introduction"
/// description : "Beginner shot"
/// todoListTasks : [{"id":5,"type":0,"timing":"06:30:00","status":1,"taskTitle":"Drink cinnamon water","taskDescription":"As per PCOS Awareness Association, cinnamon infused water along with some honey may help in reducing the effects of PCOS. According to a study published in the Journal Fertility and Sterility, cinnamon water reduced insulin resistance in woman with PCOS","tag":"Habit","metaData":null,"todoListResponses":[{"id":1,"orderId":null,"todoListId":2,"todoListTaskId":5,"userId":1,"text":null,"watchTime":null,"status":1,"createdAt":"2023-04-27T11:33:30.000Z","updatedAt":"2023-04-27T11:33:30.000Z","deletedAt":null}]},{"id":6,"type":1,"timing":"06:40:00","status":1,"taskTitle":"Start gratitude journal","taskDescription":"Write about one thing in your life that you are grateful for today. The purpose of gratitude journaling is to help you focus on the positive aspects of your life and cultivate an overall sense of gratitude and well-being","tag":"For mind","metaData":null,"todoListResponses":[]},{"id":7,"type":2,"timing":"07:00:00","status":1,"taskTitle":"10 Minutes of Yoga session","taskDescription":"can add descriptive description by text editor","tag":"Workout","metaData":{"level":"Beginner","proTips":["1. Use headphone or a speaker for best results","2. Wear loose or comfortable clothing","3. Put your phone on \"Do not disturb\" mode"],"duration":"10 minutes","language":"English","sessionIncludes":["1. Stretching Exercise","2. Beginner level Yoga poses","3. Breathing Practices"]},"todoListResponses":[]},{"id":8,"type":3,"timing":"08:00:00","status":1,"taskTitle":"Breakfast","taskDescription":null,"tag":"Nutrition","metaData":[{"key":"Glyceimic Load","title":"Variant 1","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 2","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]},{"key":"Glyceimic Load","title":"Variant 3","value":130,"points":["1 Egg ; 2 Whole wheat bread","1 Bowl of Cucumber salad"]}],"todoListResponses":[]}]

TodoList todoListFromJson(String str) => TodoList.fromJson(json.decode(str));
String todoListToJson(TodoList data) => json.encode(data.toJson());
class TodoList {
  TodoList({
      num? id, 
      String? code, 
      num? order, 
      num? trialDay, 
      bool? isTrial, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? title, 
      String? description, 
      List<TodoListTasks>? todoListTasks,}){
    _id = id;
    _code = code;
    _order = order;
    _trialDay = trialDay;
    _isTrial = isTrial;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _title = title;
    _description = description;
    _todoListTasks = todoListTasks;
}

  TodoList.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _order = json['order'];
    _trialDay = json['trialDay'];
    _isTrial = json['isTrial'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _title = json['title'];
    _description = json['description'];
    if (json['todoListTasks'] != null) {
      _todoListTasks = [];
      json['todoListTasks'].forEach((v) {
        _todoListTasks?.add(TodoListTasks.fromJson(v));
      });
    }
  }
  num? _id;
  String? _code;
  num? _order;
  num? _trialDay;
  bool? _isTrial;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _title;
  String? _description;
  List<TodoListTasks>? _todoListTasks;
TodoList copyWith({  num? id,
  String? code,
  num? order,
  num? trialDay,
  bool? isTrial,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? title,
  String? description,
  List<TodoListTasks>? todoListTasks,
}) => TodoList(  id: id ?? _id,
  code: code ?? _code,
  order: order ?? _order,
  trialDay: trialDay ?? _trialDay,
  isTrial: isTrial ?? _isTrial,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  title: title ?? _title,
  description: description ?? _description,
  todoListTasks: todoListTasks ?? _todoListTasks,
);
  num? get id => _id;
  String? get code => _code;
  num? get order => _order;
  num? get trialDay => _trialDay;
  bool? get isTrial => _isTrial;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get title => _title;
  String? get description => _description;
  List<TodoListTasks>? get todoListTasks => _todoListTasks;

  set myTodoListTasks(List<TodoListTasks>? value) {
    _todoListTasks = value;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['order'] = _order;
    map['trialDay'] = _trialDay;
    map['isTrial'] = _isTrial;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['title'] = _title;
    map['description'] = _description;
    if (_todoListTasks != null) {
      map['todoListTasks'] = _todoListTasks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}