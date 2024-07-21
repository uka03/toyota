// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      data: json['data'] == null
          ? null
          : LoginResponseData.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as String?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };
