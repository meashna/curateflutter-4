import 'dart:convert';

/// id : 1
/// orderId : null
/// todoListId : 2
/// todoListTaskId : 5
/// userId : 1
/// text : null
/// watchTime : null
/// status : 1
/// createdAt : "2023-04-27T11:33:30.000Z"
/// updatedAt : "2023-04-27T11:33:30.000Z"
/// deletedAt : null

TodoListResponses todoListResponsesFromJson(String str) => TodoListResponses.fromJson(json.decode(str));
String todoListResponsesToJson(TodoListResponses data) => json.encode(data.toJson());
class TodoListResponses {
  TodoListResponses({
      num? id, 
      dynamic orderId, 
      num? todoListId, 
      num? todoListTaskId, 
      num? userId, 
      dynamic text, 
      dynamic watchTime, 
      num? status,
      num? isDayComplete,
      String? createdAt, 
      String? updatedAt,
      dynamic deletedAt,}){
    _id = id;
    _orderId = orderId;
    _todoListId = todoListId;
    _todoListTaskId = todoListTaskId;
    _userId = userId;
    _text = text;
    _watchTime = watchTime;
    _status = status;
    _isDayComplete = isDayComplete;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  TodoListResponses.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _todoListId = json['todoListId'];
    _todoListTaskId = json['todoListTaskId'];
    _userId = json['userId'];
    _text = json['text'];
    _watchTime = json['watchTime'];
    _status = json['status'];
    _isDayComplete = json['isDayComplete'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  dynamic _orderId;
  num? _todoListId;
  num? _todoListTaskId;
  num? _userId;
  dynamic _text;
  dynamic _watchTime;
  num? _status;
  num? _isDayComplete;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
TodoListResponses copyWith({  num? id,
  dynamic orderId,
  num? todoListId,
  num? todoListTaskId,
  num? userId,
  dynamic text,
  dynamic watchTime,
  num? status,
  num? isDayComplete,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => TodoListResponses(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  todoListId: todoListId ?? _todoListId,
  todoListTaskId: todoListTaskId ?? _todoListTaskId,
  userId: userId ?? _userId,
  text: text ?? _text,
  watchTime: watchTime ?? _watchTime,
  status: status ?? _status,
  isDayComplete: isDayComplete ?? _isDayComplete,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  dynamic get orderId => _orderId;
  num? get todoListId => _todoListId;
  num? get todoListTaskId => _todoListTaskId;
  num? get userId => _userId;
  dynamic get text => _text;
  dynamic get watchTime => _watchTime;
  num? get status => _status;
  num? get isDayComplete => _isDayComplete;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderId'] = _orderId;
    map['todoListId'] = _todoListId;
    map['todoListTaskId'] = _todoListTaskId;
    map['userId'] = _userId;
    map['text'] = _text;
    map['watchTime'] = _watchTime;
    map['status'] = _status;
    map['isDayComplete'] = _isDayComplete;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}