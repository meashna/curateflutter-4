import 'dart:convert';
/// isPendingAssessment : false

AssessmentStatusDto assessmentStatusDtoFromJson(String str) => AssessmentStatusDto.fromJson(json.decode(str));
String assessmentStatusDtoToJson(AssessmentStatusDto data) => json.encode(data.toJson());
class AssessmentStatusDto {
  AssessmentStatusDto({
      bool? isPendingAssessment,}){
    _isPendingAssessment = isPendingAssessment;
}

  AssessmentStatusDto.fromJson(dynamic json) {
    _isPendingAssessment = json['isPendingAssessment'];
  }
  bool? _isPendingAssessment;
AssessmentStatusDto copyWith({  bool? isPendingAssessment,
}) => AssessmentStatusDto(  isPendingAssessment: isPendingAssessment ?? _isPendingAssessment,
);
  bool? get isPendingAssessment => _isPendingAssessment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isPendingAssessment'] = _isPendingAssessment;
    return map;
  }

}