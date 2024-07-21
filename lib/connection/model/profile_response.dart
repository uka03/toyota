import 'package:json_annotation/json_annotation.dart';
import 'package:toyota/connection/model/base_response.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends BaseResponse {
  final ProfileResponseData? data;
  ProfileResponse({
    this.data,
    super.message,
    super.status,
    super.error,
    super.code,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class ProfileResponseData {
  final int? id;
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? vat;

  ProfileResponseData({
    this.id,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.vat,
  });
  factory ProfileResponseData.fromJson(Map<String, dynamic> json) => _$ProfileResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseDataToJson(this);
}
