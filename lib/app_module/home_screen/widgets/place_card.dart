import 'package:flutter/material.dart';
import 'package:xpk/app_module/home_screen/model/text_search_place_model.dart';
import 'package:xpk/utils/constant/api_constant.dart';

class PlaceCard extends StatelessWidget {
  final TextSearchPlaceModel place;

  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      shadowColor: Colors.black54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Place Image with Overlay Gradient
          if (place.photos != null && place.photos!.isNotEmpty)
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    _getPhotoUrl(place.photos!.first.photoReference!),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    place.name ?? 'Unknown Place',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 5,
                            color: Colors.black,
                            offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating
                if (place.rating != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade600, size: 22),
                      const SizedBox(width: 6),
                      Text('${place.rating}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),

                const SizedBox(height: 8),

                // Address
                if (place.formattedAddress != null)
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.redAccent, size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          place.formattedAddress!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 8),

                // Opening Hours
                if (place.openingHours != null)
                  Row(
                    children: [
                      Icon(
                        place.openingHours!.openNow == true
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: place.openingHours!.openNow == true
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        place.openingHours!.openNow == true
                            ? 'Open Now'
                            : 'Closed',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: place.openingHours!.openNow == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 8),

                // Place Types (Categories)
                if (place.types != null && place.types!.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    children: place.types!
                        .map((type) => Chip(
                              label: Text(type,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              backgroundColor: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ))
                        .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to generate Google Place Photo API URL
  String _getPhotoUrl(String photoReference) {
    const String apiKey = ApiConstant.googleApikey;
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photo_reference=$photoReference&key=$apiKey';
  }
}
