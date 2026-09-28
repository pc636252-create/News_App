import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';

class CityController extends GetxController {
  late TextEditingController searchController;

  final List<String> _allCities = [
    'Himachal','Kolkata', 'Delhi', 'Bangalore', 'Kochi',
    'Mumbai', 'Noida',
  ];

  var searchText = ''.obs;
  var selectedCity = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();

    searchController.addListener(() {
      searchText.value = searchController.text;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<String> get filteredCities {
    if (searchText.value.isEmpty) {
      return _allCities;
    }
    return _allCities
        .where((city) => city.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }

  void selectCity(String city) {
    selectedCity.value = city;
  }

  void navigateToNext() {
    if (selectedCity.value.isNotEmpty) {
      Get.toNamed(AppRoutes.navigation);
    } else {
      Get.snackbar(
        "Selection Missing",
        "Please choose a city before continuing.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
