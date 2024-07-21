// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      data: json['data'] == null
          ? null
          : ProfileResponseData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

ProfileResponseData _$ProfileResponseDataFromJson(Map<String, dynamic> json) =>
    ProfileResponseData(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      vat: json['vat'] as String?,
    );

Map<String, dynamic> _$ProfileResponseDataToJson(
        ProfileResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'mobile': instance.mobile,
      'email': instance.email,
      'vat': instance.vat,
    };
