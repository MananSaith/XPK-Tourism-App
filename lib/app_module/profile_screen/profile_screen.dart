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
                const ProfileHeader(),
                const Center(
                  child: Text(
                    '"I can draw my life by myself"',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const ProfileGallery(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        backgroundColor: AppColors.primaryAppBar,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: AppColors.mutedElements,
          size: 35,
        ),
      ),
    );
  }
}
