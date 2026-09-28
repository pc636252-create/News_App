import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../SharedPrefrence/sharedPrefrence.dart';


class ProfileController extends GetxController {
  final profileFormKey = GlobalKey<FormState>();

  final SharedPrefService _prefs = Get.find<SharedPrefService>();

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var selectedRole = 'Media Reporter'.obs;
  var profileImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  var uploadedDocName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    profileImagePath.value = _prefs.getImagePath();
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value.trim())) return 'Provide a valid email address';
    return null;
  }

  Future<void> changeProfilePhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;

        await _prefs.saveImagePath(pickedFile.path);

        Get.snackbar("Success", "Profile photo updated and saved!");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  void browseFile() {
    uploadedDocName.value = "document_sample.pdf";
    Get.snackbar('Success', 'File selected successfully');
  }

  void updateProfile() async {
    if (profileFormKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await Future.delayed(const Duration(seconds: 2));

        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update profile.',
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
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
