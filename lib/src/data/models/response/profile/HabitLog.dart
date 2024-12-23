import 'dart:convert';

/// nper : 100
/// mper : 42.857142857142854
/// fper : null

HabitLog habitLogFromJson(String str) => HabitLog.fromJson(json.decode(str));
String habitLogToJson(HabitLog data) => json.encode(data.toJson());
class HabitLog {
  HabitLog({
      num? nper, 
      num? mper, 
      dynamic fper,}){
    _nper = nper;
    _mper = mper;
    _fper = fper;
}

  HabitLog.fromJson(dynamic json) {
    _nper = json['nper'];
    _mper = json['mper'];
    _fper = json['fper'];
  }
  num? _nper;
  num? _mper;
  dynamic _fper;
HabitLog copyWith({  num? nper,
  num? mper,
  dynamic fper,
}) => HabitLog(  nper: nper ?? _nper,
  mper: mper ?? _mper,
  fper: fper ?? _fper,
);
  num? get nper => _nper;
  num? get mper => _mper;
  dynamic get fper => _fper;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nper'] = _nper;
    map['mper'] = _mper;
    map['fper'] = _fper;
    return map;
  }

}