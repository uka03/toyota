import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'history_response.g.dart';

@JsonSerializable()
class HistoryResponse extends BaseResponse {
  final List<HistoryResponseData>? data;

  HistoryResponse({
    required this.data,
    super.message,
    super.code,
    super.error,
    super.status,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => _$HistoryResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}

@JsonSerializable()
class HistoryResponseData {
  final int? id;
  final String? date;
  final String? description;
  final String? url;

  HistoryResponseData({
    required this.id,
    required this.date,
    required this.description,
    required this.url,
  });
  factory HistoryResponseData.fromJson(Map<String, dynamic> json) => _$HistoryResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryResponseDataToJson(this);
}
