
import 'dart:convert';

//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import '../../../utils/imports/app_imports.dart';

class NewBlogController extends GetxController {
  // Text controllers
  final placeNameController = TextEditingController();
  final placeDescriptionController = TextEditingController();
  final hotelNameController = TextEditingController();
  final hotelDescriptionController = TextEditingController();
  final restaurantNameController = TextEditingController();
  final restaurantDescriptionController = TextEditingController();
  final feedbackController = TextEditingController();
  final LocationController = TextEditingController();
  String destinationLat = "";
  String destinationLng = "";
  List<XFile> selectedImages = <XFile>[].obs;
  // Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to pick multiple images
  Future<void> pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.clear();
      selectedImages.addAll(pickedFiles.map((x) => XFile(x.path)));
      update();
    }
  }
  // Future<void> uploadBlogToFirestore() async {
  //   if (selectedImages.isEmpty || LocationController.text.isEmpty) {
  //     Get.snackbar("Error", "Please select location and upload at least one image");
  //     return;
  //   }
  //
  //   try {
  //     Get.dialog(
  //       Center(child: customLoader(AppColors.primaryAppBar)),
  //       barrierDismissible: false,
  //     );
  //
  //     List<String> imageUrls = [];
  //
  //     for (var image in selectedImages) {
  //       try {
  //
  //         Uint8List? bytes = await image.readAsBytes();
  //         String base64String = base64Encode(bytes);
  //         String url = base64String;
  //         imageUrls.add(url);
  //       } catch (imgError) {
  //         Get.snackbar("Image Upload Error", imgError.toString());
  //         Get.back(); // Close loading
  //         return;
  //       }
  //     }
  //
  //     final blogData = {
  //       "uid": _auth.currentUser!.uid,
  //       "placeName": placeNameController.text.trim(),
  //       "placeDescription": placeDescriptionController.text.trim(),
  //       "hotelName": hotelNameController.text.trim(),
  //       "hotelDescription": hotelDescriptionController.text.trim(),
  //       "restaurantName": restaurantNameController.text.trim(),
  //       "restaurantDescription": restaurantDescriptionController.text.trim(),
  //       "feedback": feedbackController.text.trim(),
  //       "location": {
  //         "lat": destinationLat,
  //         "lng": destinationLng,
  //         "address": LocationController.text.trim(),
  //       },
  //       "images": imageUrls,
  //       "createdAt": FieldValue.serverTimestamp(),
  //     };
  //
  //     await FirebaseFirestore.instance.collection("blogs").add(blogData);
  //
  //     Get.to(NavigationScreen(index: 4,)); // Close loading
  //     Get.snackbar("Success", "Blog uploaded successfully");
  //     clearForm();
  //   } catch (e) {
  //     print("0000000000000000000 ${e.toString()}");
  //     Get.back(); // Close loading
  //     Get.snackbar("Upload Error", e.toString());
  //   }
  // }
  Future<void> uploadBlogToFirestore() async {
    if (selectedImages.isEmpty || LocationController.text.isEmpty) {
      Get.snackbar("Error", "Please select location and upload at least one image");
      return;
    }

    try {
      Get.dialog(
        Center(child: customLoader(AppColors.primaryAppBar)),
        barrierDismissible: false,
      );

      List<String> imageUrls = [];

      for (var image in selectedImages) {
        try {
          // Compress image
          // final compressedBytes = await FlutterImageCompress.compressWithFile(
          //   image.path,
          //   minWidth: 800,
          //   minHeight: 800,
          //   quality: 60, // 0-100 (lower = more compressed)
          //   format: CompressFormat.jpeg,
          // );
          print("Original: ${File(image.path).lengthSync() / 1024} KB");
         // print("Compressed: ${compressedBytes!.length / 1024} KB");

          // if (compressedBytes == null) {
          //   throw Exception("Image compression failed");
          // }

          // Convert to base64 (NOT RECOMMENDED FOR FIRESTORE) — use only if you *must*
          String base64String = base64Encode([1,2]);
          imageUrls.add(base64String);

          // ✅ Better: Upload compressedBytes to Firebase Storage instead and get download URL

        } catch (imgError) {
          Get.snackbar("Image Upload Error", imgError.toString());
          Get.back();
          return;
        }
      }

      final blogData = {
        "uid": _auth.currentUser!.uid,
        "placeName": placeNameController.text.trim(),
        "placeDescription": placeDescriptionController.text.trim(),
        "hotelName": hotelNameController.text.trim(),
        "hotelDescription": hotelDescriptionController.text.trim(),
        "restaurantName": restaurantNameController.text.trim(),
        "restaurantDescription": restaurantDescriptionController.text.trim(),
        "feedback": feedbackController.text.trim(),
        "location": {
          "lat": destinationLat,
          "lng": destinationLng,
          "address": LocationController.text.trim(),
        },
        "images": imageUrls,
        "createdAt": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection("blogs").add(blogData);
      // 👇 Close loading dialog first
      Get.back();

// 👇 Now navigate
      Get.to(NavigationScreen(index: 4));

// 👇 Show success snackbar
      Get.snackbar("Success", "Blog uploaded successfully");
      clearForm();

      clearForm();
    } catch (e) {
      print("Upload Error: ${e.toString()}");
      Get.back();
      Get.snackbar("Upload Error", e.toString());
    }
  }
  void clearForm() {
    placeNameController.clear();
    placeDescriptionController.clear();
    hotelNameController.clear();
    hotelDescriptionController.clear();
    restaurantNameController.clear();
    restaurantDescriptionController.clear();
    feedbackController.clear();
    selectedImages.clear();
    LocationController.clear();
    destinationLat = "";
    destinationLng = "";

    update();
  }

  @override
  void dispose() {
    placeNameController.dispose();
    placeDescriptionController.dispose();
    hotelNameController.dispose();
    hotelDescriptionController.dispose();
    restaurantNameController.dispose();
    restaurantDescriptionController.dispose();
    feedbackController.dispose();
    super.dispose();
  }
}
