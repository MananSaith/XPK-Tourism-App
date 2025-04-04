import 'package:get/get.dart';
import 'package:xpk/app_module/deatil_blog/view/detail_blog_screen.dart';
import 'package:xpk/utils/imports/app_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileGallery extends StatelessWidget {
  const ProfileGallery({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getUserData(String uid) async {
    final userSnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userSnap.data() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user UID
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Center(child: Text("Please log in to view your posts."));
    }

    // Filter the query to get posts from the current user only
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("blogs")
          .where("uid",
              isEqualTo: currentUser.uid) // Filter by current user's UID
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: customLoader(AppColors.primaryAppBar));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No blogs yet."));
        }

        final blogs = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10, // Space between columns
              mainAxisSpacing: 10, // Space between rows
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blog = blogs[index].data() as Map<String, dynamic>;
              final blogId = blogs[index].id; // Get the document ID

              // Ensure the image URL is not null or empty
              final imageUrl = blog["images"]?.isNotEmpty == true
                  ? blog["images"][0]
                  : ''; // Default to empty if no images

              return ClipRRect(
                borderRadius: BorderRadius.circular(12), // Apply radius
                child: InkWell(
                  onTap: () {
                    Get.to(() => BlogDetailScreen(
                          blog: blog,
                        ));
                  },
                  onLongPress: () {
                    // Show confirmation dialog to delete the post
                    _showDeleteDialog(context, blogId);
                  },
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const Icon(Icons
                          .image_not_supported), // Handle empty or broken image URL
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Show delete confirmation dialog
  void _showDeleteDialog(BuildContext context, String blogId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Delete the post
              await _deletePost(blogId);
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // Delete the post from Firestore
  Future<void> _deletePost(String blogId) async {
    try {
      await FirebaseFirestore.instance.collection("blogs").doc(blogId).delete();
      Get.snackbar("Success", "Post deleted successfully",
          backgroundColor: AppColors.primaryAppBar, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete post",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
