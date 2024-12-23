import 'dart:convert';
/// points : [{"order":1,"title":"PCOS Evaluation and treatment planning by an Ayuverda gynecologist"},{"order":2,"title":"Monthly Gynecologist & Mental health counselor sessions"},{"order":3,"title":"Weekly Followups with qualified PCOS Coach"},{"order":4,"title":"Unlimited messaging support"},{"order":5,"title":"Customised diet plans every 2 weeks"},{"order":6,"title":"Premium self-care library with 100+ guided contents on Fitness and Mindfulness"},{"order":7,"title":"Unlimited access to exclusive blogs and articles"},{"order":8,"title":"Track your daily progress"}]
/// data : [{"id":2,"code":"2","order":2,"price":2400,"duration":90,"trial":7,"status":1,"createdAt":"2023-05-04T07:20:28.000Z","updatedAt":"2023-05-04T07:20:28.000Z","title":"Curate Kick Starter"},{"id":3,"code":"3","order":3,"price":2100,"duration":180,"trial":7,"status":1,"createdAt":"2023-05-04T07:20:28.000Z","updatedAt":"2023-05-04T07:20:28.000Z","title":"Curate Classic"},{"id":4,"code":"4","order":4,"price":1800,"duration":360,"trial":7,"status":1,"createdAt":"2023-05-04T07:20:28.000Z","updatedAt":"2023-05-04T07:20:28.000Z","title":"Curate Pre-Pregnancy"}]
/*
*PRODUCT_TYPE: {

 TRIAL: 0,

NORMAL: 1,

POPULAR: 2,

ADVANCED: 3
}
* */
ChoosePackageResponse choosePackageResponseFromJson(String str) => ChoosePackageResponse.fromJson(json.decode(str));
String choosePackageResponseToJson(ChoosePackageResponse data) => json.encode(data.toJson());
class ChoosePackageResponse {
  ChoosePackageResponse({
      List<Points>? points, 
      List<Data>? data,}){
    _points = points;
    _data = data;
}

  ChoosePackageResponse.fromJson(dynamic json) {
    if (json['points'] != null) {
      _points = [];
      json['points'].forEach((v) {
        _points?.add(Points.fromJson(v));
      });
    }
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Points>? _points;
  List<Data>? _data;
ChoosePackageResponse copyWith({  List<Points>? points,
  List<Data>? data,
}) => ChoosePackageResponse(  points: points ?? _points,
  data: data ?? _data,
);
  List<Points>? get points => _points;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_points != null) {
      map['points'] = _points?.map((v) => v.toJson()).toList();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// code : "2"
/// order : 2
/// price : 2400
/// duration : 90
/// trial : 7
/// status : 1
/// createdAt : "2023-05-04T07:20:28.000Z"
/// updatedAt : "2023-05-04T07:20:28.000Z"
/// title : "Curate Kick Starter"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? code, 
      num? order, 
      num? type,
      num? price,
      String? durationTitle,
      String? iosPlanId,
      num? duration,
      num? trial, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? title,}){
    _id = id;
    _code = code;
    _order = order;
    _type = type;
    _price = price;
    _duration = duration;
    _iosPlanId = iosPlanId;
    _durationTitle=durationTitle;
    _trial = trial;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _title = title;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _order = json['order'];
    _type = json['type'];
    _price = json['price'];
    _duration = json['duration'];
    _iosPlanId = json['iosPlanId'];
    _durationTitle = json['durationTitle'];
    _trial = json['trial'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _title = json['title'];
  }
  num? _id;
  String? _code;
  String? _iosPlanId;
  String? _durationTitle;
  num? _order;
  num? _type;
  num? _price;
  num? _duration;
  num? _trial;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _title;
Data copyWith({  num? id,
  String? code,
  String? durationTitle,
  num? order,
  num? type,
  num? price,
  num? duration,
  num? trial,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? title,
}) => Data(  id: id ?? _id,
  code: code ?? _code,
  order: order ?? _order,
  iosPlanId: iosPlanId ?? _iosPlanId,
  type: type ?? _type,
  price: price ?? _price,
  duration: duration ?? _duration,
  trial: trial ?? _trial,
  status: status ?? _status,
  durationTitle: durationTitle??_durationTitle,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  title: title ?? _title,
);
  num? get id => _id;
  String? get code => _code;
  String? get durationTitle => _durationTitle;
  String? get iosPlanId => _iosPlanId;
  num? get order => _order;
  num? get type => _type;
  num? get price => _price;
  num? get duration => _duration;
  num? get trial => _trial;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['order'] = _order;
    map['type '] = _type;
    map['price'] = _price;
    map['iosPlanId'] = _iosPlanId;
    map['durationTitle'] = _durationTitle;
    map['duration'] = _duration;
    map['trial'] = _trial;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['title'] = _title;
    return map;
  }

}

/// order : 1
/// title : "PCOS Evaluation and treatment planning by an Ayuverda gynecologist"

Points pointsFromJson(String str) => Points.fromJson(json.decode(str));
String pointsToJson(Points data) => json.encode(data.toJson());
class Points {
  Points({
      num? order, 
      String? title,}){
    _order = order;
    _title = title;
}

  Points.fromJson(dynamic json) {
    _order = json['order'];
    _title = json['title'];
  }
  num? _order;
  String? _title;
Points copyWith({  num? order,
  String? title,
}) => Points(  order: order ?? _order,
  title: title ?? _title,
);
  num? get order => _order;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order'] = _order;
    map['title'] = _title;
    return map;
  }

}