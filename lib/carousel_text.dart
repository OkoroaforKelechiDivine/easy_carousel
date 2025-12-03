import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? overflow;
  final int? maxLines;

  const CarouselText({
    super.key,
    required this.text,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style;
    if (fontFamily != null) {
      style = GoogleFonts.getFont(
        fontFamily!,
        color: color ?? Colors.black,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
      );
    } else {
      style = TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
      );
    }

    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style,
    );
  }
}