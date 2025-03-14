import 'package:xpk/utils/imports/app_imports.dart';

class CustomSearchBar extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingIconColor;
  final String hintText;
  final Color hintTextColor;
  final Widget? lastIcon; // Now accepts any widget
  final TextEditingController controller;
  final VoidCallback onTap;
  final VoidCallback? onIconTap; // Optional callback for suffix widget

  const CustomSearchBar({
    super.key,
    required this.leadingIcon,
    this.leadingIconColor = const Color.fromARGB(255, 128, 127, 127),
    required this.controller,
    required this.hintText,
    this.hintTextColor = Colors.grey,
    this.lastIcon, // Optional widget
    required this.onTap,
    this.onIconTap, // Optional callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 4.r,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(leadingIcon, color: leadingIconColor),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
            fontSize: 10.sp,
            fontWeight: FontWeights.regular,
          ),
          border: InputBorder.none,
          // Conditionally add the suffix widget if lastIcon is not null.
          suffixIcon: lastIcon != null
              ? GestureDetector(
                  onTap: onIconTap,
                  child: lastIcon,
                )
              : null,
        ),
      ),
    );
  }
}
