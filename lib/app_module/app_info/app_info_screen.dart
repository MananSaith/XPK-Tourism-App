import 'package:flutter/cupertino.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class InfoAboutAppScreen extends StatelessWidget {
  const InfoAboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.primaryAppBar,
        title: const Text("About XPkistan",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black54,
      ),
      body: Container(
        decoration:
            BoxDecoration(gradient: AppColors.scafoldBackGroundGrandient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: "Discover XPkistan",
                icon: CupertinoIcons.map_pin,
                text:
                    "XPkistan helps you explore Pakistan based on your city, interests, and available time. Discover amazing places effortlessly!",
              ),
              _buildSection(
                title: "How Recommendations Work?",
                icon: CupertinoIcons.slider_horizontal_3,
                text:
                    "We suggest places using three factors: City, Interest, and Available Time. Our smart system makes exploring easier!",
              ),
              _buildSection(
                title: "Select Your City",
                icon: CupertinoIcons.location,
                text:
                    "Choose your city to get customized recommendations for tourist spots, cultural sites, and local attractions.",
              ),
              _buildSection(
                title: "Your Interests Matter!",
                icon: CupertinoIcons.heart,
                text:
                    "Tell us what you love! Whether it's mountains, beaches, or historical sites, XPkistan will find the best places for you!",
              ),
              _buildSection(
                title: "Limited Time? No Problem!",
                icon: CupertinoIcons.clock,
                text:
                    "Specify your available time, and we'll suggest the best places you can visit within your timeframe!",
              ),
              _buildSection(
                title: "Share Your Vlogs",
                icon: CupertinoIcons.videocam,
                text:
                    "Capture and share your travel experiences! Upload vlogs and let others see the beauty of Pakistan through your lens.",
              ),
              _buildSection(
                title: "Explore People's Interests",
                icon: CupertinoIcons.person_3_fill,
                text:
                    "See what others love to explore! Watch trending vlogs, discover new places, and connect with fellow travelers.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required IconData icon, required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.white30, thickness: 1),
        ],
      ),
    );
  }
}
