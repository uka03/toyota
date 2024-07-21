// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarResponse _$CarResponseFromJson(Map<String, dynamic> json) => CarResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CarResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CarResponseToJson(CarResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
    };

CarResponseData _$CarResponseDataFromJson(Map<String, dynamic> json) =>
    CarResponseData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      plateNumber: json['plate_number'] as String?,
      salePrice: json['sale_price'] as String?,
      imageMedium: json['image_medium'] as bool?,
      modelName: json['model_name'] as String?,
      description: json['description'] as String?,
      yearString: json['yearString'] as String?,
      odoMeter: json['odo_meter'] as String?,
      colorName: json['color_name'] as String?,
      manufacturedYear: json['manufactured_year'] as String?,
      engineCapacity: json['engine_capacity'] as String?,
    );

Map<String, dynamic> _$CarResponseDataToJson(CarResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'plate_number': instance.plateNumber,
      'sale_price': instance.salePrice,
      'image_medium': instance.imageMedium,
      'model_name': instance.modelName,
      'description': instance.description,
      'yearString': instance.yearString,
      'odo_meter': instance.odoMeter,
      'color_name': instance.colorName,
      'manufactured_year': instance.manufacturedYear,
      'engine_capacity': instance.engineCapacity,
    };
