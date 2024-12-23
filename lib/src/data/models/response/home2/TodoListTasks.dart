import 'dart:convert';

import 'package:curate/src/data/models/response/home2/TodoListResponses.dart';

/// id : 5
/// type : 0
/// timing : "06:30:00"
/// status : 1
/// taskTitle : "Drink cinnamon water"
/// taskDescription : "As per PCOS Awareness Association, cinnamon infused water along with some honey may help in reducing the effects of PCOS. According to a study published in the Journal Fertility and Sterility, cinnamon water reduced insulin resistance in woman with PCOS"
/// tag : "Habit"
/// metaData : null
/// todoListResponses : [{"id":1,"orderId":null,"todoListId":2,"todoListTaskId":5,"userId":1,"text":null,"watchTime":null,"status":1,"createdAt":"2023-04-27T11:33:30.000Z","updatedAt":"2023-04-27T11:33:30.000Z","deletedAt":null}]

TodoListTasks todoListTasksFromJson(String str) => TodoListTasks.fromJson(json.decode(str));
String todoListTasksToJson(TodoListTasks data) => json.encode(data.toJson());
class TodoListTasks {
  TodoListTasks({
      num? id, 
      num? type,
      num? subType,
      String? timing,
      num? status, 
      String? taskTitle, 
      String? taskDescription, 
      String? tag, 
      dynamic metaData, 
      List<TodoListResponses>? todoListResponses,}){
    _id = id;
    _type = type;
    _subType = subType;
    _timing = timing;
    _status = status;
    _taskTitle = taskTitle;
    _taskDescription = taskDescription;
    _tag = tag;
    _metaData = metaData;
    _todoListResponses = todoListResponses;
}

  TodoListTasks.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _subType = json['subType'];
    _timing = json['timing'];
    _status = json['status'];
    _taskTitle = json['taskTitle'];
    _taskDescription = json['taskDescription'];
    _tag = json['tag'];
    _metaData = json['metaData'];
    if (json['todoListResponses'] != null) {
      _todoListResponses = [];
      json['todoListResponses'].forEach((v) {
        _todoListResponses?.add(TodoListResponses.fromJson(v));
      });
    }
  }
  num? _id;
  num? _type;
  num? _subType;
  String? _timing;
  num? _status;
  String? _taskTitle;
  String? _taskDescription;
  String? _tag;
  dynamic _metaData;
  List<TodoListResponses>? _todoListResponses;
TodoListTasks copyWith({  num? id,
  num? type,
  num? subType,
  String? timing,
  num? status,
  String? taskTitle,
  String? taskDescription,
  String? tag,
  dynamic metaData,
  List<TodoListResponses>? todoListResponses,
}) => TodoListTasks(  id: id ?? _id,
  type: type ?? _type,
  subType: subType ?? _subType,
  timing: timing ?? _timing,
  status: status ?? _status,
  taskTitle: taskTitle ?? _taskTitle,
  taskDescription: taskDescription ?? _taskDescription,
  tag: tag ?? _tag,
  metaData: metaData ?? _metaData,
  todoListResponses: todoListResponses ?? _todoListResponses,
);
  num? get id => _id;
  num? get type => _type;
  num? get subType => _subType;
  String? get timing => _timing;
  num? get status => _status;
  String? get taskTitle => _taskTitle;
  String? get taskDescription => _taskDescription;
  String? get tag => _tag;
  dynamic get metaData => _metaData;
  List<TodoListResponses>? get todoListResponses => _todoListResponses;

  set todoListResponses(List<TodoListResponses>?  todoListResponses) {
    _todoListResponses = todoListResponses;
  }





  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['subType'] = _subType;
    map['timing'] = _timing;
    map['status'] = _status;
    map['taskTitle'] = _taskTitle;
    map['taskDescription'] = _taskDescription;
    map['tag'] = _tag;
    map['metaData'] = _metaData;
    if (_todoListResponses != null) {
      map['todoListResponses'] = _todoListResponses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}