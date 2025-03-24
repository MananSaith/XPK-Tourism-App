import 'package:flutter/material.dart';

class QuickFact extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final String address;
  final bool? openNow;

  const QuickFact({
    Key? key,
    required this.rating,
    required this.reviewCount,
    required this.address,
    this.openNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Facts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildFactRow(
            Icons.star,
            "$rating/5 (${reviewCount.toString()} reviews)",
          ),
          SizedBox(height: 8),
          _buildFactRow(
            Icons.location_on,
            address,
          ),
          if (openNow != null) ...[
            SizedBox(height: 8),
            _buildFactRow(
              Icons.access_time,
              openNow! ? "Open Now" : "Closed",
              textColor: openNow! ? Colors.green : Colors.red,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFactRow(IconData icon, String text, {Color? textColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
