import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Screen_controllers/Profile_Controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.lightBlue),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: controller.profileFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Obx(() {
                        final path = controller.profileImagePath.value;
                        final file = path.isNotEmpty ? File(path) : null;
                        final hasValidFile = file != null && file.existsSync();
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xffC4C4C4),
                          backgroundImage: hasValidFile ? FileImage(file) : null,
                          child: !hasValidFile
                              ? const Icon(Icons.person, size: 70, color: Colors.white)
                              : null,
                        );
                      }),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: controller.changeProfilePhoto,
                        child: const Text(
                          "Change Profile Photo",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                buildCapsuleInputField(
                  hint: "Username",
                  textController: controller.usernameController,
                  validator: (val) => controller.validateRequired(val, "Username"),
                ),
                const SizedBox(height: 16),

                buildCapsuleInputField(
                  hint: "First Name",
                  textController: controller.firstNameController,
                  validator: (val) => controller.validateRequired(val, "First Name"),
                ),
                const SizedBox(height: 16),

                buildCapsuleInputField(
                  hint: "Last Name",
                  textController: controller.lastNameController,
                  validator: (val) => controller.validateRequired(val, "Last Name"),
                ),
                const SizedBox(height: 16),

                buildCapsuleInputField(
                  hint: "Email Id",
                  textController: controller.emailController,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                buildCapsuleInputField(
                  hint: "Change Password",
                  textController: controller.passwordController,
                  validator: (val) => controller.validateRequired(val, "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                const Text(
                  "I am a",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 12),
                Obx(() => Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.selectedRole.value = 'Media Reporter',
                      child: Row(
                        children: [
                          Icon(
                            controller.selectedRole.value == 'Media Reporter'
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: controller.selectedRole.value == 'Media Reporter'
                                ? Colors.lightBlue
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Media Reporter",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () => controller.selectedRole.value = 'Visitor',
                      child: Row(
                        children: [
                          Icon(
                            controller.selectedRole.value == 'Visitor'
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: controller.selectedRole.value == 'Visitor'
                                ? Colors.lightBlue
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Visitor",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
                const SizedBox(height: 24),

                const Text(
                  "Upload Media Document",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.lightBlue, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      ),
                      onPressed: controller.browseFile,
                      child: const Text(
                        "Browse File",
                        style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Obx(() => Expanded(
                      child: Text(
                        controller.uploadedDocName.value.isEmpty
                            ? "No file chosen"
                            : controller.uploadedDocName.value,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 40),

                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Colors.lightBlue))
                    : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: controller.updateProfile,
                    child: const Text(
                      "Save Profile Changes",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCapsuleInputField({
    required String hint,
    required TextEditingController textController,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: textController,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
        ),
      ),
    );
  }
}