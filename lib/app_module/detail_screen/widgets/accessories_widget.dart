import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/accesssories_screen/view/accessories_screens_ui.dart';

class Accessories extends StatelessWidget {
  final double origanLat;
  final double origanLng;
  Accessories({super.key, required this.origanLat, required this.origanLng});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 5), // Spacing from top

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nearby Places",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryItem(Icons.restaurant, "Restaurants", Colors.red),
              _buildCategoryItem(
                  CupertinoIcons.bed_double, "Hotels", Colors.blue),
              _buildCategoryItem(
                  Icons.local_gas_station, "Gas/Pump", Colors.green),
              _buildCategoryItem(Icons.local_cafe, "Coffee", Colors.brown),
            ],
          ),
          SizedBox(height: 20), // Spacing between rows
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Get.to(AccessoriesScreensUi(
          label: label,
          origanLat: origanLat,
          origanLng: origanLng,
        ));
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
          SizedBox(height: 8),
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
