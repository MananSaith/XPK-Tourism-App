import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Widget? startIcon; // Optional start icon
  final IconData? endIcon; // Optional end icon
  final Color? backgroundColor; // Optional solid background color
  final LinearGradient? gradient; // Optional gradient background
  final Color? textColor; // Optional text color
  final VoidCallback? onPressed; // Optional onPressed function
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding; // Optional padding
  final bool isLoading; // Loading state for showing CircularProgressIndicator
  final double? width; // Optional width
  final double? height; // Optional height
  final double? borderRadius; // Optional border radius

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.startIcon,
    this.endIcon,
    this.borderRadius = 12,
    this.backgroundColor = Colors.blue,
    this.gradient, // New: optional gradient
    this.textColor = Colors.white,
    this.onPressed,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.padding,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Ink(
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null, // Apply solid color if no gradient
          gradient: gradient, // Apply gradient if provided
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius!),
          onTap: onPressed,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            alignment: Alignment.center,
            child: isLoading
                ? CircularProgressIndicator(color: textColor)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (startIcon != null) startIcon!,
                      if (startIcon != null) const SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                        ),
                        maxLines: 1,
                      ),
                      if (endIcon != null) const SizedBox(width: 8),
                      if (endIcon != null) Icon(endIcon, color: textColor),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
