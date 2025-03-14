// // ignore_for_file: file_names

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../app_text/app_text.dart' show AppText;

// // ignore: must_be_immutable
// class AppButton extends StatelessWidget {
//   final String buttonName;
//   final double textSize;
//   final double buttonWidth;
//   final double buttonHeight;
//   final Color buttonColor;
//   final Color textColor;
//   final Color iconColor;
//   final FontWeight fontWeight;
//   final BorderRadius buttonRadius;
//   final IconData icon;
//   final String iconImage;
//   final bool isIcon;
//   final bool isCenter;
//   final double iconSize;
//   final double iconWidth;
//   final double iconHight;
//   final double paddingButton;
//   final VoidCallback onTap;
//   final double borderWidth;
//   final Color borderColor;
//   final String fontFamily;
//   bool isSuffix = false;
//   double elevation = 3.0;

//   AppButton({
//     super.key,
//     required this.buttonName,
//     this.buttonWidth = 250,
//     this.buttonHeight = 50,
//     required this.buttonColor,
//     required this.textColor,
//     this.fontWeight = FontWeight.normal,
//     this.buttonRadius = BorderRadius.zero,
//     this.iconColor = Colors.white,
//     this.icon = Icons.home,
//     this.iconImage = "",
//     this.isIcon = false,
//     this.isCenter = false,
//     this.iconSize = 30,
//     this.iconWidth = 21,
//     this.iconHight = 14,
//     this.paddingButton = 0,
//     this.fontFamily = "Poppins",
//     required this.onTap,
//     this.textSize = 16,
//     this.borderWidth = 0,
//     this.elevation = 3.0,
//     this.isSuffix = false,
//     this.borderColor = Colors.transparent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetPlatform.isAndroid
//         ? SizedBox(
//             height: buttonHeight,
//             width: buttonWidth,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: buttonColor,
//                 textStyle: TextStyle(
//                     color: textColor,
//                     fontFamily: fontFamily,
//                     fontWeight: fontWeight,
//                     fontSize: textSize),
//                 padding: EdgeInsets.zero,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: buttonRadius,
//                 ),
//                 elevation: elevation,
//               ),
//               onPressed: onTap,
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: buttonRadius,
//                     border: Border.all(
//                       color: borderColor, // Set the border color here
//                       width: borderWidth, // Set the border width
//                     )),
//                 child: Padding(
//                   padding: isCenter
//                       ? const EdgeInsets.symmetric(horizontal: 20)
//                       : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
//                   child: Row(
//                     mainAxisAlignment: paddingButton == 0
//                         ? MainAxisAlignment.center
//                         : MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       !isSuffix
//                           ? isIcon
//                               ? iconImage == ""
//                                   ? Icon(
//                                       icon,
//                                       color: iconColor,
//                                       size: iconSize,
//                                     )
//                                   : Image.asset(
//                                       iconImage,
//                                       height: iconSize,
//                                     )
//                               : Container()
//                           : Container(),
//                       isCenter
//                           ? const Spacer()
//                           : SizedBox(
//                               width: paddingButton == 0
//                                   ? isIcon
//                                       ? 0 //20
//                                       : 0
//                                   : paddingButton,
//                             ),
//                       isSuffix
//                           ? SizedBox(
//                               width: Get.width * 0.6,
//                               child: Center(
//                                 child: AppText(
//                                     text: buttonName,
//                                     color: textColor,
//                                     fontFamily: fontFamily,
//                                     fontWeight: fontWeight,
//                                     size: textSize),
//                               ),
//                             )
//                           : Center(
//                               child: AppText(
//                                   text: buttonName,
//                                   color: textColor,
//                                   fontFamily: fontFamily,
//                                   fontWeight: fontWeight,
//                                   size: textSize),
//                             ),
//                       isCenter ? const Spacer() : Container(),
//                       isCenter
//                           ? isIcon
//                               ? iconImage == ""
//                                   ? Icon(
//                                       icon,
//                                       color: iconColor,
//                                       size: iconSize,
//                                     )
//                                   : Image.asset(iconImage,
//                                       height: iconWidth,
//                                       color: Colors.transparent)
//                               : Container()
//                           : Container(),
//                       isSuffix
//                           ? isIcon
//                               ? iconImage == ""
//                                   ? Icon(
//                                       icon,
//                                       color: iconColor,
//                                       size: iconSize,
//                                     )
//                                   : Row(
//                                       children: [
//                                         Image.asset(
//                                           iconImage,
//                                           width: iconWidth,
//                                           height: iconHight,
//                                           color: iconColor,
//                                         ),
//                                       ],
//                                     )
//                               : Container()
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         : Container(
//             height: buttonHeight,
//             width: buttonWidth,
//             decoration: BoxDecoration(
//                 color: buttonColor,
//                 borderRadius: buttonRadius,
//                 border: Border.all(
//                   width: borderWidth,
//                   color: borderColor,
//                 )),
//             child: CupertinoButton(
//               borderRadius: buttonRadius,
//               padding: EdgeInsets.zero,
//               color: buttonColor,
//               onPressed: onTap,
//               child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0,
//                   ),
//                   // height: ,
//                   child: Padding(
//                     padding: isCenter
//                         ? const EdgeInsets.symmetric(horizontal: 20)
//                         : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
//                     child: Row(
//                       mainAxisAlignment: paddingButton == 0
//                           ? MainAxisAlignment.center
//                           : MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         !isSuffix
//                             ? isIcon
//                                 ? iconImage == ""
//                                     ? Icon(
//                                         icon,
//                                         color: iconColor,
//                                         size: iconSize,
//                                       )
//                                     : Image.asset(
//                                         iconImage,
//                                         height: iconSize,
//                                       )
//                                 : Container()
//                             : Container(),
//                         isCenter
//                             ? const Spacer()
//                             : SizedBox(
//                                 width: paddingButton == 0
//                                     ? isIcon
//                                         ? 10
//                                         : 0
//                                     : paddingButton,
//                               ),
//                         isSuffix
//                             ? SizedBox(
//                                 width: Get.width * 0.6,
//                                 child: Center(
//                                   child: AppText(
//                                       text: buttonName,
//                                       color: textColor,
//                                       fontFamily: fontFamily,
//                                       fontWeight: fontWeight,
//                                       size: textSize),
//                                 ),
//                               )
//                             : Center(
//                                 child: AppText(
//                                     text: buttonName,
//                                     color: textColor,
//                                     fontFamily: fontFamily,
//                                     fontWeight: fontWeight,
//                                     size: textSize),
//                               ),
//                         isCenter ? const Spacer() : Container(),
//                         isCenter
//                             ? isIcon
//                                 ? iconImage == ""
//                                     ? Icon(
//                                         icon,
//                                         color: iconColor,
//                                         size: iconSize,
//                                       )
//                                     : Image.asset(iconImage,
//                                         height: iconSize,
//                                         color: Colors.transparent)
//                                 : Container()
//                             : Container(),
//                         isSuffix
//                             ? isIcon
//                                 ? iconImage == ""
//                                     ? Icon(
//                                         icon,
//                                         color: iconColor,
//                                         size: iconSize,
//                                       )
//                                     : Row(
//                                         children: [
//                                           Image.asset(
//                                             iconImage,
//                                             width: iconWidth,
//                                             height: iconHight,
//                                             color: iconColor,
//                                           ),
//                                         ],
//                                       )
//                                 : Container()
//                             : Container(),
//                       ],
//                     ),
//                   )),
//             ));
//   }
// }

// // ignore: must_be_immutable
// // class AppButtonwithIcon extends StatelessWidget {
// //   String title;
// //   String prefixIcon;
// //   String suffixIcon;
// //   double titleSize;
// //   bool isSuffix;
// //   bool isPrefix;
// //   double prefixIconSize;
// //   double suffixIconSize;
// //   double iconSpace;
// //   Color titleColor;
// //   Color borderColor;
// //   Color buttonColor;
// //   FontWeight fontWeight;
// //   double paddingVertical;
// //   double paddingHorizontol;
// //   double buttonWidth;
// //   VoidCallback onTap;
// //   AppButtonwithIcon({
// //     super.key,
// //     this.title = '',
// //     this.prefixIcon = '',
// //     this.suffixIcon = '',
// //     this.titleSize = 16,
// //     this.isSuffix = false,
// //     this.isPrefix = false,
// //     this.fontWeight = FontWeight.w500,
// //     this.borderColor = Colors.transparent,
// //     this.titleColor = Colors.white,
// //     this.buttonColor = Colors.white,
// //     this.iconSpace = 10,
// //     this.prefixIconSize = 10,
// //     this.suffixIconSize = 10,
// //     this.paddingVertical = 10,
// //     this.paddingHorizontol = 10,
// //     this.buttonWidth = 0,
// //     required this.onTap,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: onTap,
// //       child: Container(
// //         width: buttonWidth,
// //         padding: EdgeInsets.symmetric(
// //             vertical: paddingVertical, horizontal: paddingHorizontol),
// //         decoration: BoxDecoration(
// //             borderRadius: AppBorderRadius.BORDER_RADIUS_05,
// //             color: buttonColor,
// //             border: Border.all(color: borderColor)),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             isPrefix
// //                 ? SvgPicture.asset(
// //               prefixIcon,
// //               height: prefixIconSize,
// //               width: prefixIconSize,
// //             )
// //                 : const SizedBox.shrink(),
// //             isPrefix ? hSizedBox(width: iconSpace) : const SizedBox.shrink(),
// //             AppText(
// //               text: title,
// //               color: titleColor,
// //               size: titleSize,
// //               fontWeight: fontWeight,
// //             ),
// //             isSuffix ? hSizedBox(width: iconSpace) : const SizedBox.shrink(),
// //             isSuffix
// //                 ? SvgPicture.asset(
// //               suffixIcon,
// //               height: suffixIconSize,
// //               width: suffixIconSize,
// //             )
// //                 : const SizedBox.shrink(),
// //             isSuffix ? hSizedBox(width: iconSpace) : const SizedBox.shrink(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
