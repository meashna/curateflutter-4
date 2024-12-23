import 'HealthLogData.dart';
import 'dart:convert';

/// data : [{"id":4,"code":"hl-4","userId":53,"type":"1","periodCycleFrom":"2023-01-02T12:18:55.000Z","periodCycleTo":"2023-05-02T12:18:55.000Z","periodFlowId":1,"weight":null,"waist":null,"status":1,"createdAt":"2023-05-22T12:11:39.000Z","updatedAt":"2023-05-22T12:11:39.000Z","deletedAt":null,"periodFlow":{"id":1,"order":1,"status":1,"title":"Very less"}}]

HealthLogResponse healthLogResponseFromJson(String str) => HealthLogResponse.fromJson(json.decode(str));
String healthLogResponseToJson(HealthLogResponse data) => json.encode(data.toJson());
class HealthLogResponse {
  HealthLogResponse({
    num? totalRecords,
    num? totalPage,
    num? page,
    num? perPage,
    List<HealthLogData>? data,}){
    _totalRecords = totalRecords;
    _totalPage = totalPage;
    _page = page;
    _perPage = perPage;
    _data = data;
}

  HealthLogResponse.fromJson(dynamic json) {
    _totalRecords = json['totalRecords'];
    _totalPage = json['totalPage'];
    _page = json['page'];
    _perPage = json['perPage'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HealthLogData.fromJson(v));
      });
    }
  }
  num? _totalRecords;
  num? _totalPage;
  num? _page;
  num? _perPage;
  List<HealthLogData>? _data;
HealthLogResponse copyWith({   num? totalRecords,
  num? totalPage,
  num? page,
  num? perPage,
  List<HealthLogData>? data,
}) => HealthLogResponse(
  totalRecords: totalRecords ?? _totalRecords,
  totalPage: totalPage ?? _totalPage,
  page: page ?? _page,
  perPage: perPage ?? _perPage,
  data: data ?? _data,
);

  List<HealthLogData>? get data => _data;
  num? get totalRecords => _totalRecords;
  num? get totalPage => _totalPage;
  num? get page => _page;
  num? get perPage => _perPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRecords'] = _totalRecords;
    map['totalPage'] = _totalPage;
    map['page'] = _page;
    map['perPage'] = _perPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}