import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'default_response.g.dart';

@JsonSerializable()
class DefaultResponse extends BaseResponse {
  final List<DefaultResponseData?>? data;
  DefaultResponse({
    this.data,
    super.error,
    super.message,
    super.status,
    super.code,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => _$DefaultResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DefaultResponseToJson(this);
}

@JsonSerializable()
class DefaultResponseData {
  final int id;
  final String name;
  final String? body;
  final String? image;
  final String? description;
  final String? url;
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

  DefaultResponseData(
    this.id,
    this.name,
    this.body,
    this.image,
    this.description,
    this.url,
  );

  factory DefaultResponseData.fromJson(Map<String, dynamic> json) => _$DefaultResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$DefaultResponseDataToJson(this);
}
