import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';
part 'faq_response.g.dart';

@JsonSerializable()
class FAQResponse extends BaseResponse {
  final List<FaqResponseData>? data;
  FAQResponse({
    required this.data,
    super.message,
    super.status,
    super.error,
    super.code,
  });
  factory FAQResponse.fromJson(Map<String, dynamic> json) => _$FAQResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FAQResponseToJson(this);
}

@JsonSerializable()
class FaqResponseData {
  final int? id;
  final String? name;
  final String? answer;
  final int? sequence;

  FaqResponseData({
    required this.id,
    required this.name,
    required this.answer,
    required this.sequence,
  });
  factory FaqResponseData.fromJson(Map<String, dynamic> json) => _$FaqResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$FaqResponseDataToJson(this);
}
