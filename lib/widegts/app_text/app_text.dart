import 'package:xpk/utils/imports/app_imports.dart';
// ignore: non_constant_identifier_names
Widget AppText(
    {required String text,
    double size = AppDimensions.FONT_SIZE_16,
    TextDecoration underLine = TextDecoration.none,
    TextAlign textAlign = TextAlign.left,
    FontWeight fontWeight = FontWeight.w400,
    String fontFamily = "Poppins",
    FontStyle fontStyle = FontStyle.normal,
    int? maxLines,
    TextOverflow? overflow,
    Color? color = Colors.black,
    Color? underLineColor = Colors.black,
    TextStyle? style}) {
  return color == null
      ? Text(text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
                fontFamily: fontFamily,
                decoration: underLine,
                fontSize: size,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                color: color),
          ))

      // style ??
      //     GoogleFonts.getFont(fontFamily,
      //         fontSize: size,
      //         fontWeight: fontWeight,
      //         fontStyle: fontStyle,
      //         decoration: underLine,
      //         ))
      : Text(text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
                fontFamily: fontFamily,
                decoration: underLine,
                fontSize: size,
                fontWeight: fontWeight,
                fontStyle: fontStyle,
                color: color),
          )

          // style ??
          //     GoogleFonts.getFont(fontFamily,
          //         fontSize: size,
          //         fontWeight: fontWeight,
          //         fontStyle: fontStyle,
          //         decoration: underLine,
          //         color: color),
          );
}

// ignore: non_constant_identifier_names
Widget AppTextButton(
    {required String text,
    double size = 20,
    TextDecoration underLine = TextDecoration.none,
    TextAlign textAlign = TextAlign.left,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.black,
    required VoidCallback onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Text(text,
          textAlign: textAlign,
          style: GoogleFonts.robotoFlex(
            textStyle: TextStyle(
                //  fontFamily: fontFamily,
                decoration: underLine,
                fontSize: size,
                fontWeight: fontWeight,
                //  fontStyle: fontStyle,
                color: color),
          )));
}


// ignore: must_be_immutable
class HyperTxt extends StatelessWidget {
  String text = '';
  double? size;
  Color? color;
  TextAlign? align = TextAlign.center;
  bool? bold = false;
  Function? onTap;

  HyperTxt({
    super.key,
    required this.onTap,
    required this.text,
    this.bold,
    this.align,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        overflow: TextOverflow.fade,
        textAlign: align,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold == true ? FontWeight.w800 : FontWeight.w200,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MultiTxt extends StatelessWidget {
  String firstText;
  String? secondText;
  Color firstColor;
  String firstTextfontFamily;
  String secondTextfontFamily;

  MultiTxt({
    super.key,
    required this.firstText,
    this.secondText,
    this.firstTextfontFamily = "Light Grold",
    this.secondTextfontFamily = "Light Grold",
    this.firstColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(
                color: firstColor,
                fontSize: 15,
                fontFamily: firstTextfontFamily),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
                fontSize: 15,
                color: AppColors.jetBlack,
                fontFamily: secondTextfontFamily),
          ),
        ],
      ),
    );
  }
}
