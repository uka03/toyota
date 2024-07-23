import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("token");
    if (value != null) {
      options.headers['Authorization'] = "Bearer $value";
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future onError(err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    debugPrint("error message:  ${err.response?.data['message']}");

    if (err.response?.statusCode == 401) {
      // final storage = FlutterSecureStorage();
      // await storage.deleteAll();
      // appKey.currentState?.pushNamedAndRemoveUntil(
      //   "/",
      //   (Route<dynamic> route) => false,
      // );
      // final store = FlutterSecureStorage();
      // final refresh = await store.read(key: "refresh_token");
      // if (refresh != null) {
      // final provider = ctx?.read<AuthProvider>();
      // await provider?.refreshToken(refresh);
      // }

      return handler.reject(err);
    }
    return handler.next(err);
  }
}
