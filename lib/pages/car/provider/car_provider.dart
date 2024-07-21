import 'package:flutter/material.dart';
import 'package:toyota/connection/dio_client.dart';
import 'package:toyota/connection/model/agent_response.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/connection/model/category_response.dart';
import 'package:toyota/connection/model/part_response.dart';

class CarProvider extends ChangeNotifier {
  final _dioClient = DioClient();
  List<CarResponseData> cars = [];
  List<AgentResponseData> agents = [];
  List<CategoryResponseData> categories = [];
  List<PartResponseData> parts = [];

  Future<void> getNewCars() async {
    cars.clear();
    final response = await _dioClient.getNewCars();
    cars = response.data ?? [];
    notifyListeners();
  }

  Future<void> getToyotaQCars() async {
    cars.clear();
    final response = await _dioClient.getToyotaQCars();
    cars = response.data ?? [];
    notifyListeners();
  }

  Future<void> getSalers(String? type) async {
    final response = await _dioClient.getSalers(type);
    agents = response.data ?? [];
    notifyListeners();
  }

  Future<void> getCategories() async {
    final response = await _dioClient.getPartCategories();
    categories = response.data ?? [];
    notifyListeners();
  }

  Future<void> getParts(int? id) async {
    final response = await _dioClient.getParts(id);
    parts = response.data ?? [];
    notifyListeners();
  }
}
