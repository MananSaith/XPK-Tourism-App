import 'package:xpk/utils/imports/app_imports.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;
  final _firestoreDatabase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1542332213-9b5a5a3fad35',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey.shade500),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.shade200,
              child: Center(
                child:
                    Icon(Icons.broken_image, size: 50, color: Colors.redAccent),
              ),
            ),
          ),
        ),

        // Profile Content
        FutureBuilder<DocumentSnapshot>(
          future: _firestoreDatabase
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("No user data found"));
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
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
                  Text(
                    '"I can draw my life by myself"',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    "Birthday ${userData['birthday']} ",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    "Gender ${userData['gender']} ",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Column(
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
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                userData['profileImageUrl'] ??
                                    'https://via.placeholder.com/150', // fallback image
                              ),
                            ),
                          ),
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
                          Text(
                            userData['username'] ?? 'No Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userData['email'] ?? 'No Email',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
