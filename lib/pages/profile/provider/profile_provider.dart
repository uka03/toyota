import 'package:flutter/material.dart';
import 'package:toyota/connection/dio_client.dart';
import 'package:toyota/connection/model/base_response.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/connection/model/profile_response.dart';

class ProfileProvider extends ChangeNotifier {
  final _dioClient = DioClient();
  List<CarResponseData> cars = List.empty(growable: true);
  ProfileResponseData? user;

  List<DefaultResponseData?> news = List.empty(growable: true);

  Future<ProfileResponseData?> getMe() async {
    final response = await _dioClient.getMe();
    user = response.data;
    notifyListeners();
    return response.data;
  }

  Future<BaseResponse> updateMe({String? mobile, String? email}) async {
    return await _dioClient.updateMe(mobile: mobile, email: email);
  }

  Future<void> getCars() async {
    final response = await _dioClient.getUserCars();
    cars = response.data ?? [];
    notifyListeners();
  }

  Future<void> getNews() async {
    final response = await _dioClient.getMobileItem("news");
    if (response.data?.isNotEmpty == true) {
      news = response.data ?? [];
    }
    notifyListeners();
  }
}
