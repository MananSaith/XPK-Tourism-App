import 'package:flutter/material.dart';
import 'package:xpk/utils/app_color/app_color.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Profile Content
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/profile-RwQ7rwF5jO1y7IsN5wnMM01mL9727C.png',
                            ),
                          ),
                        ),
                        // Online indicator
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ABDUL MANAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.edit,
                          color: Colors.purple[400],
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'mrmanani143@gmail.com',
                      style: TextStyle(
                        color: AppColors.whiteBar.withValues(alpha: 0.9),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
