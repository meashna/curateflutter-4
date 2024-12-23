import 'dart:convert';
/// id : 10
/// password : "ae1285ab8aaaca3c8fb0f140c815a983"
/// email : "vishal.m@illuminz.com"
/// phoneNumber : null
/// countryCode : null
/// countryCodeValue : null
/// lastLoginTime : "2022-11-23T06:01:48.567Z"
/// updatedAt : "2022-11-23T06:01:48.568Z"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
    num? id,
    String? password,
    String? email,
    dynamic phoneNumber,
    dynamic countryCode,
    dynamic countryCodeValue,
    String? lastLoginTime,
    String? updatedAt,}){
    _id = id;
    _password = password;
    _email = email;
    _phoneNumber = phoneNumber;
    _countryCode = countryCode;
    _countryCodeValue = countryCodeValue;
    _lastLoginTime = lastLoginTime;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _password = json['password'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _countryCode = json['countryCode'];
    _countryCodeValue = json['countryCodeValue'];
    _lastLoginTime = json['lastLoginTime'];
    _updatedAt = json['updatedAt'];
  }
  num? _id;
  String? _password;
  String? _email;
  dynamic _phoneNumber;
  dynamic _countryCode;
  dynamic _countryCodeValue;
  String? _lastLoginTime;
  String? _updatedAt;
  User copyWith({  num? id,
    String? password,
    String? email,
    dynamic phoneNumber,
    dynamic countryCode,
    dynamic countryCodeValue,
    String? lastLoginTime,
    String? updatedAt,
  }) => User(  id: id ?? _id,
    password: password ?? _password,
    email: email ?? _email,
    phoneNumber: phoneNumber ?? _phoneNumber,
    countryCode: countryCode ?? _countryCode,
    countryCodeValue: countryCodeValue ?? _countryCodeValue,
    lastLoginTime: lastLoginTime ?? _lastLoginTime,
    updatedAt: updatedAt ?? _updatedAt,
  );
  num? get id => _id;
  String? get password => _password;
  String? get email => _email;
  dynamic get phoneNumber => _phoneNumber;
  dynamic get countryCode => _countryCode;
  dynamic get countryCodeValue => _countryCodeValue;
  String? get lastLoginTime => _lastLoginTime;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['password'] = _password;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['countryCode'] = _countryCode;
    map['countryCodeValue'] = _countryCodeValue;
    map['lastLoginTime'] = _lastLoginTime;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}