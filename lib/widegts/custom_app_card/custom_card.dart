import 'package:xpk/utils/imports/app_imports.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String subName;
  final String price;
  final String? discountPrice; // Optional

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.subName,
    required this.price,
    this.discountPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 167,
              width: 170.w,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText(
                      fontFamily: "Manrope",
                      text: productName,
                      size: 13.sp,
                      fontWeight: FontWeight.w700),
                ),
                // SvgPicture.asset(
                //   AppImages.addCardIcon,
                //   height: 25.h,
                //   colorFilter: ColorFilter.mode(
                //     AppColors.jetBlack,
                //     BlendMode.srcIn,
                //   ),
                // )

                Icon(Icons.add_shopping_cart_sharp)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 1.h),
            child: AppText(
              fontFamily: "Manrope",
              text: subName,
              size: 8.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    text: price,
                    size: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAppBar),
                2.sbh,
                if (discountPrice != null)
                  AppText(
                      text: discountPrice!,
                      size: 8.sp,
                      fontWeight: FontWeight.w400,
                      underLine: TextDecoration.lineThrough),
                4.sbh,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
