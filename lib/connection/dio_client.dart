import 'package:dio/dio.dart';
import 'package:toyota/connection/model/agent_response.dart';
import 'package:toyota/connection/model/base_response.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/connection/model/category_response.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/connection/model/faq_response.dart';
import 'package:toyota/connection/model/login_response.dart';
import 'package:toyota/connection/model/order_response.dart';
import 'package:toyota/connection/model/part_response.dart';
import 'package:toyota/connection/model/profile_response.dart';
import 'package:toyota/connection/model/service_response.dart';
import 'package:toyota/connection/network_interceptor.dart';
import 'package:toyota/utils/utils.dart';

class DioClient {
  final _dioClient = Dio()..interceptors.add(NetworkInterceptor());

  final baseUrl = 'https://erp-mob.toyota-tavanbogd.mn/v1';
  // final String _baseUrl = 'http://t141.devorchin.com:8070/v1';

  final loginUrl = '/auth/login';
  final mobileCheck = '/auth/mobile_check';
  final otpUrl = '/auth/otp/request';
  final otpCheck = '/auth/otp/validate';
  final updatePasswordUrl = '/auth/update_password';
  final usersUrl = "/users";
  final meUrl = "/me";
  final registerUrl = "/auth/dummy_partner";
  final carsUrl = "/cars";
  final serviceUrl = "/mobile/service_types";
  final createOrderUrl = "/create_order";
  final carListUrl = "/new_listing";
  final toyotaQUrl = "/toyotaQ";

  Future<ProfileResponse> getMe() async {
    try {
      Response response = await _dioClient.get(
        "$baseUrl$usersUrl$meUrl",
      );
      final model = ProfileResponse.fromJson(response.data);
      return model;
    } catch (e) {
      final dioFailure = e as DioException;
      final error = ProfileResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<BaseResponse> updateMe({String? mobile, String? email}) async {
    try {
      final data = {
        "mobile": mobile,
        "email": email,
      };
      Response response = await _dioClient.patch(
        "$baseUrl$usersUrl$meUrl",
        data: data,
      );
      final model = BaseResponse.fromJson(response.data);
      return model;
    } catch (e) {
      print(e);
      final dioFailure = e as DioException;
      final error = BaseResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final data = {
        'username': username,
        'password': password,
      };
      final response = await _dioClient.post(
        "$baseUrl$loginUrl",
        data: data,
      );
      print(response);
      final model = LoginResponse.fromJson(response.data);
      return model;
    } catch (e) {
      final dioFailure = e as DioException;
      final error = LoginResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<BaseResponse?> register(RegisterData data) async {
    try {
      Response response = await _dioClient.post(
        '$baseUrl$registerUrl',
        data: data.toJson(),
      );

      return BaseResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<BaseResponse?> checkMobile(String phone, {String? type}) async {
    try {
      final data = {
        'mobile': phone,
        'type': type ?? 'login'
      };
      print(data);
      final response = await _dioClient.get(
        '$baseUrl$mobileCheck',
        queryParameters: data,
      );

      print(response.data);
      return BaseResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = BaseResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<BaseResponse> updatePassword(String mobile, String password) async {
    try {
      final data = {
        'mobile': mobile,
        'newPassword': password
      };

      Response response = await _dioClient.post(
        '$baseUrl$updatePasswordUrl',
        data: data,
      );

      return BaseResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = BaseResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<BaseResponse> requestOTP(String mobile) async {
    try {
      final data = {
        'mobile': mobile
      };

      Response response = await _dioClient.post(
        '$baseUrl$otpUrl',
        data: data,
      );
      print(response);

      return BaseResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = BaseResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<bool> validateOTP(String mobile, String code) async {
    try {
      final data = {
        'mobile': mobile,
        'code': code
      };

      Response response = await _dioClient.post(
        '$baseUrl$otpCheck',
        data: data,
      );

      return response.data["data"] as bool? ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<DefaultResponse> getMobileItem(String path) async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl/mobile/$path',
      );

      return DefaultResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = DefaultResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<FAQResponse> getFAQ() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl/mobile/faq',
      );

      return FAQResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = FAQResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<CarResponse> getUserCars() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl$usersUrl$meUrl$carsUrl',
      );

      return CarResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = CarResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<ServiceResponse> getServices() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl$serviceUrl',
      );

      return ServiceResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = ServiceResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<BaseResponse> createOrder(dynamic data) async {
    try {
      Response response = await _dioClient.post(
        '$baseUrl$usersUrl$createOrderUrl',
        data: data,
      );
      print(response.data);

      return BaseResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = BaseResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<OrderResponse> getServiceOrderStatus(int? carId, DateTime date) async {
    try {
      String dateString = date.toIso8601String().split('T')[0];
      Response response = await _dioClient.get(
        '$baseUrl/users/me/service_orders/cars/$carId/date/$dateString',
      );

      return OrderResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      final dioFailure = e as DioException;
      final error = OrderResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<CarResponse> getNewCars() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl$carsUrl$carListUrl',
      );

      return CarResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = CarResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<CarResponse> getToyotaQCars() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl$carsUrl$toyotaQUrl',
      );

      return CarResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = CarResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<AgentResponse> getSalers(String? type) async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl/mobile/salesAgents?type=${type ?? "sales"}',
      );

      return AgentResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = AgentResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<CategoryResponse> getPartCategories() async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl/mobile/parts/categories',
      );

      return CategoryResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = CategoryResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }

  Future<PartResponse> getParts(int? id) async {
    try {
      Response response = await _dioClient.get(
        '$baseUrl/mobile/parts/category/$id',
      );

      return PartResponse.fromJson(response.data);
    } catch (e) {
      final dioFailure = e as DioException;
      final error = PartResponse.fromJson(dioFailure.response?.data);
      return error;
    }
  }
}
