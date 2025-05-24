import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/new_blog_screen/controller/new_blog_controller.dart';
import 'package:xpk/app_module/new_blog_screen/widgets/image_upload_section.dart';
import 'package:xpk/app_module/new_blog_screen/widgets/select_place_map.dart';
import 'package:xpk/utils/app_color/app_color.dart';

import '../../../config/server/seeting_app.dart';

class NewBlogScreen extends StatelessWidget {
  NewBlogScreen({super.key});

  final NewBlogController controller = Get.find<NewBlogController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Blog',
          style: TextStyle(color: AppColors.bgDark),
        ),
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: Container(
        decoration: BoxDecoration(
            //gradient: AppColors.scafoldBackGroundGrandient
            ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Place Info
                _buildStepHeader(1, 'Place Info'),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Place Name',
                  controller: controller.placeNameController,
                  hint: 'Enter place name',
                  validator: (val) =>
                      val == null || val.length < 10 || val.trim().isEmpty
                          ? 'Required'
                          : null,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Place Description',
                  controller: controller.placeDescriptionController,
                  hint: 'Describe the place (min 255 characters)',
                  maxLines: 6,
                  validator: (val) => val == null || val.length < 50
                      ? 'Minimum 255 characters required'
                      : null,
                ),

                const SizedBox(height: 20),

                // Upload Pictures
                _buildStepHeader(2, 'Upload Pictures'),
                const SizedBox(height: 10),
                ImageUploadSection(),

                const SizedBox(height: 20),

                // Hotel Info
                _buildStepHeader(3, 'Hotel Info'),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Hotel Name',
                  controller: controller.hotelNameController,
                  hint: 'Enter hotel name',
                  validator: (val) =>
                      val == null || val.length < 6 || val.trim().isEmpty
                          ? 'Required'
                          : null,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Hotel Description',
                  controller: controller.hotelDescriptionController,
                  hint: 'Describe your stay at the hotel',
                  maxLines: 4,
                  validator: (val) =>
                      val == null || val.length < 20 || val.trim().isEmpty
                          ? 'Required'
                          : null,
                ),

                const SizedBox(height: 20),

                // Restaurant Info
                _buildStepHeader(4, 'Restaurant Info'),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Restaurant Name',
                  controller: controller.restaurantNameController,
                  hint: 'Enter restaurant name',
                  validator: (val) =>
                      val == null || val.length < 6 || val.trim().isEmpty
                          ? 'Required'
                          : null,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Restaurant Description',
                  controller: controller.restaurantDescriptionController,
                  hint: 'Describe your dining experience',
                  maxLines: 4,
                  validator: (val) =>
                      val == null || val.length < 10 || val.trim().isEmpty
                          ? 'Required'
                          : null,
                ),

                const SizedBox(height: 20),

                // Location
                _buildStepHeader(5, 'Select Location'),
                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullScreenMapSearch()),
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller.LocationController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Required' : null,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search place...",
                        hintStyle: const TextStyle(color:  AppColors.gray),
                        labelStyle: const TextStyle(color:  AppColors.gray),
                        filled: true,
                        fillColor: Colors.white12,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        if(await requestMediaPermission()){
                          controller
                              .uploadBlogToFirestore();
                      }
                         // implement inside controller
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButton,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Upload Blog',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader(int number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mutedElements,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: AppColors.bgDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.bgDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.gray),
        labelStyle: TextStyle(color: AppColors.gray),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
