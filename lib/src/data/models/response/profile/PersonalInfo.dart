import 'dart:convert';

import 'package:curate/src/data/models/PhoneNoDto.dart';
import 'package:curate/src/data/models/response/profile/PurchasedProductDto.dart';

/// id : 34
/// userId : 48
/// name : "Harsh"
/// dob : "1996-05-08"
/// height : 79.55
/// weight : 134.37
/// waist : 60
/// wellBeingScore : 81
/// productStatus : null
/// productId : null
/// productStart : null
/// productDuration : null
/// trialStart : "2023-05-13T05:09:12.000Z"
/// trialDuration : 7
/// purchaseCount : 0
/// createdAt : "2023-05-13T05:09:12.000Z"
/// updatedAt : "2023-05-24T08:29:36.000Z"
/// deletedAt : null

PersonalInfo personalInfoFromJson(String str) => PersonalInfo.fromJson(json.decode(str));
String personalInfoToJson(PersonalInfo data) => json.encode(data.toJson());
class PersonalInfo {
  PersonalInfo({
      num? id, 
      num? userId, 
      String? name, 
      //String? uuid,
      String? dob,
      num? height, 
      num? weight, 
      num? waist,
      bool? isExpiry,
      num? wellBeingScore,
      dynamic productStatus, 
      dynamic productId, 
      dynamic productStart, 
      dynamic productDuration, 
      String? trialStart, 
      num? trialDuration, 
      num? purchaseCount, 
      String? createdAt, 
      String? updatedAt,
      PhoneNoDto? user,
      PurchasedProductDto? product,
      dynamic deletedAt,}){
    _id = id;
    _userId = userId;
    _name = name;
    //_uuid = uuid;
    _dob = dob;
    _height = height;
    _weight = weight;
    _waist = waist;
    _wellBeingScore = wellBeingScore;
    _productStatus = productStatus;
    _productId = productId;
    _productStart = productStart;
    _productDuration = productDuration;
    _trialStart = trialStart;
    _trialDuration = trialDuration;
    _purchaseCount = purchaseCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _user = user;
    _product=product;
}

  PersonalInfo.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _name = json['name'];
    //_uuid = json['uuid'];
    _dob = json['dob'];
    _height = json['height'];
    _weight = json['weight'];
    _waist = json['waist'];
    _wellBeingScore = json['wellBeingScore'];
    _productStatus = json['productStatus'];
    _productId = json['productId'];
    _isExpiry = json['isExpiry'];
    _productStart = json['productStart'];
    _productDuration = json['productDuration'];
    _trialStart = json['trialStart'];
    _trialDuration = json['trialDuration'];
    _purchaseCount = json['purchaseCount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deletedAt = json['deletedAt'];
    _user = json['user'] != null ? PhoneNoDto.fromJson(json['user']) : null;
      _product = json['product'] != null ? PurchasedProductDto.fromJson(json['product']) : null;
  }
  num? _id;
  num? _userId;
  String? _name;
  //String? _uuid;
  String? _dob;
  num? _height;
  num? _weight;
  num? _waist;
  bool? _isExpiry;
  num? _wellBeingScore;
  dynamic _productStatus;
  dynamic _productId;
  dynamic _productStart;
  dynamic _productDuration;
  String? _trialStart;
  num? _trialDuration;
  num? _purchaseCount;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  PhoneNoDto? _user;
  PurchasedProductDto? _product;

PersonalInfo copyWith({  num? id,
  num? userId,
  String? name,
  //String? uuid,
  String? dob,
  num? height,
  num? weight,
  num? waist,
  bool? isExpiry,
  num? wellBeingScore,
  dynamic productStatus,
  dynamic productId,
  dynamic productStart,
  dynamic productDuration,
  String? trialStart,
  num? trialDuration,
  num? purchaseCount,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  PhoneNoDto? user,
  PurchasedProductDto? product
}) => PersonalInfo(  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  //uuid: uuid ?? _uuid,
  dob: dob ?? _dob,
  height: height ?? _height,
  weight: weight ?? _weight,
  waist: waist ?? _waist,
  isExpiry: isExpiry ?? _isExpiry,
  wellBeingScore: wellBeingScore ?? _wellBeingScore,
  productStatus: productStatus ?? _productStatus,
  productId: productId ?? _productId,
  productStart: productStart ?? _productStart,
  productDuration: productDuration ?? _productDuration,
  trialStart: trialStart ?? _trialStart,
  trialDuration: trialDuration ?? _trialDuration,
  purchaseCount: purchaseCount ?? _purchaseCount,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  user: user ?? _user,
  product: product ?? _product,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get name => _name;
  //String? get uuid => _uuid;
  String? get dob => _dob;
  num? get height => _height;
  num? get weight => _weight;
  bool? get isExpiry => _isExpiry;
  num? get waist => _waist;
  num? get wellBeingScore => _wellBeingScore;
  dynamic get productStatus => _productStatus;
  dynamic get productId => _productId;
  dynamic get productStart => _productStart;
  dynamic get productDuration => _productDuration;
  String? get trialStart => _trialStart;
  num? get trialDuration => _trialDuration;
  num? get purchaseCount => _purchaseCount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  PhoneNoDto? get user => _user;
  PurchasedProductDto? get product => _product;
  dynamic get deletedAt => _deletedAt;

  set user(PhoneNoDto?  user) {
    _user = user;
  }

  set wellBeingScore(num?  wellBeingScore) {
    _wellBeingScore = wellBeingScore;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['name'] = _name;
    //map['uuid'] = _uuid;
    map['dob'] = _dob;
    map['height'] = _height;
    map['weight'] = _weight;
    map['waist'] = _waist;
    map['isExpiry'] = _isExpiry;
    map['wellBeingScore'] = _wellBeingScore;
    map['productStatus'] = _productStatus;
    map['productId'] = _productId;
    map['productStart'] = _productStart;
    map['productDuration'] = _productDuration;
    map['trialStart'] = _trialStart;
    map['trialDuration'] = _trialDuration;
    map['purchaseCount'] = _purchaseCount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    map['user'] = _user;
    map['product'] = _product;
    return map;
  }

}