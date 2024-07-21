// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) =>
    ServiceResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceResponseToJson(ServiceResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

ServiceResponseData _$ServiceResponseDataFromJson(Map<String, dynamic> json) =>
    ServiceResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      spendTime: (json['spend_time'] as num?)?.toDouble(),
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$ServiceResponseDataToJson(
        ServiceResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'spend_time': instance.spendTime,
      'display_name': instance.displayName,
    };
