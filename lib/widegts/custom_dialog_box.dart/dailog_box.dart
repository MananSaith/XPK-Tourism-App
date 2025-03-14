import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog({
  String? title,
  String? content,
  Widget? topLeftWidget,
  Color? backgroundColor,
  List<Widget>? actions,
  double borderRadius = 15.0,
  Color borderColor = Colors.transparent,
  Color titleColor = Colors.black, // Default title color
  Color contentColor = Colors.black, // Default content color
}) {
  Get.dialog(
    Dialog(
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: borderColor, width: 2), // Border color & width
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (topLeftWidget != null) topLeftWidget,
                if (title != null) ...[
                  if (topLeftWidget != null) const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: titleColor),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            if (content != null)
              Text(
                content,
                style: TextStyle(fontSize: 16, color: contentColor),
              ),
            const SizedBox(height: 20),
            if (actions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
          ],
        ),
      ),
    ),
  );
}
