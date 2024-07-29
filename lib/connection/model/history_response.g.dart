// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HistoryResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      error: json['error'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

HistoryResponseData _$HistoryResponseDataFromJson(Map<String, dynamic> json) =>
    HistoryResponseData(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$HistoryResponseDataToJson(
        HistoryResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'description': instance.description,
      'url': instance.url,
    };
