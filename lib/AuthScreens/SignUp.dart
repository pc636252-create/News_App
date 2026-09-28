import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SignUp_Controller.dart';
import '../Widget/AppIcons.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {

    final RxString selectedRole = 'media'.obs;

    Widget _buildRadioButton(bool isSelected) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.lightBlue.shade200 : Colors.grey.shade400,
            width: 1.5,
          ),
          color: isSelected ? Colors.lightBlue.shade50.withOpacity(0.3) : Colors.transparent,
        ),
        child: isSelected
            ? Icon(
          Icons.check,
          size: 14,
          color: Colors.lightBlue.shade300,
        )
            : null,
      );
    }
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
                const SizedBox(height: 40),

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

                TextFormField(
                  controller: controller.numberController,
                  validator: controller.validateNumber,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
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
                const SizedBox(height: 32),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'I am a:',
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => Row(
                      children: [
                        GestureDetector(
                          onTap: () => selectedRole.value = 'media',
                          child: Row(
                            children: [
                              _buildRadioButton(selectedRole.value == 'media'),
                              const SizedBox(width: 8),
                              const Text(
                                'Media Reporter',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        GestureDetector(
                          onTap: () => selectedRole.value = 'visitor',
                          child: Row(
                            children: [
                              _buildRadioButton(selectedRole.value == 'visitor'),
                              const SizedBox(width: 8),
                              const Text(
                                'Visitor',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26C6DA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black38, thickness: 0.8)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('or sign in with', style: TextStyle(color: Colors.black54, fontSize: 14)),
                    ),
                    Expanded(child: Divider(color: Colors.black38, thickness: 0.8)),
                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppIcons(icon: Icons.g_mobiledata, onTap: ()=>controller.signInWithGoogle),
                    AppIcons(icon: Icons.facebook, onTap: ()=>controller.signInWithFacebook),
                    AppIcons(icon: Icons.flutter_dash, onTap: ()=>controller.signInWithTwitter),
                    AppIcons(icon: Icons.email_outlined, onTap: ()=>controller.signInWithEmail),
                    AppIcons(icon: Icons.apple, onTap: ()=>controller.signInWithApple),
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("By signing up to news24 you are accepting our ", style: TextStyle(color: Colors.black87)),
                    GestureDetector(
                      onTap:(){},
                      child: const Text(
                        'Terms & condition ',
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

  // Widget _buildSocialButton(IconData icon, VoidCallback onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       width: 50,
  //       height: 50,
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black87, width: 1),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Icon(icon, size: 30, color: Colors.black87),
  //     ),
  //   );
  // }
}
