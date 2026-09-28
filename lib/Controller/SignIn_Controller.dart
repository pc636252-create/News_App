import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';
import '../SharedPrefrence/sharedPrefrence.dart';

class SignInController extends GetxController {
    final SharedPrefService _prefService = Get.find<SharedPrefService>();

  final loginFormKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Provide a valid email address';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

void signIn() async {
    if (loginFormKey.currentState!.validate()) {
      await _prefService.saveLoginStatus(true);

      Get.offAllNamed(AppRoutes.navigation);
      Get.snackbar(
        'Success',
        'Signing in as ${usernameController.text}...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void forgotPassword() {
    Get.toNamed(AppRoutes.verifyCode);
  }

  void navigateToRegister() {
    Get.toNamed(AppRoutes.signUp);
  }

  void signInWithGoogle() => Get.snackbar('Social Sign-in', 'Google Auth Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithFacebook() => Get.snackbar('Social Sign-in', 'Welcome to Facebook ',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithEmail() => Get.snackbar('Social Sign-in', 'Welcome to Facebook ',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithTwitter() => Get.snackbar('Social Sign-in', 'Twitter  Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithApple() => Get.snackbar('Social Sign-in', 'Apple  Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_app/Routes/App_Routes.dart';
//
// class SignInController extends GetxController {
//   final loginFormKey = GlobalKey<FormState>();
//
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   var isPasswordHidden = true.obs;
//
//   @override
//   void onClose() {
//     usernameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
//
//   void togglePasswordVisibility() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }
//
//   String? validateUsername(String? value) {
//     if (value == null || value.trim().isEmpty) return 'Username is required';
//     return null;
//   }
//
//   String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) return 'Email is required';
//     if (!GetUtils.isEmail(value)) return 'Provide a valid email address';
//     return null;
//   }
//
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'Password is required';
//     if (value.length < 6) return 'Password must be at least 6 characters';
//     return null;
//   }
//
//   void signIn() {
//     if (loginFormKey.currentState!.validate()) {
//       Get.toNamed(AppRoutes.navigation);
//       Get.snackbar(
//         'Success',
//         'Signing in as ${usernameController.text}...',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//     }
//   }
//
//   void forgotPassword() {
//     Get.toNamed(AppRoutes.verifyCode);
//   }
//
//   void navigateToRegister() {
//     Get.toNamed(AppRoutes.signUp);
//   }
//
//   void signInWithGoogle() => Get.snackbar('Social Sign-in', 'Google Auth Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithFacebook() => Get.snackbar('Social Sign-in', 'Welcome to Facebook ',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithEmail() => Get.snackbar('Social Sign-in', 'Welcome to Facebook ',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithTwitter() => Get.snackbar('Social Sign-in', 'Twitter  Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithApple() => Get.snackbar('Social Sign-in', 'Apple  Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
// }
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_navigation/src/snackbar/snackbar.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../Routes/App_Routes.dart';
// import '../SharedPrefrence/sharedPrefrence.dart';
//
// class SignInController extends GetxController {
//   final SharedPrefService _prefService = Get.find<SharedPrefService>();
//
//   final loginFormKey = GlobalKey<FormState>();
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   var isPasswordHidden = true.obs;
//
//   @override
//   void onClose() {
//     usernameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
//
//   void signIn() async {
//     if (loginFormKey.currentState!.validate()) {
//       await _prefService.saveLoginStatus(true);
//
//       Get.offAllNamed(AppRoutes.navigation);
//
//       Get.snackbar(
//         'Success',
//         'Signing in as ${usernameController.text}...',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//     }
//   }
//   void signInWithGoogle() => Get.snackbar('Social Sign-in', 'Google Auth Clicked', snackPosition: SnackPosition.BOTTOM,
//     backgroundColor: Colors.white,
//     colorText: Colors.black87,
//   );
//   void signInWithFacebook() => Get.snackbar('Social Sign-in', 'Facebook Auth Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithTwitter() => Get.snackbar('Social Sign-in', 'Twitter  Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithEmail() => Get.snackbar('Social Sign-in', 'Twitter Auth Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
//   void signInWithApple() => Get.snackbar('Social Sign-in', 'Apple Auth Clicked',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       colorText: Colors.black87);
// }

