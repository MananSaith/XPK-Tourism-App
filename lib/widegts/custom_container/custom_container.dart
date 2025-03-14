import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Gradient? gradientColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final BoxShadow? shadow;
  final Widget child; // Required child widget
  final EdgeInsets? padding; // Padding around the child
  final EdgeInsets? margin; // Margin around the container

  const CustomContainer({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor,
    this.gradientColor,
    this.borderColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.onTap,
    this.shadow, // Default to null
    required this.child, // The child widget is now required
    this.padding, // Padding around the child
    this.margin, // Margin around the container
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the callback function if provided
      child: Container(
        height: height,
        width: width,
        margin: margin, // Apply margin around the container
        decoration: BoxDecoration(
          color: backgroundColor, // Set background color
          gradient: gradientColor, // Apply gradient color if provided
          border: Border.all(
            color: borderColor ??
                Colors.transparent, // Set border color (default is transparent)
            width: 1.5,
          ),
          borderRadius: borderRadius, // Set border radius
          boxShadow: shadow != null
              ? [shadow!] // Apply shadow if provided
              : [], // No shadow by default
        ),
        padding: padding, // Apply padding around the child
        child: child, // The required child widget is placed here
      ),
    );
  }
}
