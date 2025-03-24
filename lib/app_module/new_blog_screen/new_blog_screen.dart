import 'package:flutter/material.dart';
import 'package:xpk/app_module/detail_screen/widgets/custom_button.dart';
import 'package:xpk/app_module/new_blog_screen/widgets/image_upload_section.dart';
import 'package:xpk/app_module/new_blog_screen/widgets/input_section.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class NewBlogScreen extends StatelessWidget {
  const NewBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create New Blog',
          style: TextStyle(color: AppColors.whiteBar),
        ),
        backgroundColor: AppColors.primaryAppBar,
      ),
      body: Container(
        decoration:
            BoxDecoration(gradient: AppColors.scafoldBackGroundGrandient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStepperSection(
                stepNumber: 1,
                title: 'Place',
                child: InputSection(
                  nameHint: 'Enter place name',
                  descriptionHint: 'Describe your experience',
                ),
                isLast: false,
              ),
              _buildStepperSection(
                stepNumber: 2,
                title: 'Upload Pictures',
                child: const ImageUploadSection(),
                isLast: false,
              ),
              _buildStepperSection(
                stepNumber: 3,
                title: 'Hotel',
                child: InputSection(
                  nameHint: 'Enter hotel name',
                  descriptionHint: 'Describe your stay',
                ),
                isLast: false,
              ),
              _buildStepperSection(
                stepNumber: 4,
                title: 'Restaurant',
                child: InputSection(
                  nameHint: 'Enter restaurant name',
                  descriptionHint: 'Describe your dining experience',
                ),
                isLast: false,
              ),
              _buildStepperSection(
                stepNumber: 5,
                title: 'Feedback',
                child: InputSection(
                  descriptionHint: 'Share your feedback or message',
                ),
                isLast: true,
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Upload Blog',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Blog uploaded successfully!')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperSection({
    required int stepNumber,
    required String title,
    required Widget child,
    required bool isLast,
  }) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 14,
            top: 30,
            bottom: 0,
            width: 2,
            child: Container(color: AppColors.mutedElements),
          ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mutedElements,
                  ),
                  child: Center(
                    child: Text(
                      stepNumber.toString(),
                      style: const TextStyle(
                        color: AppColors.whiteBar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.whiteBar,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      child,
                    ],
                  ),
                ),
              ],
            ),
            if (!isLast) const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
