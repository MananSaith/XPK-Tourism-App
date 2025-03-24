import '../../../utils/imports/app_imports.dart';

/// **Reusable Chip Widget with Click Event**
Widget buildCategoryChip({
  required String label,
  required Color color,
  required VoidCallback onTap,
  required bool isSelected,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.white, // Change color when selected
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected
                ? Colors.white
                : color, // Change text color when selected
            fontWeight: FontWeight.w300,
            fontSize: 10.sp),
      ),
    ),
  );
}
