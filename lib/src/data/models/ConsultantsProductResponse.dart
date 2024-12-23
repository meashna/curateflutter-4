import 'dart:convert';
/// product : {"id":5,"code":"5","type":4,"order":5,"price":99,"duration":-1,"trial":-1,"status":1,"createdAt":"2023-05-04T07:20:28.000Z","updatedAt":"2023-05-04T07:20:28.000Z","title":"Talk to our experts","description":"Talk to our experts"}

ConsultantsProductResponse consultantsProductResponseFromJson(String str) => ConsultantsProductResponse.fromJson(json.decode(str));
String consultantsProductResponseToJson(ConsultantsProductResponse data) => json.encode(data.toJson());
class ConsultantsProductResponse {
  ConsultantsProductResponse({
      Product? product,}){
    _product = product;
}

  ConsultantsProductResponse.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  Product? _product;
ConsultantsProductResponse copyWith({  Product? product,
}) => ConsultantsProductResponse(  product: product ?? _product,
);
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
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
    List<String>? metaDataContent,
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
    _metaData = metaData;
    _metaDataContent = metaDataContent;
    _updatedAt = updatedAt;
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
    _metaDataContent = json['metaDataContent'] != null ? json['metaDataContent'].cast<String>() : [];
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
  List<String>? _metaDataContent;
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
  List<MetaData1>? metaData,
  List<String>? metaDataContent,
  String? updatedAt,
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
  metaData: metaData ?? _metaData,
  metaDataContent: metaDataContent ?? _metaDataContent,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
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
  List<MetaData1>? get metaData => _metaData;
  List<String>? get metaDataContent => _metaDataContent;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
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
    map['title'] = _title;
    if (_metaData != null) {
      map['metaData'] = _metaData?.map((v) => v.toJson()).toList();
    }
    map['metaDataContent'] = _metaDataContent;
    map['description'] = _description;
    return map;
  }
}



/// mobile : "8888888888"
/// message : "Hello There"

MetaData1 metaDataFromJson(String str) => MetaData1.fromJson(json.decode(str));
String metaDataToJson(MetaData1 data) => json.encode(data.toJson());
class MetaData1 {
  MetaData1({
    String? mobile,
    String? message,
    String? whatsappLink}
      ){
    _mobile = mobile;
    _message = message;
    _whatsappLink=whatsappLink;
  }

  MetaData1.fromJson(dynamic json) {
    _mobile = json['mobile'];
    _message = json['message'];
    _whatsappLink = json['whatsappLink'];
  }
  String? _mobile;
  String? _message;
  String? _whatsappLink;

  MetaData1 copyWith({  String? mobile,
    String? message,String? whatsappLink
  }) => MetaData1(  mobile: mobile ?? _mobile,
    message: message ?? _message,
    whatsappLink: whatsappLink ?? _whatsappLink
  );
  String? get mobile => _mobile;
  String? get message => _message;
  String? get whatsappLink => _whatsappLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    map['message'] = _message;
    map['whatsappLink'] = _whatsappLink;
    return map;
  }

}