
import 'package:xpk/utils/imports/app_imports.dart';


class BottomNavItem extends StatelessWidget {
  final IconData icon; // Changed from Icon to IconData
  final int index;
  final String label;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, // Now it correctly takes IconData
            color: currentIndex == index
                ? AppColors.primaryAppBar
                : AppColors.jetBlack,
          ),
          5.sbh,
          AppText(
              text: label,
              color: currentIndex == index
                  ? AppColors.primaryAppBar
                  : AppColors.jetBlack,
              size: 8.sp,
              fontWeight: FontWeights.regular)
        ],
      ),
    );
  }
}
