import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class MapScreen extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;
  final double origanLat;
  final double origanLng;
  final String name;

  MapScreen({
    super.key,
    required this.destinationLat,
    required this.destinationLng,
    required this.origanLat,
    required this.origanLng,
    required this.name,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  double distanceInKm = 0.0;
  String estimatedTime = "Calculating...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _calculateRoute();
  }

  Future<void> _calculateRoute() async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    PolylineRequest polylineRequest = PolylineRequest(
      origin: PointLatLng(widget.origanLat, widget.origanLng),
      destination: PointLatLng(widget.destinationLat, widget.destinationLng),
      mode: TravelMode.driving,
    );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: ApiConstant.googleApikey,
      request: polylineRequest,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 6,
        ),
      );

      _markers.add(Marker(
        markerId: MarkerId("origin"),
        position: LatLng(widget.origanLat, widget.origanLng),
        infoWindow: InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));

      _markers.add(Marker(
        markerId: MarkerId("destination"),
        position: LatLng(widget.destinationLat, widget.destinationLng),
        infoWindow: InfoWindow(title: widget.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));

      distanceInKm = _calculateDistance(widget.origanLat, widget.origanLng,
          widget.destinationLat, widget.destinationLng);
      estimatedTime = "${(distanceInKm / 50).toStringAsFixed(1)} hr";
      isLoading = false;
    });
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371;
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180;

  void _navigateToGoogleMaps() async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=${widget.origanLat},${widget.origanLng}"
        "&destination=${widget.destinationLat},${widget.destinationLng}&travelmode=driving";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw "Could not launch Google Maps";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// **Background Gradient**
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade200, Colors.blue.shade600],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// **Google Map**
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.origanLat, widget.origanLng),
              zoom: 14, // Increased zoom level
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            mapType: MapType.normal,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: true,
          ),

          /// **Place Name, Distance, and ETA**
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance: ${distanceInKm.toStringAsFixed(1)} km",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text("ETA: $estimatedTime",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// **Loading Indicator**
          if (isLoading)
            Center(
              child: customLoader(AppColors.primaryAppBar),
            ),

          /// **Navigate Button at Bottom**
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _navigateToGoogleMaps,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                backgroundColor: Colors.blue.shade700,
              ),
              child: Text("Start Navigation",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
