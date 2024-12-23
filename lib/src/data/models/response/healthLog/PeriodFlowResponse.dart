import 'PeriodsFlows.dart';
import 'dart:convert';

/// periodsFlows : [{"id":1,"order":1,"status":1,"createdAt":"2023-05-22T07:28:50.000Z","updatedAt":"2023-05-22T07:28:50.000Z","title":"Very less"},{"id":2,"order":2,"status":1,"createdAt":"2023-05-22T07:28:50.000Z","updatedAt":"2023-05-22T07:28:50.000Z","title":"Normal"},{"id":3,"order":3,"status":1,"createdAt":"2023-05-22T07:28:50.000Z","updatedAt":"2023-05-22T07:28:50.000Z","title":"Heavy bleeding"},{"id":4,"order":4,"status":1,"createdAt":"2023-05-22T07:28:50.000Z","updatedAt":"2023-05-22T07:28:50.000Z","title":"Pass clots with my bleeding"},{"id":5,"order":5,"status":1,"createdAt":"2023-05-22T07:28:50.000Z","updatedAt":"2023-05-22T07:28:50.000Z","title":"Heavy bleeding with clots"}]

PeriodFlowResponse periodFlowResponseFromJson(String str) => PeriodFlowResponse.fromJson(json.decode(str));
String periodFlowResponseToJson(PeriodFlowResponse data) => json.encode(data.toJson());
class PeriodFlowResponse {
  PeriodFlowResponse({
      List<PeriodsFlows>? periodsFlows,}){
    _periodsFlows = periodsFlows;
}

  PeriodFlowResponse.fromJson(dynamic json) {
    if (json['periodsFlows'] != null) {
      _periodsFlows = [];
      json['periodsFlows'].forEach((v) {
        _periodsFlows?.add(PeriodsFlows.fromJson(v));
      });
    }
  }
  List<PeriodsFlows>? _periodsFlows;
PeriodFlowResponse copyWith({  List<PeriodsFlows>? periodsFlows,
}) => PeriodFlowResponse(  periodsFlows: periodsFlows ?? _periodsFlows,
);
  List<PeriodsFlows>? get periodsFlows => _periodsFlows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_periodsFlows != null) {
      map['periodsFlows'] = _periodsFlows?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}