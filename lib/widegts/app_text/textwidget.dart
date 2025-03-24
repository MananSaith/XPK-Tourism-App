import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpk/utils/app_color/app_color.dart';
import 'package:xpk/utils/fonts/app_fonts.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  final String text;
  double fSize;
  FontWeight? fWeight = FontWeights.regular;
  Color? textColor = AppColors.jetBlack;
  final int? maxLine;
  final bool overFlow;
  final bool dir;
  final TextAlign? align;

  TextWidget({
    super.key,
    this.align,
    required this.text,
    required this.fSize,
    this.fWeight,
    this.textColor,
    this.maxLine, // Allow multiple lines by default
    this.overFlow = false, // Properly initialize optional fields
    this.dir = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: fWeight,
        fontSize: fSize,
        color: textColor,
      ),
      textAlign: align ?? TextAlign.start,
      maxLines: maxLine, // Allow the widget to display multiple lines
      overflow: overFlow
          ? TextOverflow.ellipsis
          : TextOverflow.visible, // Handle text overflow
      textDirection: dir ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}
