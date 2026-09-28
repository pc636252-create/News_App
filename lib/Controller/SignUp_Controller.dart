import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';

class SignUpController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    numberController.dispose();
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
  String? validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Number is required';
    if (!GetUtils.isNum(value)) return 'Provide a valid Number address';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void verifyCode() {
    if (loginFormKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.city);
      Get.snackbar(
        'Code Send Successfully',
        'Signing up as ${usernameController.text}...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void navigateToRegister() {
    Get.snackbar('Action', 'Navigate to Registration screen');
  }

  void signInWithGoogle() => Get.snackbar('Social Sign-in', 'Google Auth Clicked', snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black87,
  );
  void signInWithFacebook() => Get.snackbar('Social Sign-in', 'Facebook Auth Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithTwitter() => Get.snackbar('Social Sign-in', 'Twitter  Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithEmail() => Get.snackbar('Social Sign-in', 'Twitter Auth Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
  void signInWithApple() => Get.snackbar('Social Sign-in', 'Apple Auth Clicked',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87);
}
