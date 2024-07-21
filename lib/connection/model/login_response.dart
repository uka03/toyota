import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  final LoginResponseData? data;

  LoginResponse({
    this.data,
    required super.error,
    required super.message,
    required super.status,
    super.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginResponseData {
  final String? accessToken;

  LoginResponseData({this.accessToken});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
