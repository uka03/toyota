import 'package:flutter/material.dart';
import 'package:toyota/connection/dio_client.dart';
import 'package:toyota/connection/model/default_response.dart';
import 'package:toyota/utils/utils.dart';

class HomeProvider extends ChangeNotifier {
  final _dioClient = DioClient();

  List<DefaultResponseData?> banners = List.empty(growable: true);
  List<DefaultResponseData?> news = List.empty(growable: true);
  bool isLoading = true;

  getHomeData({bool refresh = false}) async {
    if (isLoading || refresh) {
      showLoader();
      await getBanners();
      await getNews();
      isLoading = false;
    }
    dismissLoader();

    notifyListeners();
  }

  Future<void> getBanners() async {
    final response = await _dioClient.getMobileItem("banners");
    if (response.data?.isNotEmpty == true) {
      banners = response.data ?? [];
    }
  }

  Future<void> getNews() async {
    final response = await _dioClient.getMobileItem("news");
    if (response.data?.isNotEmpty == true) {
      news = response.data ?? [];
    }
  }
}
