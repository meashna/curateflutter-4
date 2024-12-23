/// id : 1
/// score : 0
/// status : 1
/// optionTitle : "Yes"
/// optionDescription : null

class OptionDto {
  OptionDto({
    num? id,
    num? score,
    num? status,
    String? optionTitle,
    bool? isSelected=false,
    dynamic optionDescription,
  }) {
    _id = id;
    _score = score;
    _status = status;
    _optionTitle = optionTitle;
    _optionDescription = optionDescription;
    _isSelected= isSelected;
  }

  OptionDto.fromJson(dynamic json) {
    _id = json['id'];
    _score = json['score'];
    _status = json['status'];
    _optionTitle = json['optionTitle'];
    _optionDescription = json['optionDescription'];
  }

  num? _id;
  num? _score;
  num? _status;
  String? _optionTitle;
  bool? _isSelected;
  dynamic _optionDescription;

  OptionDto copyWith({
    num? id,
    num? score,
    num? status,
    String? optionTitle,
    bool? isSelected,
    dynamic optionDescription,
  }) =>
      OptionDto(
        id: id ?? _id,
        score: score ?? _score,
        status: status ?? _status,
        optionTitle: optionTitle ?? _optionTitle,
        isSelected: isSelected ?? _isSelected,
        optionDescription: optionDescription ?? _optionDescription,
      );

  num? get id => _id;
  num? get score => _score;
  num? get status => _status;
  String? get optionTitle => _optionTitle;
  bool? get isSelected => _isSelected;


  set isSelected(bool? value) {
    _isSelected = value;
  }

  dynamic get optionDescription => _optionDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['score'] = _score;
    map['status'] = _status;
    map['optionTitle'] = _optionTitle;
    map['optionDescription'] = _optionDescription;
    return map;
  }
}
