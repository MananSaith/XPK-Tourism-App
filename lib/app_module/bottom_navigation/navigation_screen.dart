import 'package:flutter/cupertino.dart';
import 'package:xpk/app_module/for_you/view/for_you_screen.dart';
import 'package:xpk/utils/imports/app_imports.dart';

class NavigationScreen extends StatefulWidget {
  final int? index; // Optional index

  const NavigationScreen({super.key, this.index});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
class _NavigationScreenState extends State<NavigationScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? 0; // Default to 0 if null
  }

  final List<Widget> children = [
    HomeScreen(),
    const BlogListScreen(),
    NewBlogScreen(),
    SaveScreen(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: children[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightGray,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: BottomAppBar(
              color: AppColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                    icon: CupertinoIcons.app_badge,
                    label: 'Home',
                    index: 0,
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                  ),
                  BottomNavItem(
                    icon: CupertinoIcons.rectangle_3_offgrid,
                    label: 'For You',
                    index: 1,
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                  ),
                  BottomNavItem(
                    icon: CupertinoIcons.add_circled,
                    label: 'Post',
                    index: 2,
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                  ),
                  BottomNavItem(
                    icon: CupertinoIcons.bookmark,
                    label: 'Saved',
                    index: 3,
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                  ),
                  BottomNavItem(
                    icon: CupertinoIcons.person,
                    label: 'Profile',
                    index: 4,
                    currentIndex: currentIndex,
                    onTap: onTabTapped,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
