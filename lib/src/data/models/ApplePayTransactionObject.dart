import 'dart:convert';
/// data : [{"transactionId":"2000000434991109","originalTransactionId":"2000000434991109","bundleId":"com.curate.curate","productId":"com.curate.TestConsumable","purchaseDate":1697187261000,"originalPurchaseDate":1697187261000,"quantity":1,"type":"Consumable","inAppOwnershipType":"PURCHASED","signedDate":1697543735906,"environment":"Sandbox","transactionReason":"PURCHASE","storefront":"IND","storefrontId":"143467"}]

ApplePayTransactionObject applePayTransactionObjectFromJson(String str) => ApplePayTransactionObject.fromJson(json.decode(str));
String applePayTransactionObjectToJson(ApplePayTransactionObject data) => json.encode(data.toJson());
class ApplePayTransactionObject {
  ApplePayTransactionObject({
      List<Data>? data,
  int? flag}){
    _data = data;
}

  ApplePayTransactionObject.fromJson(dynamic json) {
  /*  if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }*/
    _flag = json["flag"];}
  List<Data>? _data;
  int? _flag;
ApplePayTransactionObject copyWith({  List<Data>? data,int? flag
}) => ApplePayTransactionObject(
  data: data ?? _data,
  flag: flag ?? _flag,
);
  List<Data>? get data => _data;
  int? get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['flag'] = _flag;
    return map;
  }

}

/// transactionId : "2000000434991109"
/// originalTransactionId : "2000000434991109"
/// bundleId : "com.curate.curate"
/// productId : "com.curate.TestConsumable"
/// purchaseDate : 1697187261000
/// originalPurchaseDate : 1697187261000
/// quantity : 1
/// type : "Consumable"
/// inAppOwnershipType : "PURCHASED"
/// signedDate : 1697543735906
/// environment : "Sandbox"
/// transactionReason : "PURCHASE"
/// storefront : "IND"
/// storefrontId : "143467"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? transactionId, 
      String? originalTransactionId, 
      String? bundleId, 
      String? productId, 
      num? purchaseDate, 
      num? originalPurchaseDate, 
      num? quantity, 
      String? type, 
      String? inAppOwnershipType, 
      num? signedDate, 
      String? environment, 
      String? transactionReason, 
      String? storefront, 
      String? storefrontId,}){
    _transactionId = transactionId;
    _originalTransactionId = originalTransactionId;
    _bundleId = bundleId;
    _productId = productId;
    _purchaseDate = purchaseDate;
    _originalPurchaseDate = originalPurchaseDate;
    _quantity = quantity;
    _type = type;
    _inAppOwnershipType = inAppOwnershipType;
    _signedDate = signedDate;
    _environment = environment;
    _transactionReason = transactionReason;
    _storefront = storefront;
    _storefrontId = storefrontId;
}

  Data.fromJson(dynamic json) {
    _transactionId = json['transactionId'];
    _originalTransactionId = json['originalTransactionId'];
    _bundleId = json['bundleId'];
    _productId = json['productId'];
    _purchaseDate = json['purchaseDate'];
    _originalPurchaseDate = json['originalPurchaseDate'];
    _quantity = json['quantity'];
    _type = json['type'];
    _inAppOwnershipType = json['inAppOwnershipType'];
    _signedDate = json['signedDate'];
    _environment = json['environment'];
    _transactionReason = json['transactionReason'];
    _storefront = json['storefront'];
    _storefrontId = json['storefrontId'];
  }
  String? _transactionId;
  String? _originalTransactionId;
  String? _bundleId;
  String? _productId;
  num? _purchaseDate;
  num? _originalPurchaseDate;
  num? _quantity;
  String? _type;
  String? _inAppOwnershipType;
  num? _signedDate;
  String? _environment;
  String? _transactionReason;
  String? _storefront;
  String? _storefrontId;
Data copyWith({  String? transactionId,
  String? originalTransactionId,
  String? bundleId,
  String? productId,
  num? purchaseDate,
  num? originalPurchaseDate,
  num? quantity,
  String? type,
  String? inAppOwnershipType,
  num? signedDate,
  String? environment,
  String? transactionReason,
  String? storefront,
  String? storefrontId,
}) => Data(  transactionId: transactionId ?? _transactionId,
  originalTransactionId: originalTransactionId ?? _originalTransactionId,
  bundleId: bundleId ?? _bundleId,
  productId: productId ?? _productId,
  purchaseDate: purchaseDate ?? _purchaseDate,
  originalPurchaseDate: originalPurchaseDate ?? _originalPurchaseDate,
  quantity: quantity ?? _quantity,
  type: type ?? _type,
  inAppOwnershipType: inAppOwnershipType ?? _inAppOwnershipType,
  signedDate: signedDate ?? _signedDate,
  environment: environment ?? _environment,
  transactionReason: transactionReason ?? _transactionReason,
  storefront: storefront ?? _storefront,
  storefrontId: storefrontId ?? _storefrontId,
);
  String? get transactionId => _transactionId;
  String? get originalTransactionId => _originalTransactionId;
  String? get bundleId => _bundleId;
  String? get productId => _productId;
  num? get purchaseDate => _purchaseDate;
  num? get originalPurchaseDate => _originalPurchaseDate;
  num? get quantity => _quantity;
  String? get type => _type;
  String? get inAppOwnershipType => _inAppOwnershipType;
  num? get signedDate => _signedDate;
  String? get environment => _environment;
  String? get transactionReason => _transactionReason;
  String? get storefront => _storefront;
  String? get storefrontId => _storefrontId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transactionId'] = _transactionId;
    map['originalTransactionId'] = _originalTransactionId;
    map['bundleId'] = _bundleId;
    map['productId'] = _productId;
    map['purchaseDate'] = _purchaseDate;
    map['originalPurchaseDate'] = _originalPurchaseDate;
    map['quantity'] = _quantity;
    map['type'] = _type;
    map['inAppOwnershipType'] = _inAppOwnershipType;
    map['signedDate'] = _signedDate;
    map['environment'] = _environment;
    map['transactionReason'] = _transactionReason;
    map['storefront'] = _storefront;
    map['storefrontId'] = _storefrontId;
    return map;
  }

}