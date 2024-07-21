import 'package:flutter/material.dart';
import 'package:toyota/connection/dio_client.dart';
import 'package:toyota/connection/model/car_response.dart';
import 'package:toyota/connection/model/order_response.dart';
import 'package:toyota/connection/model/service_response.dart';

class BookingProvider extends ChangeNotifier {
  final _dioClient = DioClient();
  List<CarResponseData> cars = List.empty(growable: true);
  List<ServiceResponseData> services = List.empty(growable: true);
  List<ServiceResponseData> selectedErvices = List.empty(growable: true);
  List<OrderResponseData> bookingOrder = List.empty(growable: true);

  Future<void> getCars() async {
    final response = await _dioClient.getUserCars();
    cars = response.data ?? [];
    notifyListeners();
  }

  Future<void> getServices() async {
    final response = await _dioClient.getServices();
    services = response.data ?? [];
    notifyListeners();
  }

  Future<void> createBooking(dynamic data) async {
    await _dioClient.createOrder(data);
  }

  void setService(ServiceResponseData service) {
    if (selectedErvices.contains(service)) {
      selectedErvices.remove(service);
    } else {
      selectedErvices.add(service);
    }
    notifyListeners();
  }

  Future<void> getBookingOrder(int? id, DateTime date) async {
    final response = await _dioClient.getServiceOrderStatus(id, date);

    bookingOrder = response.data ?? [];
    notifyListeners();
  }
}
