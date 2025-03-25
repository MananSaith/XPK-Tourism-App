import 'package:flutter/material.dart';
import 'package:xpk/app_module/detail_screen/widgets/action_buttons.dart';
import 'package:xpk/app_module/detail_screen/widgets/custom_button.dart';
import 'package:xpk/app_module/detail_screen/widgets/image_gird.dart';
import 'package:xpk/app_module/detail_screen/widgets/map_with_polyline.dart';
import 'package:xpk/app_module/detail_screen/widgets/quick_fact.dart';
import 'package:xpk/app_module/detail_screen/widgets/services_grid.dart';
import 'package:xpk/app_module/home_screen/model/text_search_place_model.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class DetailScreen extends StatefulWidget {
  final String placeId;
  const DetailScreen({super.key, required this.placeId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextSearchPlaceModel? _place;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPlaceDetails();
  }

  Future<void> _loadPlaceDetails() async {
    // try {
    //   final place = await MapsService.getPlaceDetails(widget.placeId);
    //   setState(() {
    //     _place = place;
    //     _isLoading = false;
    //   });
    // } catch (e) {
    //   setState(() {
    //     _errorMessage = 'Error loading place details: $e';
    //     _isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (_isLoading) {
      return _buildLoadingScreen();
    }

    if (_place == null) {
      return _buildErrorScreen();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            MapWithPolyline(
              destinationLat: _place!.geometry!.location!.lat ?? 0,
              destinationLng: _place!.geometry!.location!.lng ?? 0,
              destinationName: _place?.name ?? "Unknown Place",
            ),

            // Details Section
            Container(
              decoration: _buildGradientBackground(),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.03),
                  _buildTitle(size),
                  _buildImageGrid(),
                  SizedBox(height: size.height * 0.024),
                  _buildActionButtons(),
                  SizedBox(height: size.height * 0.02),
                  _buildQuickFacts(),
                  SizedBox(height: size.height * 0.03),
                  _buildServicesGrid(),
                  _buildBackButton(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Container(
        decoration: _buildGradientBackground(),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.whiteBar),
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      body: Container(
        decoration: _buildGradientBackground(),
        child: Center(
          child: Text(
            _errorMessage ?? 'Place not found',
            style: const TextStyle(
              color: AppColors.whiteBar,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(Size size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.02,
          left: size.width * 0.05,
        ),
        child: Text(
          "Detail About ${_place!.name}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return ImageGrid(photoReferences: [] // _place!.photos. ?? [],
        );
  }

  Widget _buildActionButtons() {
    return ActionButtons(
        phoneNumber: "", // _place!.phoneNumber ?? "No Contact Info",
        website: "" // _place!.website ?? "No Website",
        );
  }

  Widget _buildQuickFacts() {
    return QuickFact(
      rating: _place!.rating ?? 0.0,
      reviewCount: _place!.userRatingsTotal ?? 0,
      address: "", // _place!.address ?? "No Address Available",
      openNow: _place!.openingHours?.openNow ?? false,
    );
  }

  Widget _buildServicesGrid() {
    return ServicesGrid(placeId: ""); // _place!.placeId);
  }

  Widget _buildBackButton(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: CustomButton(
        text: "Let's Move On",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(gradient: AppColors.scafoldBackGroundGrandient);
  }
}
