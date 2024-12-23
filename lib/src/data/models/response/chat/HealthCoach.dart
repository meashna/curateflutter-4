import 'dart:convert';

/// id : 2
/// countryCode : "+91"
/// mobile : "9653005599"
/// name : "Ashutosh"

HealthCoach healthCoachFromJson(String str) => HealthCoach.fromJson(json.decode(str));
String healthCoachToJson(HealthCoach data) => json.encode(data.toJson());
class HealthCoach {
  HealthCoach({
      num? id, 
      String? countryCode, 
      String? mobile, 
      String? name,}){
    _id = id;
    _countryCode = countryCode;
    _mobile = mobile;
    _name = name;
}

  HealthCoach.fromJson(dynamic json) {
    _id = json['id'];
    _countryCode = json['countryCode'];
    _mobile = json['mobile'];
    _name = json['name'];
  }
  num? _id;
  String? _countryCode;
  String? _mobile;
  String? _name;
HealthCoach copyWith({  num? id,
  String? countryCode,
  String? mobile,
  String? name,
}) => HealthCoach(  id: id ?? _id,
  countryCode: countryCode ?? _countryCode,
  mobile: mobile ?? _mobile,
  name: name ?? _name,
);
  num? get id => _id;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countryCode'] = _countryCode;
    map['mobile'] = _mobile;
    map['name'] = _name;
    return map;
  }

}