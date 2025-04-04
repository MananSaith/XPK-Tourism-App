
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

  Future<void> uploadBlogToFirestore() async {
    if (selectedImages.isEmpty || LocationController.text.isEmpty) {
      Get.snackbar(
          "Error", "Please select location and upload at least one image");
      return;
    }

    try {
      // Show loading
      Get.dialog( Center(child:customLoader(AppColors.primaryAppBar)),
          barrierDismissible: false);

      // Upload images to Firebase Storage
      List<String> imageUrls = [];

      for (var image in selectedImages) {
        String fileName =
            'users/${"blog_images"}-${_auth.currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
        final ref = FirebaseStorage.instance.ref().child(fileName);

        final uploadTask = await ref.putFile(File(image.path));
        final url = await uploadTask.ref.getDownloadURL();
        imageUrls.add(url);
      }

      // Create blog data
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

      // Save to Firestore
      await FirebaseFirestore.instance.collection("blogs").add(blogData);

      // Success
      Get.back(); // Close loading dialog
      Get.snackbar("Success", "Blog uploaded successfully");
      clearForm();
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar("Error", e.toString());
    }
  }

  // Clear everything (optional)
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
