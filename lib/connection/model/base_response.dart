import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final String? error;
  final String? message;
  final String? status;
  final int? code;

  BaseResponse({
    this.error,
    this.message,
    this.status,
    this.code,
  });
  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
