/// id : 4
/// filePath : "http://54.176.169.179:3020/attachment/5b3118d0-fa2d-11ed-bb21-1d0038dcda76.svg"

class QuestionImageDto {
  QuestionImageDto({
      num? id, 
      String? filePath,}){
    _id = id;
    _filePath = filePath;
}

  QuestionImageDto.fromJson(dynamic json) {
    _id = json['id'];
    _filePath = json['filePath'];
  }
  num? _id;
  String? _filePath;
QuestionImageDto copyWith({  num? id,
  String? filePath,
}) => QuestionImageDto(  id: id ?? _id,
  filePath: filePath ?? _filePath,
);
  num? get id => _id;
  String? get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['filePath'] = _filePath;
    return map;
  }

}