import 'package:xpk/utils/imports/app_imports.dart';

class CustomSearchBar extends StatelessWidget {
  final IconData leadingIcon;
  final Color leadingIconColor;
  final String hintText;
  final Color hintTextColor;
  final IconData? lastIcon;
  final Color lastIconColor;
  final TextEditingController controller;
  final VoidCallback onTap;
  final VoidCallback? onIconTap;
  final bool isReadOnly; // 🔥 New optional parameter added

  final Color boxShadowColor;
  final double boxShadowBlurRadius;
  final double boxShadowSpreadRadius;
  final Offset boxShadowOffset;

  const CustomSearchBar({
    Key? key,
    required this.leadingIcon,
    this.leadingIconColor = const Color.fromARGB(255, 128, 127, 127),
    required this.controller,
    required this.hintText,
    this.hintTextColor = Colors.grey,
    this.lastIcon,
    this.lastIconColor = Colors.black,
    required this.onTap,
    this.onIconTap,
    this.isReadOnly = false, // Default: false (means keyboard will open)
    this.boxShadowColor = const Color.fromRGBO(0, 0, 0, 0.2),
    this.boxShadowBlurRadius = 4,
    this.boxShadowSpreadRadius = 2,
    this.boxShadowOffset = const Offset(0, 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            blurRadius: boxShadowBlurRadius,
            spreadRadius: boxShadowSpreadRadius,
            offset: boxShadowOffset,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly, // ✅ Now TextField can be read-only
        style: TextStyle(
          fontSize: 14.sp,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              leadingIcon,
              color: leadingIconColor,
              size: 23,
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: hintTextColor,
            ),
          ),
          suffixIcon: lastIcon != null
              ? GestureDetector(
                  onTap: onIconTap,
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Icon(
                      lastIcon!,
                      size: 20.sp,
                      color: lastIconColor,
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
