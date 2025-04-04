import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xpk/app_module/deatil_blog/view/detail_blog_screen.dart';

import '../../../utils/imports/app_imports.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  Future<Map<String, dynamic>> getUserData(String uid) async {
    final userSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userSnap.data() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("For You",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: AppColors.scaffoldBackground,

        //elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("blogs")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: customLoader(AppColors.primaryAppBar));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No blogs yet."));
          }

          final blogs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: blogs.length,
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              final blog = blogs[index].data() as Map<String, dynamic>;

              final placeName = blog["placeName"] ?? "Unknown Place";
              final address = blog["location"]?["address"] ?? "";
              final uid = blog["uid"];
              final images = blog["images"] ?? [];
              final firstImage = images.isNotEmpty ? images[0] : null;

              Timestamp? createdAt = blog["createdAt"];
              String formattedDate = createdAt != null
                  ? DateFormat.yMMMd().format(createdAt.toDate())
                  : "";

              return FutureBuilder<Map<String, dynamic>>(
                future: getUserData(uid),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(); // Avoid blocking UI with loader
                  }

                  final user = userSnapshot.data ?? {};
                  final userName = user["username"] ?? "Anonymous";
                  final userPhoto = user["profileImageUrl"];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BlogDetailScreen(
                            blog: blog,
                          ));
                    },
                    child: Container(
                      // margin: const EdgeInsets.symmetric(
                      //     horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        //color: AppColors.softBackground,
                        // borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (firstImage != null)
                            ClipRRect(
                              // borderRadius: const BorderRadius.vertical(
                              //     top: Radius.circular(16)),
                              child: CachedNetworkImage(
                                imageUrl: firstImage,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 200,
                                  color: AppColors.scaffoldBackground,
                                  child: Center(
                                    child:
                                        customLoader(AppColors.primaryAppBar),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 200,
                                  color: Colors.grey.shade200,
                                  child:
                                      const Icon(Icons.broken_image, size: 40),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(placeName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                  address,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.grey.shade300,
                                      backgroundImage: userPhoto != null
                                          ? CachedNetworkImageProvider(
                                              userPhoto)
                                          : null,
                                      child: userPhoto == null
                                          ? const Icon(Icons.person,
                                              color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(userName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            )),
                                        if (formattedDate.isNotEmpty)
                                          Text(formattedDate,
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 12)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
