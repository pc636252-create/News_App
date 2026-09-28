import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';
import '../SharedPrefrence/sharedPrefrence.dart';

class SplashController extends GetxController {
  final SharedPrefService _prefService = Get.find<SharedPrefService>();

  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  void _handleNavigation() {
    Future.delayed(const Duration(seconds: 4), () {
      if (_prefService.isLoggedIn()) {
        Get.offAllNamed(AppRoutes.navigation);
      } else {
        Get.offAllNamed(AppRoutes.signIn);
      }
    });
  }
}
