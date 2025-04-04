import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpk/app_module/new_blog_screen/controller/new_blog_controller.dart';
import 'package:xpk/config/server/image_upload_service.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class ImageUploadSection extends StatefulWidget {
  const ImageUploadSection({Key? key}) : super(key: key);

  @override
  _ImageUploadSectionState createState() => _ImageUploadSectionState();
}
class _ImageUploadSectionState extends State<ImageUploadSection> {
  final NewBlogController controller = Get.find<NewBlogController>();


  Future<void> _pickImages() async {
    final List<XFile> pickedImages =
        await ImageUploadService.pickMultipleImages();
    setState(() {
      controller.selectedImages.addAll(pickedImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:  controller.selectedImages.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: AppColors.mutedElements.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add_photo_alternate,
                        color: Colors.white),
                    onPressed: _pickImages,
                  ),
                );
              }
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File( controller.selectedImages[index - 1].path)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
