// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartResponse _$PartResponseFromJson(Map<String, dynamic> json) => PartResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PartResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PartResponseToJson(PartResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

PartResponseData _$PartResponseDataFromJson(Map<String, dynamic> json) =>
    PartResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      defaultCode: json['default_code'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$PartResponseDataToJson(PartResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'default_code': instance.defaultCode,
      'image': instance.image,
      'price': instance.price,
    };
