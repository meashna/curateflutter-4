import 'dart:convert';

/// id : 42
/// score : 2
/// optionTitle : "Normal"
/// optionDescription : "Slow progress is better than no progress stay positive and never give up."

Option optionFromJson(String str) => Option.fromJson(json.decode(str));
String optionToJson(Option data) => json.encode(data.toJson());
class Option {
  Option({
      num? id, 
      num? score, 
      String? optionTitle, 
      String? optionDescription,}){
    _id = id;
    _score = score;
    _optionTitle = optionTitle;
    _optionDescription = optionDescription;
}

  Option.fromJson(dynamic json) {
    _id = json['id'];
    _score = json['score'];
    _optionTitle = json['optionTitle'];
    _optionDescription = json['optionDescription'];
  }
  num? _id;
  num? _score;
  String? _optionTitle;
  String? _optionDescription;
Option copyWith({  num? id,
  num? score,
  String? optionTitle,
  String? optionDescription,
}) => Option(  id: id ?? _id,
  score: score ?? _score,
  optionTitle: optionTitle ?? _optionTitle,
  optionDescription: optionDescription ?? _optionDescription,
);
  num? get id => _id;
  num? get score => _score;
  String? get optionTitle => _optionTitle;
  String? get optionDescription => _optionDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['score'] = _score;
    map['optionTitle'] = _optionTitle;
    map['optionDescription'] = _optionDescription;
    return map;
  }

}