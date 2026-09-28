// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PostController extends GetxController {
//   final postFormKey = GlobalKey<FormState>();
//
//   final headingController = TextEditingController();
//   final tagController = TextEditingController();
//   final categoryController = TextEditingController();
//   final videoLinkController = TextEditingController();
//   final articleController = TextEditingController();
//
//   var isLoading = false.obs;
//   var selectedImagePath = ''.obs;
//   var selectedVideoType = 'YouTube'.obs;
//
//   String? validateRequired(String? value, String fieldName) {
//     if (value == null || value.trim().isEmpty) {
//       return '$fieldName cannot be empty';
//     }
//     return null;
//   }
//
//   void pickPostImage() {
//     selectedImagePath.value = "mock_image_path.jpg";
//     Get.snackbar('Success', 'Image added successfully!');
//   }
//
//   void triggerTextModifier(String formatType) {
//     Get.snackbar('Text Editor', 'Applied $formatType modifier to text');
//   }
//
//   void publishPost() async {
//     if (postFormKey.currentState!.validate()) {
//       isLoading.value = true;
//       try {
//         await Future.delayed(const Duration(seconds: 2));
//
//         Get.snackbar(
//           'Success',
//           'Article published successfully!',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.withOpacity(0.8),
//           colorText: Colors.white,
//         );
//
//         headingController.clear();
//         tagController.clear();
//         categoryController.clear();
//         videoLinkController.clear();
//         articleController.clear();
//         selectedImagePath.value = '';
//
//       } catch (e) {
//         Get.snackbar(
//           'Error',
//           'Failed to publish article. Try again.',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(0.8),
//           colorText: Colors.white,
//         );
//       } finally {
//         isLoading.value = false;
//       }
//     }
//   }
//
//   @override
//   void onClose() {
//     headingController.dispose();
//     tagController.dispose();
//     categoryController.dispose();
//     videoLinkController.dispose();
//     articleController.dispose();
//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  final postFormKey = GlobalKey<FormState>();

  final headingController = TextEditingController();
  final tagController = TextEditingController();
  final categoryController = TextEditingController();
  final videoLinkController = TextEditingController();
  final articleController = TextEditingController();

  var isLoading = false.obs;
  var selectedImagePath = ''.obs;
  var selectedVideoType = 'YouTube'.obs;

  final ImagePicker _picker = ImagePicker();

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  void pickPostImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        Get.snackbar(
          'Success',
          'Image added successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void triggerTextModifier(String formatType) {
    Get.snackbar('Text Editor', 'Applied $formatType modifier to text');
  }

  void publishPost() async {
    if (postFormKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await Future.delayed(const Duration(seconds: 2));
        Get.snackbar(
          'Success',
          'Article published successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );

        headingController.clear();
        tagController.clear();
        categoryController.clear();
        videoLinkController.clear();
        articleController.clear();
        selectedImagePath.value = '';

      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to publish article. Try again.',
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
    headingController.dispose();
    tagController.dispose();
    categoryController.dispose();
    videoLinkController.dispose();
    articleController.dispose();
    super.onClose();
  }
}
