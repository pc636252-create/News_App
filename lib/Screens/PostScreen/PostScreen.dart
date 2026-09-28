import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import '../../Screen_controllers/Post_Controller.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({super.key});

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade200, height: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: controller.postFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() => GestureDetector(
                  onTap: controller.pickPostImage,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: controller.selectedImagePath.value.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(controller.selectedImagePath.value),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 32, color: Colors.grey.shade500),
                        const SizedBox(height: 8),
                        Text(
                          "Add Post Images",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 24),
                buildRoundedTextField(
                  hint: "Add Heading",
                  textController: controller.headingController,
                  validator: (val) => controller.validateRequired(val, "Heading"),
                ),
                const SizedBox(height: 16),

                buildRoundedTextField(
                  hint: "Add Tag",
                  textController: controller.tagController,
                  validator: (val) => controller.validateRequired(val, "Tag"),
                ),
                const SizedBox(height: 16),

                buildRoundedTextField(
                  hint: "Category",
                  textController: controller.categoryController,
                  validator: (val) => controller.validateRequired(val, "Category"),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Obx(() => DropdownButton<String>(
                      value: controller.selectedVideoType.value,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      items: <String>['Add Video Link', 'YouTube', 'Vimeo', 'Custom MP4']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.black87, fontSize: 15)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) controller.selectedVideoType.value = newValue;
                      },
                    )),
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50.withOpacity(0.6),
                          border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildToolbarIcon(Icons.format_bold, () => controller.triggerTextModifier("Bold")),
                              buildToolbarIcon(Icons.format_italic, () => controller.triggerTextModifier("Italic")),
                              buildToolbarIcon(Icons.format_underline, () => controller.triggerTextModifier("Underline")),
                              buildToolbarIcon(Icons.strikethrough_s, () => controller.triggerTextModifier("Strikethrough")),
                              buildToolbarIcon(Icons.format_color_text, () => controller.triggerTextModifier("Color")),
                              buildToolbarIcon(Icons.link, () => controller.triggerTextModifier("Link")),
                              buildToolbarIcon(Icons.image_outlined, () => controller.triggerTextModifier("Image")),
                              buildToolbarIcon(Icons.format_align_left, () => controller.triggerTextModifier("Align Left")),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: controller.articleController,
                        maxLines: 6,
                        validator: (val) => controller.validateRequired(val, "Article body"),
                        decoration: const InputDecoration(
                          hintText: "Write Article...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Colors.lightBlue))
                    : SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF29B6F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    onPressed: controller.publishPost,
                    child: const Text(
                      "POST",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget buildRoundedTextField({
    required String hint,
    required TextEditingController textController,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: textController,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.lightBlue, width: 1.5),
        ),
      ),
    );
  }

  Widget buildToolbarIcon(IconData icon, VoidCallback action) {
    return IconButton(
      icon: Icon(icon, size: 18, color: Colors.grey.shade600),
      onPressed: action,
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}