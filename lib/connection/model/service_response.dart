import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';
part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse extends BaseResponse {
  final List<ServiceResponseData>? data;
  ServiceResponse({
    this.data,
    super.status,
    super.message,
    super.error,
    super.code,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class ServiceResponseData {
  final int? id;
  final String? name;
  @JsonKey(name: "spend_time")
  final double? spendTime;
  @JsonKey(name: "display_name")
  final String? displayName;

  ServiceResponseData({
    this.id,
    this.name,
    this.spendTime,
    this.displayName,
  });
  factory ServiceResponseData.fromJson(Map<String, dynamic> json) => _$ServiceResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseDataToJson(this);
}
