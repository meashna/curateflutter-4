import 'dart:convert';

/// id : 35
/// day : 1
/// optionId : 41
/// userId : 2
/// createdAt : "2023-04-28T06:19:01.000Z"
/// score : 3

Moods moodsFromJson(String str) => Moods.fromJson(json.decode(str));
String moodsToJson(Moods data) => json.encode(data.toJson());
class Moods {
  Moods({
      num? id, 
      num? day, 
      num? optionId, 
      num? userId, 
      String? createdAt, 
      num? score,}){
    _id = id;
    _day = day;
    _optionId = optionId;
    _userId = userId;
    _createdAt = createdAt;
    _score = score;
}

  Moods.fromJson(dynamic json) {
    _id = json['id'];
    _day = json['day'];
    _optionId = json['optionId'];
    _userId = json['userId'];
    _createdAt = json['createdAt'];
    _score = json['score'];
  }
  num? _id;
  num? _day;
  num? _optionId;
  num? _userId;
  String? _createdAt;
  num? _score;
Moods copyWith({  num? id,
  num? day,
  num? optionId,
  num? userId,
  String? createdAt,
  num? score,
}) => Moods(  id: id ?? _id,
  day: day ?? _day,
  optionId: optionId ?? _optionId,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  score: score ?? _score,
);
  num? get id => _id;
  num? get day => _day;
  num? get optionId => _optionId;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  num? get score => _score;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['day'] = _day;
    map['optionId'] = _optionId;
    map['userId'] = _userId;
    map['createdAt'] = _createdAt;
    map['score'] = _score;
    return map;
  }

}