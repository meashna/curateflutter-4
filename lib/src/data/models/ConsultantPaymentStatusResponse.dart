import 'dart:convert';

import 'package:curate/src/data/models/ConsultantsProductResponse.dart';
/// product : {"id":5,"code":"5","type":4,"order":5,"price":99,"duration":-1,"trial":-1,"status":1,"createdAt":"2023-05-04T07:20:28.000Z","updatedAt":"2023-05-04T07:20:28.000Z","metaData":[{"mobile":"8888888888","message":"Hello There"}],"title":"Talk to our experts","description":"Talk to our experts"}
/// talkToExpertStatus : {"id":103,"userId":163,"productId":5,"productType":4,"amount":"99","duration":-1,"eventName":"payments.updated","transactionId":"tx_mdT1PfL5UfP4N4LydVhq3qd8h","upiData":null,"status":6,"currPlanStatus":2,"createdAt":"2023-06-13T07:20:24.000Z","updatedAt":"2023-06-13T07:20:40.000Z","deletedAt":null}

ConsultantPaymentStatusResponse consultantPaymentStatusResponseFromJson(String str) => ConsultantPaymentStatusResponse.fromJson(json.decode(str));
String consultantPaymentStatusResponseToJson(ConsultantPaymentStatusResponse data) => json.encode(data.toJson());
class ConsultantPaymentStatusResponse {
  ConsultantPaymentStatusResponse({
      Product? product, 
      TalkToExpertStatus? talkToExpertStatus,}){
    _product = product;
    _talkToExpertStatus = talkToExpertStatus;
}

  ConsultantPaymentStatusResponse.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _talkToExpertStatus = json['talkToExpertStatus'] != null ? TalkToExpertStatus.fromJson(json['talkToExpertStatus']) : null;
  }
  Product? _product;
  TalkToExpertStatus? _talkToExpertStatus;
ConsultantPaymentStatusResponse copyWith({  Product? product,
  TalkToExpertStatus? talkToExpertStatus,
}) => ConsultantPaymentStatusResponse(  product: product ?? _product,
  talkToExpertStatus: talkToExpertStatus ?? _talkToExpertStatus,
);
  Product? get product => _product;
  TalkToExpertStatus? get talkToExpertStatus => _talkToExpertStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    if (_talkToExpertStatus != null) {
      map['talkToExpertStatus'] = _talkToExpertStatus?.toJson();
    }
    return map;
  }

}

/// id : 103
/// userId : 163
/// productId : 5
/// productType : 4
/// amount : "99"
/// duration : -1
/// eventName : "payments.updated"
/// transactionId : "tx_mdT1PfL5UfP4N4LydVhq3qd8h"
/// upiData : null
/// status : 6
/// currPlanStatus : 2
/// createdAt : "2023-06-13T07:20:24.000Z"
/// updatedAt : "2023-06-13T07:20:40.000Z"
/// deletedAt : null

TalkToExpertStatus talkToExpertStatusFromJson(String str) => TalkToExpertStatus.fromJson(json.decode(str));
String talkToExpertStatusToJson(TalkToExpertStatus data) => json.encode(data.toJson());
class TalkToExpertStatus {
  TalkToExpertStatus({
      num? id, 
      num? userId, 
      num? productId, 
      num? productType, 
      String? amount, 
      num? duration, 
      String? eventName, 
      String? transactionId, 
      dynamic upiData, 
      num? status, 
      num? currPlanStatus, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _productType = productType;
    _amount = amount;
    _duration = duration;
    _eventName = eventName;
    _transactionId = transactionId;
    _upiData = upiData;
    _status = status;
    _currPlanStatus = currPlanStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  TalkToExpertStatus.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _productId = json['productId'];
    _productType = json['productType'];
    _amount = json['amount'];
    _duration = json['duration'];
    _eventName = json['eventName'];
    _transactionId = json['transactionId'];
    _upiData = json['upiData'];
    _status = json['status'];
    _currPlanStatus = json['currPlanStatus'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
  }
  num? _id;
  num? _userId;
  num? _productId;
  num? _productType;
  String? _amount;
  num? _duration;
  String? _eventName;
  String? _transactionId;
  dynamic _upiData;
  num? _status;
  num? _currPlanStatus;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
TalkToExpertStatus copyWith({  num? id,
  num? userId,
  num? productId,
  num? productType,
  String? amount,
  num? duration,
  String? eventName,
  String? transactionId,
  dynamic upiData,
  num? status,
  num? currPlanStatus,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => TalkToExpertStatus(  id: id ?? _id,
  userId: userId ?? _userId,
  productId: productId ?? _productId,
  productType: productType ?? _productType,
  amount: amount ?? _amount,
  duration: duration ?? _duration,
  eventName: eventName ?? _eventName,
  transactionId: transactionId ?? _transactionId,
  upiData: upiData ?? _upiData,
  status: status ?? _status,
  currPlanStatus: currPlanStatus ?? _currPlanStatus,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  num? get userId => _userId;
  num? get productId => _productId;
  num? get productType => _productType;
  String? get amount => _amount;
  num? get duration => _duration;
  String? get eventName => _eventName;
  String? get transactionId => _transactionId;
  dynamic get upiData => _upiData;
  num? get status => _status;
  num? get currPlanStatus => _currPlanStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['productId'] = _productId;
    map['productType'] = _productType;
    map['amount'] = _amount;
    map['duration'] = _duration;
    map['eventName'] = _eventName;
    map['transactionId'] = _transactionId;
    map['upiData'] = _upiData;
    map['status'] = _status;
    map['currPlanStatus'] = _currPlanStatus;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }

}

/// id : 5
/// code : "5"
/// type : 4
/// order : 5
/// price : 99
/// duration : -1
/// trial : -1
/// status : 1
/// createdAt : "2023-05-04T07:20:28.000Z"
/// updatedAt : "2023-05-04T07:20:28.000Z"
/// metaData : [{"mobile":"8888888888","message":"Hello There"}]
/// title : "Talk to our experts"
/// description : "Talk to our experts"

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      num? id, 
      String? code, 
      num? type, 
      num? order, 
      num? price, 
      num? duration, 
      num? trial, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      List<MetaData1>? metaData,
      String? title, 
      String? description,}){
    _id = id;
    _code = code;
    _type = type;
    _order = order;
    _price = price;
    _duration = duration;
    _trial = trial;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _metaData = metaData;
    _title = title;
    _description = description;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _type = json['type'];
    _order = json['order'];
    _price = json['price'];
    _duration = json['duration'];
    _trial = json['trial'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['metaData'] != null) {
      _metaData = [];
      json['metaData'].forEach((v) {
        _metaData?.add(MetaData1.fromJson(v));
      });
    }
    _title = json['title'];
    _description = json['description'];
  }
  num? _id;
  String? _code;
  num? _type;
  num? _order;
  num? _price;
  num? _duration;
  num? _trial;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  List<MetaData1>? _metaData;
  String? _title;
  String? _description;
Product copyWith({  num? id,
  String? code,
  num? type,
  num? order,
  num? price,
  num? duration,
  num? trial,
  num? status,
  String? createdAt,
  String? updatedAt,
  List<MetaData1>? metaData,
  String? title,
  String? description,
}) => Product(  id: id ?? _id,
  code: code ?? _code,
  type: type ?? _type,
  order: order ?? _order,
  price: price ?? _price,
  duration: duration ?? _duration,
  trial: trial ?? _trial,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  metaData: metaData ?? _metaData,
  title: title ?? _title,
  description: description ?? _description,
);
  num? get id => _id;
  String? get code => _code;
  num? get type => _type;
  num? get order => _order;
  num? get price => _price;
  num? get duration => _duration;
  num? get trial => _trial;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<MetaData1>? get metaData => _metaData;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['type'] = _type;
    map['order'] = _order;
    map['price'] = _price;
    map['duration'] = _duration;
    map['trial'] = _trial;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_metaData != null) {
      map['metaData'] = _metaData?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}

/// mobile : "8888888888"
/// message : "Hello There"

MetaData1 metaDataFromJson(String str) => MetaData1.fromJson(json.decode(str));
String metaDataToJson(MetaData1 data) => json.encode(data.toJson());
/*
class MetaData {
  MetaData({
      String? mobile, 
      String? message,}){
    _mobile = mobile;
    _message = message;
}

  MetaData.fromJson(dynamic json) {
    _mobile = json['mobile'];
    _message = json['message'];
  }
  String? _mobile;
  String? _message;
MetaData copyWith({  String? mobile,
  String? message,
}) => MetaData(  mobile: mobile ?? _mobile,
  message: message ?? _message,
);
  String? get mobile => _mobile;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    map['message'] = _message;
    return map;
  }

}*/
