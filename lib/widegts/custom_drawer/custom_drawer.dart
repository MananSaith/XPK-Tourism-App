// import 'dart:io';
// import 'dart:ui';

// import 'package:flutter/material.dart';

// import '../../../constants/storage_constants.dart';


// class CustomDrawer extends StatefulWidget {
//   CustomDrawer({super.key});

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   var loggedInData = storageBox.read(StorageConstants.loggedInData);
//   int selectedIndex = -1; // To track the selected card index
//   final authController = AuthController.instance;
//   UserModel _userModel = UserModel();
//   @override
//   void initState() {
//     super.initState();
//     _userModel = LoggedInUserDataSession.instance.getLoggedInUserData()!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Drawer(
//       backgroundColor: Colors.white,
//       width: Get.width / 1.5,
//       child: Column(
//         children: [
//           Container(
//             height: 180,
//             width: Get.width,
//             color: AppColors.primaryColor,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 50),
//                   Obx(() => Stack(
//                         children: [
//                           CustomPaint(
//                             painter: CircularDottedBorderPainter(),
//                             child: Container(
//                               height: 120,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                   borderRadius:
//                                       AppBorderRadius.BORDER_RADIUS_100),
//                               child: authController.getImagePath != ''
//                                   ? Container(
//                                       height: 120,
//                                       width: 120,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               AppBorderRadius.BORDER_RADIUS_100,
//                                           image: DecorationImage(
//                                               image: FileImage(
//                                                 File(
//                                                   authController.getImagePath,
//                                                 ),
//                                               ),
//                                               fit: BoxFit.cover)),
//                                     )
//                                   : AppCacheImageView(
//                                       imageUrl: "${_userModel.data?.image}",
//                                       width: 120,
//                                       height: 120,
//                                       borderRadius: 100,
//                                       boxFit: BoxFit.cover,
//                                     ),
//                             ),
//                           ),
//                           Positioned(
//                               child: GestureDetector(
//                             onTap: () {
//                               Get.to(EditProfileScreen());
//                             },
//                             child: CustomPaint(
//                               painter: CircularDottedBorderPainter(),
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 padding: AppPaddings.defaultPadding08,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.primaryColor,
//                                     borderRadius:
//                                         AppBorderRadius.BORDER_RADIUS_100),
//                                 child:
//                                     SvgPicture.asset(AppImages.editPenIconSvg),
//                               ),
//                             ),
//                           ))
//                         ],
//                       )),
//                   Spacer(),
//                   CustomPaint(
//                     size: Size(Get.width, 0), // Specify size if needed
//                     painter: BottomDottedLinePainter(
//                         lineColor: AppColors.whiteColor),
//                   ),
//                   // CircleAvatar(),
//                   //   BottomDottedLinePainter(lineColor: AppColors.whiteColor)
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: AppPaddings.horizontal,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     vSizedBox(height: Get.height * 0.02),
//                     SizedBox(
//                       height: screenHeight < 700
//                           ? Get.height * 0.6
//                           : Get.height * 0.7,
//                       child: ListView.builder(
//                         itemCount: menuItems.length,
//                         physics: const BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return profileScreenTitleWidget(
//                             icons: menuItems[index]['icon'],
//                             title: menuItems[index]['title'],
//                             isSelected: selectedIndex == index,
//                             height: menuItems[index]['title'] == ['MemberShip']
//                                 ? 13
//                                 : 15,
//                             onTap: () {
//                               setState(() {
//                                 selectedIndex = index;
//                               });

//                               menuItems[index]['action']();
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   profileScreenTitleWidget({
//     required String icons,
//     required String title,
//     required bool isSelected,
//     required VoidCallback onTap,
//     double height = 15,
//     double width = 15,
//   }) {
//     bool isAndroid = Platform.isAndroid;
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Conditional rendering based on selection
//           isSelected
//               ? Image.asset(
//                   'assets/images/selected_card.png',
//                   height: isAndroid ? 60 : 70,
//                 )
//               : Image.asset(
//                   'assets/images/sidebar_card.png',
//                   height: isAndroid ? 60 : 70,
//                 ),

//           Positioned(
//             left: 15,
//             child: SizedBox(
//               width: Get.width,
//               child: Row(
//                 children: [
//                   SvgPicture.asset(
//                     icons,
//                     color: isSelected ? AppColors.whiteColor : Colors.black,
//                     height: height,
//                     width: width,
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.10,
//                   ),
//                   Center(
//                     child: AppText(
//                       text: title,
//                       color: AppColors.textColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Map<String, dynamic>> get menuItems => [
//         {
//           'icon': AppImages.subscription_icon,
//           'title': 'Subscription'.tr,
//           'action': () {
//             Get.to(SubscriptionPurchasedScreen());
//           },
//         },
//         {
//           'icon': AppImages.notificationIconSvg,
//           'title': 'Notification'.tr,
//           'action': () async {
//             authController.getNotifications();
//             // await storageBox.erase();
//             // Get.to(SignInWidget());
//           },
//         },
//         {
//           'icon': AppImages.deleteIcon,
//           'title': 'Delete Account'.tr,
//           'action': () {
//             storageBox.erase();
//             Get.offAll(SignInWidget());
//           },
//         },
//         // {
//         //   'icon': AppImages.help_center,
//         //   'title': 'Help Center'.tr,
//         //   'action': () {},
//         // },
//         // {
//         //   'icon': AppImages.recently_view,
//         //   'title': 'Recently View'.tr,
//         //   'action': () {},
//         // },
//         //     {
//         //       'icon': AppImages.membership,
//         //       'title': 'MemberShip'.tr,
//         //       'action': () {},
//         //     },
//         {
//           'icon': AppImages.logout,
//           'title': 'Log Out'.tr,
//           'action': () {
//             storageBox.erase();
//             Get.offAll(SignInWidget());
//           },
//         },
//       ];
// }

// /// Custom painter for circular dotted border
// class CircularDottedBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     // Create a circular path
//     final path = Path()
//       ..addOval(
//         Rect.fromCircle(
//           center: Offset(size.width / 2, size.height / 2),
//           radius: size.width / 2,
//         ),
//       );

//     // Draw dashed path along the circle
//     Path dashPath = Path();
//     double dashWidth = 8;
//     double dashSpace = 4;
//     double distance = 0;

//     for (PathMetric metric in path.computeMetrics()) {
//       while (distance < metric.length) {
//         dashPath.addPath(
//           metric.extractPath(distance, distance + dashWidth),
//           Offset.zero,
//         );
//         distance += dashWidth + dashSpace;
//       }
//     }

//     canvas.drawPath(dashPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
