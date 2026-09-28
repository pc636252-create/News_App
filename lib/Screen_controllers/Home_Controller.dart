
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Model/NewsModel.dart';
import '../Service/Service.dart';

class HomeController extends GetxController {
  final NewsApiService _apiService = NewsApiService();

  RxString location = "Fetching location...".obs;

  var coins = 499.obs;
  var selectedTab = 0.obs;
  final List<String> categories = ["Top", "Business", "Politics", "Technology", "Health", "Science"];

  var selectedPollOption = (-1).obs;
  var showPollResults = false.obs;
  final List<int> pollResults = [45, 35, 20];
  var newsList = <NewsArticle>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    getCurrentLocation();
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      String currentCategory = categories[selectedTab.value];
      final data = await _apiService.allNews(currentCategory);
      if (data.isEmpty) {
        errorMessage.value = 'No news articles found';
      } else {
        newsList.assignAll(data);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        location.value = "Location service disabled";
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        location.value = "Location permission denied";
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        location.value = "Permission permanently denied";
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high), // Updated syntax for newer geolocator versions
      );

      final Geocoding geocoding = Geocoding();

      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        location.value = "${place.locality ?? ""}, ${place.administrativeArea ?? ""}";
      } else {
        location.value = "No address found";
      }

    } catch (e) {
      location.value = "Unable to get location";
      print("Location Error: $e");
    }
  }


  void selectTab(int index) {
    selectedTab.value = index;
    fetchNews();
  }

  void selectPoll(int index) {
    if (!showPollResults.value) selectedPollOption.value = index;
  }

  void submitPoll() {
    if (selectedPollOption.value != -1) showPollResults.value = true;
  }
}
