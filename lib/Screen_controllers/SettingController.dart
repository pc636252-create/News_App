import 'package:get/get.dart';
import '../Routes/App_Routes.dart';
import '../SharedPrefrence/sharedPrefrence.dart';

class SettingsController extends GetxController {
  final RxInt unreadNotifications = 3.obs;
  final SharedPrefService _prefService = Get.find<SharedPrefService>();

  Future<void> logoutUser() async {
    await _prefService.clearAll();

    Get.offAllNamed(AppRoutes.signIn);
  }
}