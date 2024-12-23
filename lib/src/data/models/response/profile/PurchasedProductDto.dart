import 'dart:convert';

/// id : 2
/// type : 1
/// price : 2400
/// duration : 90
/// createdAt : "2023-05-04T07:20:28.000Z"
/// updatedAt : "2023-05-04T07:20:28.000Z"

PurchasedProductDto purchasedProductDtoFromJson(String str) => PurchasedProductDto.fromJson(json.decode(str));
String purchasedProductDtoToJson(PurchasedProductDto data) => json.encode(data.toJson());
class PurchasedProductDto {
  PurchasedProductDto({
      num? id, 
      num? type, 
      num? price, 
      num? duration, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _type = type;
    _price = price;
    _duration = duration;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PurchasedProductDto.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _price = json['price'];
    _duration = json['duration'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  num? _type;
  num? _price;
  num? _duration;
  String? _createdAt;
  String? _updatedAt;
PurchasedProductDto copyWith({  num? id,
  num? type,
  num? price,
  num? duration,
  String? createdAt,
  String? updatedAt,
}) => PurchasedProductDto(  id: id ?? _id,
  type: type ?? _type,
  price: price ?? _price,
  duration: duration ?? _duration,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get type => _type;
  num? get price => _price;
  num? get duration => _duration;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['price'] = _price;
    map['duration'] = _duration;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}