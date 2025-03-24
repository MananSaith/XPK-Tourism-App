import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class MapWithPolyline extends StatefulWidget {
  final double destinationLat;
  final double destinationLng;
  final String destinationName;

  const MapWithPolyline({
    Key? key,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationName,
  }) : super(key: key);

  @override
  State<MapWithPolyline> createState() => _MapWithPolylineState();
}

class _MapWithPolylineState extends State<MapWithPolyline> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String _travelDuration = '';
  String _travelDistance = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    try {
      // final position = await MapsService.getCurrentLocation();
      // if (position != null) {
      //   setState(() {
      //     _currentPosition = LatLng(position.latitude, position.longitude);
      //   });
      //   await _getPolylinePoints();
      // }
    } catch (e) {
      print('Error initializing map: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getPolylinePoints() async {
    if (_currentPosition == null) return;

    // Create markers
    _markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.destinationLat, widget.destinationLng),
        infoWindow: InfoWindow(title: widget.destinationName),
      ),
    );

    // Get directions
    try {
      // final directions = await MapsService.getDirections(
      //   _currentPosition!.latitude,
      //   _currentPosition!.longitude,
      //   widget.destinationLat,
      //   widget.destinationLng,
      // );

      // if (directions != null) {
      //   // Create polyline
      //   List<LatLng> polylineCoordinates = [];

      //   for (var point in directions.polylinePoints) {
      //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      //   }

      //   setState(() {
      //     _polylines.add(
      //       Polyline(
      //         polylineId: const PolylineId('route'),
      //         color: AppColors.primaryAppBar,
      //         points: polylineCoordinates,
      //         width: 5,
      //       ),
      //     );

      //     _travelDuration = directions.durationText;
      //     _travelDistance = directions.distanceText;
      //   });

      //   // Zoom to fit the route
      //   _fitBounds();
      // }
    } catch (e) {
      print('Error getting directions: $e');
    }
  }

  Future<void> _fitBounds() async {
    if (_currentPosition == null || !_controller.isCompleted) return;

    final GoogleMapController controller = await _controller.future;

    // Calculate bounds
    final double minLat = _currentPosition!.latitude < widget.destinationLat
        ? _currentPosition!.latitude
        : widget.destinationLat;
    final double maxLat = _currentPosition!.latitude > widget.destinationLat
        ? _currentPosition!.latitude
        : widget.destinationLat;
    final double minLng = _currentPosition!.longitude < widget.destinationLng
        ? _currentPosition!.longitude
        : widget.destinationLng;
    final double maxLng = _currentPosition!.longitude > widget.destinationLng
        ? _currentPosition!.longitude
        : widget.destinationLng;

    // Add some padding
    final bounds = LatLngBounds(
      southwest: LatLng(minLat - 0.05, minLng - 0.05),
      northeast: LatLng(maxLat + 0.05, maxLng + 0.05),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_isLoading) {
      return Container(
        height: size.height * 0.4,
        color: AppColors.mutedElements,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.whiteBar),
        ),
      );
    }

    if (_currentPosition == null) {
      return Container(
        height: size.height * 0.4,
        color: AppColors.mutedElements,
        child: const Center(
          child: Text(
            'Unable to get current location',
            style: TextStyle(color: AppColors.whiteBar),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: size.height * 0.4,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 12,
            ),
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _fitBounds();
            },
          ),
        ),
        if (_travelDuration.isNotEmpty && _travelDistance.isNotEmpty)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryAppBar.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your Location',
                        style: TextStyle(
                          color: AppColors.whiteBar,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward,
                        color: AppColors.whiteBar,
                        size: 16,
                      ),
                      Text(
                        widget.destinationName,
                        style: TextStyle(
                          color: AppColors.whiteBar,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _travelDistance,
                        style: TextStyle(
                          color: AppColors.whiteBar,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _travelDuration,
                        style: TextStyle(
                          color: AppColors.whiteBar,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
