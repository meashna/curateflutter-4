import 'dart:convert';
/// totalPages : 1
/// perPage : 20
/// languages : [{"id":5,"name":"Spanish","code":"es","countery":"Spain","counteryCode":"es"},{"id":4,"name":"German","code":"de","countery":"Germany","counteryCode":"de"},{"id":3,"name":"French","code":"fr","countery":"France","counteryCode":"fr"},{"id":1,"name":"English","code":"en","countery":"United States","counteryCode":"us"},{"id":2,"name":"Arabic","code":"ar","countery":"Saudi Arab","counteryCode":"sa"}]
/// totalRecords : 5

LanguageResponse languageResponseFromJson(String str) => LanguageResponse.fromJson(json.decode(str));
String languageResponseToJson(LanguageResponse data) => json.encode(data.toJson());
class LanguageResponse {
  LanguageResponse({
      num? totalPages, 
      num? perPage, 
      List<Languages>? languages, 
      num? totalRecords,}){
    _totalPages = totalPages;
    _perPage = perPage;
    _languages = languages;
    _totalRecords = totalRecords;
}

  LanguageResponse.fromJson(dynamic json) {
    _totalPages = json['totalPages'];
    _perPage = json['perPage'];
    if (json['languages'] != null) {
      _languages = [];
      json['languages'].forEach((v) {
        _languages?.add(Languages.fromJson(v));
      });
    }
    _totalRecords = json['totalRecords'];
  }
  num? _totalPages;
  num? _perPage;
  List<Languages>? _languages;
  num? _totalRecords;
LanguageResponse copyWith({  num? totalPages,
  num? perPage,
  List<Languages>? languages,
  num? totalRecords,
}) => LanguageResponse(  totalPages: totalPages ?? _totalPages,
  perPage: perPage ?? _perPage,
  languages: languages ?? _languages,
  totalRecords: totalRecords ?? _totalRecords,
);
  num? get totalPages => _totalPages;
  num? get perPage => _perPage;
  List<Languages>? get languages => _languages;
  num? get totalRecords => _totalRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalPages'] = _totalPages;
    map['perPage'] = _perPage;
    if (_languages != null) {
      map['languages'] = _languages?.map((v) => v.toJson()).toList();
    }
    map['totalRecords'] = _totalRecords;
    return map;
  }

}

/// id : 5
/// name : "Spanish"
/// code : "es"
/// countery : "Spain"
/// counteryCode : "es"

Languages languagesFromJson(String str) => Languages.fromJson(json.decode(str));
String languagesToJson(Languages data) => json.encode(data.toJson());
class Languages {
  Languages({
      num? id, 
      String? name, 
      String? code, 
      String? countery, 
      String? mobileCode,
      String? counteryCode,}){
    _id = id;
    _name = name;
    _code = code;
    _countery = countery;
    _mobileCode = mobileCode;
    _counteryCode = counteryCode;
}

  Languages.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _countery = json['countery'];
    _mobileCode = json['mobileCode'];
    _counteryCode = json['counteryCode'];
  }
  num? _id;
  String? _name;
  String? _code;
  String? _countery;
  String? _counteryCode;
  String? _mobileCode;
Languages copyWith({  num? id,
  String? name,
  String? code,
  String? countery,
  String? counteryCode,
  String? mobileCode,
}) => Languages(  id: id ?? _id,
  name: name ?? _name,
  code: code ?? _code,
  countery: countery ?? _countery,
  mobileCode: mobileCode ?? _mobileCode,
  counteryCode: counteryCode ?? _counteryCode,
);
  num? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get countery => _countery;
  String? get mobileCode => _mobileCode;
  String? get counteryCode => _counteryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['countery'] = _countery;
    map['mobileCode'] = _mobileCode;
    map['counteryCode'] = _counteryCode;
    return map;
  }

}