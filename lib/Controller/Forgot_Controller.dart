import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Routes/App_Routes.dart';

class ForgotController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordObscured = true.obs;
  var isConfirmPasswordObscured = true.obs;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Verification code cannot be empty';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void handleSignIn() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        await Future.delayed(const Duration(seconds: 2));
        Get.toNamed(AppRoutes.navigation);
      } catch (e) {
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}