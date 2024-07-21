import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse extends BaseResponse {
  final List<OrderResponseData>? data;
  OrderResponse({
    this.data,
    super.status,
    super.message,
    super.error,
    super.code,
  });
  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderResponseData {
  final int? id;
  @JsonKey(name: "start_date")
  final String? startDate;
  @JsonKey(name: "type_time_total")
  final String? typeTimeTotal;
  final String? state;

  OrderResponseData({
    this.id,
    this.startDate,
    this.typeTimeTotal,
    this.state,
  });
  factory OrderResponseData.fromJson(Map<String, dynamic> json) => _$OrderResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseDataToJson(this);
}
