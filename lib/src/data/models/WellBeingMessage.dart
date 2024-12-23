import 'dart:convert';
/// id : 3
/// title : "Congrats, your score is getting better!"
/// description : null

WellBeingMessage wellBeingMessageFromJson(String str) => WellBeingMessage.fromJson(json.decode(str));
String wellBeingMessageToJson(WellBeingMessage data) => json.encode(data.toJson());
class WellBeingMessage {
  WellBeingMessage({
      num? id, 
      String? title, 
      dynamic description,}){
    _id = id;
    _title = title;
    _description = description;
}

  WellBeingMessage.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
  }
  num? _id;
  String? _title;
  dynamic _description;
WellBeingMessage copyWith({  num? id,
  String? title,
  dynamic description,
}) => WellBeingMessage(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
);
  num? get id => _id;
  String? get title => _title;
  dynamic get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}