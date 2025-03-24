import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> photoReferences;

  const ImageGrid({
    Key? key,
    required this.photoReferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // If no photos available, show a placeholder
    if (photoReferences.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      );
    }

    // Limit to 6 photos maximum
    final displayPhotos = photoReferences.length > 6
        ? photoReferences.sublist(0, 6)
        : photoReferences;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: displayPhotos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Show full-screen image when tapped
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      InteractiveViewer(
                        child: Image.network(
                          'https://p.imgci.com/db/PICTURES/CMS/308100/308189.15.jpg',
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://p.imgci.com/db/PICTURES/CMS/308100/308189.15.jpg',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey.shade700,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
