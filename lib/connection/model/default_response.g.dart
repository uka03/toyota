// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultResponse _$DefaultResponseFromJson(Map<String, dynamic> json) =>
    DefaultResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : DefaultResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DefaultResponseToJson(DefaultResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

DefaultResponseData _$DefaultResponseDataFromJson(Map<String, dynamic> json) =>
    DefaultResponseData(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['body'] as String?,
      json['image'] as String?,
      json['description'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$DefaultResponseDataToJson(
        DefaultResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'body': instance.body,
      'image': instance.image,
      'description': instance.description,
      'url': instance.url,
    };
