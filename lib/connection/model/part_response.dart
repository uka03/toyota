import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'part_response.g.dart';

@JsonSerializable()
class PartResponse extends BaseResponse {
  List<PartResponseData>? data;

  PartResponse({
    this.data,
    super.status,
    super.message,
    super.error,
    super.code,
  });

  factory PartResponse.fromJson(Map<String, dynamic> json) => _$PartResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PartResponseToJson(this);
}

@JsonSerializable()
class PartResponseData {
  final int? id;
  final String? name;
  @JsonKey(name: "default_code")
  final String? defaultCode;
  final String? image;
  final String? price;
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

  PartResponseData({this.id, this.name, this.defaultCode, this.image, this.price});
  factory PartResponseData.fromJson(Map<String, dynamic> json) => _$PartResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$PartResponseDataToJson(this);
}
