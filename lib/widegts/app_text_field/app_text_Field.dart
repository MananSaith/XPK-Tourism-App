// import 'dart:ui';
// import 'package:xpk/utils/imports/app_imports.dart';


// // ignore: must_be_immutable
// class AppTextField extends StatefulWidget {
//   String hint;
//   String? intialvalue;
//   TextEditingController controller;
//   bool isPrefix;
//   bool isSuffix;
//   bool obscureText;
//   Widget icon;
//   Widget suffixIcon;
//   int maxLines;
//   int miniLines;
//   double borderRadius;
//   VoidCallback? onTap;
//   TextInputType keyboardType;
//   List<TextInputFormatter>? inputFormatters;
//   final ValueChanged<String>? onChanged;
//   bool showBorder; // New variable to control border visibility

//   AppTextField({
//     super.key,
//     this.hint = '',
//     required this.controller,
//     this.onChanged,
//     this.borderRadius = 30.0,
//     this.isPrefix = false,
//     this.isSuffix = false,
//     this.obscureText = false,
//     this.onTap,
//     this.maxLines = 1,
//     this.miniLines = 1,
//     this.icon = const SizedBox(),
//     this.suffixIcon = const SizedBox(),
//     this.keyboardType = TextInputType.text,
//     this.intialvalue,
//     this.inputFormatters,
//     this.showBorder = false, // default is false
//   });

//   @override
//   State<AppTextField> createState() => _AppTextFieldState();
// }

// class _AppTextFieldState extends State<AppTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(widget.borderRadius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//             color: AppColors.gray.withValues(alpha: 0.1),
//           ),
//           child: TextFormField(
//             controller: widget.controller,
//             style: TextStyle(
//               fontSize: 16,
//               color: AppColors.jetBlack,
//             ),
//             obscureText: widget.obscureText,
//             initialValue: widget.intialvalue,
//             inputFormatters: widget.inputFormatters ??
//                 [
//                   FilteringTextInputFormatter.allow(
//                       RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'))
//                 ],
//             maxLines: widget.maxLines,
//             minLines: widget.miniLines,
//             onTap: widget.onTap,
//             autovalidateMode: AutovalidateMode.always,
//             cursorColor: AppColors.primaryAppBar,
//             onChanged: widget.onChanged,
//             keyboardType: widget.keyboardType,
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.only(left: 16.0, top: 15, bottom: 15),
//               suffixIcon: widget.isSuffix ? widget.suffixIcon : null,
//               prefixIcon: widget.isPrefix ? widget.icon : null,
//               enabledBorder: widget.showBorder
//                   ? OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(widget.borderRadius),
//                       borderSide: BorderSide(
//                           color: AppColors.jetBlack.withValues(alpha: 0.4)),
//                     )
//                   : InputBorder.none,
//               focusedBorder: widget.showBorder
//                   ? OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(widget.borderRadius),
//                       borderSide: BorderSide(
//                           color: AppColors.primaryAppBar.withValues(alpha: 0.5)),
//                     )
//                   : InputBorder.none,
//               filled: true,
//               isDense: true,
//               fillColor: Colors.transparent,
//               hintText: widget.hint,
//               hintStyle: TextStyle(
//                   fontFamily: 'Sofia Sans',
//                   fontWeight: FontWeight.w400,
//                   fontSize: AppDimensions.FONT_SIZE_16,
//                   color: AppColors.gray.withValues(alpha: 0.5)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
