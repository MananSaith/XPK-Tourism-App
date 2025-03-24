import 'package:flutter/material.dart';

class ProfileGallery extends StatelessWidget {
  const ProfileGallery({Key? key}) : super(key: key);

  final List<String> images = const [
    'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35',
    'https://images.unsplash.com/photo-1548013146-72479768bada',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
    'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          ...images.map((image) => GalleryImage(imageUrl: image)).toList(),
          const AddPhotoButton(),
        ],
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String imageUrl;

  const GalleryImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF001F3F),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

