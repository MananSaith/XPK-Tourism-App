import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

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

  // Image picker
  List<XFile> selectedImages = <XFile>[].obs;

  // Location
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  // Method to pick multiple images
  Future<void> pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.clear();
      selectedImages.addAll(pickedFiles.map((x) => XFile(x.path)));
      update(); // notify UI
    }
  }

  // Set location from map
  void setLocation(LatLng location) {
    selectedLocation.value = location;
    update();
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
    selectedLocation.value = null;
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
