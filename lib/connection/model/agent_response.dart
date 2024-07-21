import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';
part 'agent_response.g.dart';

@JsonSerializable()
class AgentResponse extends BaseResponse {
  final List<AgentResponseData>? data;
  AgentResponse({
    this.data,
    super.status,
    super.message,
    super.error,
    super.code,
  });

  factory AgentResponse.fromJson(Map<String, dynamic> json) => _$AgentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AgentResponseToJson(this);
}

@JsonSerializable()
class AgentResponseData {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? phone;
  final String? social;
  final String? web;
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

  AgentResponseData({
    this.id,
    this.name,
    this.description,
    this.image,
    this.phone,
    this.social,
    this.web,
  });
  factory AgentResponseData.fromJson(Map<String, dynamic> json) => _$AgentResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$AgentResponseDataToJson(this);
}
