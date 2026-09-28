import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Forgot_Controller.dart';

class ForgotScreen extends GetView<ForgotController> {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/img.png",
                      width: Get.width*0.7,
                      height: Get.height*0.10,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                TextFormField(
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controller.codeController,
                  validator: controller.validateCode,
                  decoration: const InputDecoration(
                    labelText: 'Verification Code',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
                  obscureText: controller.isPasswordObscured.value,
                  decoration: InputDecoration(
                    labelText: 'Enter New Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                )),
                const SizedBox(height: 24),

                Obx(() => TextFormField(
                  controller: controller.confirmPasswordController,
                  validator: controller.validateConfirmPassword,
                  obscureText: controller.isConfirmPasswordObscured.value,
                  decoration: InputDecoration(
                    labelText: 'Re Enter your Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                )),
                const SizedBox(height: 60),

                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Colors.lightBlue))
                    : SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF29B6F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      elevation: 0,
                    ),
                    onPressed: controller.handleSignIn,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
