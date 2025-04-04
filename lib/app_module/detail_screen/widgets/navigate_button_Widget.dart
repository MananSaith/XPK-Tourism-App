import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:xpk/app_module/google_map_poliline_screen/view/map_screen.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class NavigateButtonWidget extends StatelessWidget {
  final double destinationLat;
  final double destinationLng;

  final String name;

  NavigateButtonWidget({
    super.key,
    required this.destinationLat,
    required this.destinationLng,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
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
                debugPrint("============= Error: Unable to fetch location.");
                appToastView(title: "Location access required.");
              } else {
                Get.to(() => MapScreen(
                      destinationLat: destinationLat,
                      destinationLng: destinationLng,
                      origanLat: position.latitude,
                      origanLng: position.longitude,
                      name: name,
                    ));
              }
            },
          ),
        ),
      ),
    ));
  }
}
