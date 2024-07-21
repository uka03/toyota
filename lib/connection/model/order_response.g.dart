// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

OrderResponseData _$OrderResponseDataFromJson(Map<String, dynamic> json) =>
    OrderResponseData(
      id: (json['id'] as num?)?.toInt(),
      startDate: json['start_date'] as String?,
      typeTimeTotal: json['type_time_total'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$OrderResponseDataToJson(OrderResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.startDate,
      'type_time_total': instance.typeTimeTotal,
      'state': instance.state,
    };
