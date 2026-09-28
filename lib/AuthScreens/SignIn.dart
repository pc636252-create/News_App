import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SignIn_Controller.dart';
import '../Widget/AppIcons.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: controller.loginFormKey,
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
                  controller: controller.usernameController,
                  validator: controller.validateUsername,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
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
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black87,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.forgotPassword,
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 160,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: controller.signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF33B5FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('or sign in with', style: TextStyle(color: Colors.black87)),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppIcons(icon: Icons.g_mobiledata, onTap: ()=>controller.signInWithGoogle),
                    AppIcons(icon: Icons.facebook, onTap: ()=>controller.signInWithFacebook),
                    AppIcons(icon: Icons.email_outlined, onTap: ()=>controller.signInWithFacebook),
                    AppIcons(icon: Icons.apple, onTap: ()=>controller.signInWithApple),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: TextStyle(color: Colors.black87)),
                    GestureDetector(
                      onTap: controller.navigateToRegister,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
