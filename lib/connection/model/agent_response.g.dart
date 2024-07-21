// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentResponse _$AgentResponseFromJson(Map<String, dynamic> json) =>
    AgentResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AgentResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AgentResponseToJson(AgentResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

AgentResponseData _$AgentResponseDataFromJson(Map<String, dynamic> json) =>
    AgentResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
      social: json['social'] as String?,
      web: json['web'] as String?,
    );

Map<String, dynamic> _$AgentResponseDataToJson(AgentResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'phone': instance.phone,
      'social': instance.social,
      'web': instance.web,
    };
