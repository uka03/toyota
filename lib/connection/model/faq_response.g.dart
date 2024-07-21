// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQResponse _$FAQResponseFromJson(Map<String, dynamic> json) => FAQResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FaqResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FAQResponseToJson(FAQResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

FaqResponseData _$FaqResponseDataFromJson(Map<String, dynamic> json) =>
    FaqResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      answer: json['answer'] as String?,
      sequence: (json['sequence'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FaqResponseDataToJson(FaqResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'answer': instance.answer,
      'sequence': instance.sequence,
    };
