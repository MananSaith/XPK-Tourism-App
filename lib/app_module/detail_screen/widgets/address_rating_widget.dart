import 'package:flutter/cupertino.dart';
import 'package:xpk/app_module/detail_screen/model/detail_place_model.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class AddressRatingWidget extends StatelessWidget {
  final String address;
  final double rating;
  final int totalRating;
  final List<Reviews>? reviews;

  const AddressRatingWidget({
    super.key,
    required this.reviews,
    required this.address,
    required this.rating,
    required this.totalRating,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            10.sbh,
            Row(
              children: [
                Icon(CupertinoIcons.location_solid,
                    color: AppColors.primaryAppBar, size: 25.sp),
                10.sbw,
                Expanded(
                  child: AppText(
                    text: address,
                    size: 16.sp,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.jetBlack,
                    fontWeight: FontWeights.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconWithText(CupertinoIcons.heart_solid, AppColors.dangerRed,
                    totalRating.toString()),
                _iconWithText(CupertinoIcons.chat_bubble_2_fill,
                    AppColors.gray500, "comments"),
                _iconWithText(
                    Icons.star_rate_rounded, Colors.yellow, rating.toString()),
              ],
            ),
            10.sbh,
            _buildReviewPreview(context),
          ],
        ),
      ),
    );
  }

  /// 🔹 Helper widget for Icons with Text
  Widget _iconWithText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 23.sp),
        5.sbw,
        AppText(
          text: text,
          size: 14.sp,
          color: AppColors.jetBlack.withValues(alpha: .6),
          fontWeight: FontWeights.bold,
        ),
      ],
    );
  }

  /// 🔹 Review Preview (Only First Review)
  Widget _buildReviewPreview(BuildContext context) {
    if (reviews == null || reviews!.isEmpty) {
      return AppText(
        text: "No reviews available",
        size: 14.sp,
        color: AppColors.jetBlack.withValues(alpha: .6),
        fontWeight: FontWeights.bold,
      );
    }

    var firstReview = reviews![0];

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.gray900.withValues(alpha: .1),
        border: Border.all(color: AppColors.gray900.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(firstReview.profilePhotoUrl ?? ""),
            radius: 20,
          ),
          10.sbw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstReview.authorName ?? "Anonymous",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    Text(firstReview.relativeTimeDescription ?? "",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                  ],
                ),
                5.sbh,
                Text(firstReview.text ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp)),
                5.sbh,
                GestureDetector(
                  onTap: () => _showReviewsBottomSheet(context),
                  child: Text("read all",
                      style: TextStyle(
                          fontSize: 12.sp, color: AppColors.primaryAppBar)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Bottom Sheet to Show Full Reviews List
  void _showReviewsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gray900.withValues(alpha: .7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("All Reviews",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const Divider(thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews?.length ?? 0,
                  itemBuilder: (context, index) {
                    var review = reviews![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(review.profilePhotoUrl ?? ""),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(review.authorName ?? "Anonymous",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan)),
                          ),
                          Text(review.relativeTimeDescription ?? "",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black)),
                        ],
                      ),
                      subtitle: Text(review.text ?? "",
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
