import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toyota/connection/dio_client.dart';
import 'package:toyota/connection/model/base_response.dart';
import 'package:toyota/connection/model/faq_response.dart';
import 'package:toyota/connection/model/login_response.dart';
import 'package:toyota/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  final _dioClient = DioClient();

  Future<LoginResponse> login(String phone, String password, bool remember) async {
    final response = await _dioClient.login(
      username: phone,
      password: password,
    );
    if (response.status?.toLowerCase() == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", response.data?.accessToken ?? "");
      if (remember) {
        await prefs.setString("phone", phone);
        await prefs.setString("password", password);
        await prefs.setBool("saved", true);
      } else {
        await prefs.remove("phone");
        await prefs.remove("password");
        await prefs.remove("saved");
      }
    }
    notifyListeners();
    return response;
  }

  Future<BaseResponse?> register(RegisterData data) async {
    return await _dioClient.register(data);
  }

  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<BaseResponse> updatePassword(String phone, String password) async {
    return await _dioClient.updatePassword(phone, password);
  }

  Future<BaseResponse?> checkMobile(String phone, {String? type}) async {
    return await _dioClient.checkMobile(phone, type: type);
  }

  Future<BaseResponse?> sendOtp(String phone) async {
    return await _dioClient.requestOTP(phone);
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    return await _dioClient.validateOTP(phone, otp);
  }

  Future<FAQResponse> getFAQ() async {
    return await _dioClient.getFAQ();
  }
}
