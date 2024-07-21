import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse extends BaseResponse {
  final List<CategoryResponseData>? data;

  CategoryResponse({
    this.data,
    super.status,
    super.message,
    super.code,
    super.error,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoryResponseData {
  final int? id;
  final String? name;
  final bool? attach;

  CategoryResponseData({
    this.id,
    this.name,
    this.attach,
  });
  factory CategoryResponseData.fromJson(Map<String, dynamic> json) => _$CategoryResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseDataToJson(this);
}
