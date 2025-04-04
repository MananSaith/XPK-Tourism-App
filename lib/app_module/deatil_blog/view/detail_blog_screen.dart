import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xpk/app_module/google_map_poliline_screen/view/map_screen.dart';
import '../../../utils/imports/app_imports.dart';
import 'dart:async';

class BlogDetailScreen extends StatefulWidget {
  final Map<String, dynamic> blog;
 // final Map<String, dynamic> user;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late PageController controllerPage;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    controllerPage = PageController();

    // Set up a timer to automatically scroll through the images
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < (widget.blog['images']?.length ?? 0) - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      controllerPage.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    controllerPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;
    //final user = widget.user;

    final List images = blog['images'] ?? [];
    final String placeName = blog['placeName'] ?? "Unknown Place";
    final String placeDescription =
        blog['placeDescription'] ?? "No description available.";
    final String hotelName = blog['hotelName'] ?? "No hotel available";
    final String hotelDescription =
        blog['hotelDescription'] ?? "No description available.";
    final String restaurantName =
        blog['restaurantName'] ?? "No restaurant available";
    final String restaurantDescription =
        blog['restaurantDescription'] ?? "No description available.";
    final String feedback = blog['feedback'] ?? "No feedback available.";
    // final String userName = user["username"] ?? "Anonymous";
    // final String? userPhoto = user["profileImageUrl"];
    // final Timestamp? createdAt = blog["createdAt"];
    // final String formattedDate =
    //     createdAt != null ? DateFormat.yMMMMd().format(createdAt.toDate()) : "";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      //backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sbh,
            if (images.isNotEmpty)
              SizedBox(
                height: 250,
                width: double.infinity,
                child: PageView.builder(
                  controller: controllerPage,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: controllerPage,
                    count: images.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      activeDotColor: AppColors.primaryAppBar,
                      dotColor: AppColors.gray100,
                    ),
                  ),
                ),
              ),
            Divider(color: AppColors.gray100, height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(placeName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  8.sbh,
                  Text(blog["location"]?["address"],
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  8.sbh,
                  Text(placeDescription,
                      style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  16.sbh,
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 20,
                  //       backgroundImage: userPhoto != null
                  //           ? CachedNetworkImageProvider(userPhoto)
                  //           : null,
                  //       child: userPhoto == null
                  //           ? const Icon(Icons.person, color: Colors.white)
                  //           : null,
                  //     ),
                  //     12.sbw,
                  //     // Column(
                  //     //   crossAxisAlignment: CrossAxisAlignment.start,
                  //     //   children: [
                  //     //     Text(userName,
                  //     //         style: const TextStyle(
                  //     //             fontWeight: FontWeight.w600, fontSize: 16)),
                  //     //     if (formattedDate.isNotEmpty)
                  //     //       Text(formattedDate,
                  //     //           style: const TextStyle(
                  //     //               fontSize: 12, color: Colors.grey)),
                  //     //   ],
                  //     // )
                  //   ],
                  // ),
                  20.sbh,
                  Divider(color: AppColors.gray100),
                  20.sbh,
                  Text("Hotel: $hotelName",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  8.sbh,
                  Text(hotelDescription,
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  20.sbh,
                  Divider(color: AppColors.gray100),
                  20.sbh,
                  Text("Restaurant: $restaurantName",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  8.sbh,
                  Text(restaurantDescription,
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  20.sbh,
                  Divider(color: AppColors.gray100),
                  20.sbh,
                  Text("Feedback",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  8.sbh,
                  Text(feedback,
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  8.sbh,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: Get.width / 0.8,
                        child: CustomElevatedButton(
                          borderRadius: 50,
                          text: "Let's Move",
                          fontSize: Responsive.fontSize(context, 18),
                          gradient: AppColors.buttonGradian,
                          onPressed: () async {
                            Position? position = await getCurrentLocation();
                            if (position == null) {
                              debugPrint(
                                  "============= Error: Unable to fetch location.");
                              appToastView(title: "Location access required.");
                            } else {
                              Get.to(() => MapScreen(
                                    destinationLat: double.tryParse(
                                            blog["location"]?["lat"]
                                                    ?.toString() ??
                                                "0.0") ??
                                        0.0,
                                    destinationLng: double.tryParse(
                                            blog["location"]?['lng']
                                                    ?.toString() ??
                                                "0.0") ??
                                        0.0,
                                    origanLat: position.latitude,
                                    origanLng: position.longitude,
                                    name: placeName,
                                  ));
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
