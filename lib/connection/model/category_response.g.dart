// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

CategoryResponseData _$CategoryResponseDataFromJson(
        Map<String, dynamic> json) =>
    CategoryResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      attach: json['attach'] as bool?,
    );

Map<String, dynamic> _$CategoryResponseDataToJson(
        CategoryResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attach': instance.attach,
    };
