import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AText extends StatelessWidget {
  const AText({
    Key? key,
    this.text,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.overflow,
    this.fontWeight,
    this.decoration,
    this.maxLines,
  }) : super(key: key);
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      '$text',
      style: GoogleFonts.arimo(
        fontSize: fontSize ?? 14,
        color: textColor ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
        decoration: decoration,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
