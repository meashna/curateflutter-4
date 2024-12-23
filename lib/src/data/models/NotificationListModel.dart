import 'dart:convert';

/// totalRecords : 2
/// totalPage : 1
/// page : 1
/// perPage : 20
/// notifications : [{"id":29,"isViewed":false,"replacements":{},"data":{"type":"0"},"createdAt":"2023-06-22T06:25:42.000Z","updatedAt":"2023-06-22T06:25:42.000Z","historyNotification":{"id":4,"type":0,"title":"Weekly Assessment","description":"Your weekly assessment is pending."}},{"id":28,"isViewed":false,"replacements":{},"data":{"type":"0"},"createdAt":"2023-06-22T06:19:12.000Z","updatedAt":"2023-06-22T06:19:12.000Z","historyNotification":{"id":4,"type":0,"title":"Weekly Assessment","description":"Your weekly assessment is pending."}}]

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  NotificationListModel({
    num? totalRecords,
    num? totalPage,
    num? page,
    num? perPage,
    List<Notifications>? notifications,
  }) {
    _totalRecords = totalRecords;
    _totalPage = totalPage;
    _page = page;
    _perPage = perPage;
    _notifications = notifications;
  }

  NotificationListModel.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    _totalPage = json['totalPage'];
    _page = json['page'];
    _perPage = json['perPage'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }

  num? _totalRecords;
  num? _totalPage;
  num? _page;
  num? _perPage;
  List<Notifications>? _notifications;

  NotificationListModel copyWith({
    num? totalRecords,
    num? totalPage,
    num? page,
    num? perPage,
    List<Notifications>? notifications,
  }) =>
      NotificationListModel(
        totalRecords: totalRecords ?? _totalRecords,
        totalPage: totalPage ?? _totalPage,
        page: page ?? _page,
        perPage: perPage ?? _perPage,
        notifications: notifications ?? _notifications,
      );

  num? get totalRecords => _totalRecords;

  num? get totalPage => _totalPage;

  num? get page => _page;

  num? get perPage => _perPage;

  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    map['totalPage'] = _totalPage;
    map['page'] = _page;
    map['perPage'] = _perPage;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 29
/// isViewed : false
/// replacements : {}
/// data : {"type":"0"}
/// createdAt : "2023-06-22T06:25:42.000Z"
/// updatedAt : "2023-06-22T06:25:42.000Z"
/// historyNotification : {"id":4,"type":0,"title":"Weekly Assessment","description":"Your weekly assessment is pending."}

Notifications notificationsFromJson(String str) =>
    Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    num? id,
    bool? isViewed,
    dynamic replacements,
    Data? data,
    String? createdAt,
    String? updatedAt,
    HistoryNotification? historyNotification,
  }) {
    _id = id;
    _isViewed = isViewed;
    _replacements = replacements;
    _data = data;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _historyNotification = historyNotification;
  }

  Notifications.fromJson(dynamic json) {
    _id = json['id'];
    _isViewed = json['isViewed'];
    _replacements = json['replacements'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _historyNotification = json['historyNotification'] != null
        ? HistoryNotification.fromJson(json['historyNotification'])
        : null;
  }

  num? _id;
  bool? _isViewed;
  dynamic _replacements;
  Data? _data;
  String? _createdAt;
  String? _updatedAt;
  HistoryNotification? _historyNotification;

  Notifications copyWith({
    num? id,
    bool? isViewed,
    dynamic replacements,
    Data? data,
    String? createdAt,
    String? updatedAt,
    HistoryNotification? historyNotification,
  }) =>
      Notifications(
        id: id ?? _id,
        isViewed: isViewed ?? _isViewed,
        replacements: replacements ?? _replacements,
        data: data ?? _data,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        historyNotification: historyNotification ?? _historyNotification,
      );

  num? get id => _id;

  bool? get isViewed => _isViewed;

  dynamic get replacements => _replacements;

  Data? get data => _data;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  HistoryNotification? get historyNotification => _historyNotification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['isViewed'] = _isViewed;
    map['replacements'] = _replacements;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_historyNotification != null) {
      map['historyNotification'] = _historyNotification?.toJson();
    }
    return map;
  }
}

/// id : 4
/// type : 0
/// title : "Weekly Assessment"
/// description : "Your weekly assessment is pending."

HistoryNotification historyNotificationFromJson(String str) =>
    HistoryNotification.fromJson(json.decode(str));

String historyNotificationToJson(HistoryNotification data) =>
    json.encode(data.toJson());

class HistoryNotification {
  HistoryNotification({
    num? id,
    num? type,
    String? title,
    String? description,
  }) {
    _id = id;
    _type = type;
    _title = title;
    _description = description;
  }

  HistoryNotification.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _title = json['title'];
    _description = json['description'];
  }

  num? _id;
  num? _type;
  String? _title;
  String? _description;

  HistoryNotification copyWith({
    num? id,
    num? type,
    String? title,
    String? description,
  }) =>
      HistoryNotification(
        id: id ?? _id,
        type: type ?? _type,
        title: title ?? _title,
        description: description ?? _description,
      );

  num? get id => _id;

  num? get type => _type;

  String? get title => _title;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }
}

/// type : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? type,
    String? todoOrderId,
    String? todoListTaskId,


  }) {
    _type = type;
    _todoOrderId = todoOrderId;
    _todoListTaskId = todoListTaskId;
  }

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _todoOrderId = json['todoOrderId'];
    _todoListTaskId = json['todoListTaskId'];
  }

  String? _type;
  String? _todoOrderId;
  String? _todoListTaskId;


  Data copyWith({
    String? type,
    String? todoOrderId,
    String? todoListTaskId

  }) =>
      Data(
        type: type ?? _type,
          todoOrderId:todoOrderId??_todoOrderId,
          todoListTaskId:todoListTaskId??_todoListTaskId
      );

  String? get type => _type;
  String? get todoOrderId => _todoOrderId;
  String? get todoListTaskId => _todoListTaskId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['todoOrderId'] = _todoOrderId;
    map['todoListTaskId'] = _todoListTaskId;
    return map;
  }
}
