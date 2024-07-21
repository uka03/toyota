import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'car_response.g.dart';

@JsonSerializable()
class CarResponse extends BaseResponse {
  final List<CarResponseData>? data;
  CarResponse({
    this.data,
    super.status,
    super.message,
    super.error,
    super.code,
  });
  factory CarResponse.fromJson(Map<String, dynamic> json) => _$CarResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CarResponseToJson(this);
}

@JsonSerializable()
class CarResponseData {
  final int? id;
  final String? name;
  final String? image;
  @JsonKey(name: "plate_number")
  final String? plateNumber;
  @JsonKey(name: "sale_price")
  final String? salePrice;
  @JsonKey(name: "image_medium")
  final bool? imageMedium;
  @JsonKey(name: "model_name")
  final String? modelName;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "yearString")
  final String? yearString;
  @JsonKey(name: "odo_meter")
  final String? odoMeter;
  @JsonKey(name: "color_name")
  final String? colorName;
  @JsonKey(name: "manufactured_year")
  final String? manufacturedYear;
  @JsonKey(name: "engine_capacity")
  final String? engineCapacity;
  @JsonKey(includeToJson: false, includeFromJson: false)
  Image? get imageWidget {
    if (image?.isNotEmpty == true) {
      return Image.memory(
        base64Decode(image ?? ""),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  CarResponseData({
    this.id,
    this.name,
    this.image,
    this.plateNumber,
    this.salePrice,
    this.imageMedium,
    this.modelName,
    this.description,
    this.yearString,
    this.odoMeter,
    this.colorName,
    this.manufacturedYear,
    this.engineCapacity,
  });

  factory CarResponseData.fromJson(Map<String, dynamic> json) => _$CarResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$CarResponseDataToJson(this);
}
