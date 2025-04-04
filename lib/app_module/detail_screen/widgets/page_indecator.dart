import 'dart:async';
import 'package:xpk/utils/imports/app_imports.dart';

class AutoScrollImageSlider extends StatefulWidget {
  final List<String> photoReferences;
  final PageController controllerPage;

  const AutoScrollImageSlider({
    Key? key,
    required this.photoReferences,
    required this.controllerPage,
  }) : super(key: key);

  @override
  _AutoScrollImageSliderState createState() => _AutoScrollImageSliderState();
}

class _AutoScrollImageSliderState extends State<AutoScrollImageSlider> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (widget.controllerPage.hasClients) {
        int nextPage = ((widget.controllerPage.page ?? 0).toInt()) + 1;
        if (nextPage < widget.photoReferences.length) {
          widget.controllerPage.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          widget.controllerPage.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.sbh,
        SizedBox(
          height: 180.h,
          width: double.infinity,
          child: PageView.builder(
            controller: widget.controllerPage,
            itemCount: widget.photoReferences.length,
            itemBuilder: (context, index) {
              final imageUrl = _getPhotoUrl(widget.photoReferences[index]);
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8), // Space between images
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Border radius
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(Icons.error, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        12.sbh,
        SmoothPageIndicator(
          controller: widget.controllerPage,
          count: widget.photoReferences.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 8,
            activeDotColor: AppColors.primaryAppBar,
            dotColor: AppColors.gray100,
          ),
        ),
        16.sbh,
        Divider(
          color: AppColors.gray100,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  String _getPhotoUrl(String photoReference) {
    const String apiKey = ApiConstant.googleApikey;
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photo_reference=$photoReference&key=$apiKey';
  }
}


