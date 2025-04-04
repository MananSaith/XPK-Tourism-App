import 'package:flutter/material.dart';
import 'package:xpk/app_module/profile_screen/widgets/profile_gallery.dart';
import 'package:xpk/app_module/profile_screen/widgets/profile_header.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: AppColors.scafoldBackGroundGrandient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(),
                const ProfileGallery(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
