import 'dart:convert';

/// id : 84
/// countryCode : "+91"
/// mobile : "5454545456"

PhoneNoDto phoneNoDtoFromJson(String str) => PhoneNoDto.fromJson(json.decode(str));
String phoneNoDtoToJson(PhoneNoDto data) => json.encode(data.toJson());
class PhoneNoDto {
  PhoneNoDto({
      num? id, 
      String? countryCode, 
      String? countryName,
      String? code,
      String? mobile,}){
    _id = id;
    _countryCode = countryCode;
    _code = code;
    _countryName = countryName;
    _mobile = mobile;
}

  PhoneNoDto.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['countryCode'];
    _code = json['code'];
    _countryName = json['countryName'];
    _mobile = json['mobile'];
  }
  num? _id;
  String? _countryCode;
  String? _countryName;
  String? _code;
  String? _mobile;
PhoneNoDto copyWith({  num? id,
  String? countryCode,
  String? countryName,
  String? code,
  String? mobile,
}) => PhoneNoDto(  id: id ?? _id,
  countryCode: countryCode ?? _countryCode,
  countryName: countryName ?? _countryName,
  code: code ?? _code,
  mobile: mobile ?? _mobile,
);
  num? get id => _id;
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get code => _code;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countryCode'] = _countryCode;
    map['countryName'] = _countryName;
    map['code'] = _code;
    map['mobile'] = _mobile;
    return map;
  }

}