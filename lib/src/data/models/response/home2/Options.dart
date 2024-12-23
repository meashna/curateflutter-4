import 'dart:convert';

/// id : 40
/// score : 4
/// status : 1
/// optionTitle : "Joyful"
/// optionDescription : null

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));
String optionsToJson(Options data) => json.encode(data.toJson());
class Options {
  Options({
      num? id, 
      num? score, 
      num? status,
      bool? selected=false,
      String? optionTitle,
      dynamic optionDescription,}){
    _id = id;
    _score = score;
    _status = status;
    _optionTitle = optionTitle;
    _selected=selected;
    _optionDescription = optionDescription;
}

  Options.fromJson(dynamic json) {
    _id = json['id'];
    _score = json['score'];
    _status = json['status'];
    _optionTitle = json['optionTitle'];
    _selected=json['selected'];
    _optionDescription = json['optionDescription'];
  }
  num? _id;
  num? _score;
  num? _status;
  bool? _selected;
  String? _optionTitle;
  dynamic _optionDescription;
Options copyWith({  num? id,
  num? score,
  num? status,
  bool? selected,
  String? optionTitle,
  dynamic optionDescription,
}) => Options(  id: id ?? _id,
  score: score ?? _score,
  status: status ?? _status,
  selected: selected??_selected,
  optionTitle: optionTitle ?? _optionTitle,
  optionDescription: optionDescription ?? _optionDescription,
);
  num? get id => _id;
  num? get score => _score;
  num? get status => _status;
  bool? get selected => _selected;
  set selected(bool? selected) {
    _selected = selected;
  }

  String? get optionTitle => _optionTitle;
  dynamic get optionDescription => _optionDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['score'] = _score;
    map['status'] = _status;
    map['selected'] = _selected;
    map['optionTitle'] = _optionTitle;
    map['optionDescription'] = _optionDescription;
    return map;
  }

}