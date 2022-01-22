import 'package:flutter/material.dart';

import 'package:chata/app/custom/arimo_text.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    this.text,
    this.width,
    this.height,
    this.primaryColor,
    this.textColor,
    this.elevation,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String? text;
  final double? width;
  final double? height;
  final Color? primaryColor;
  final Color? textColor;
  final double? elevation;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 15,
          ),
        ),
        minimumSize: Size(
          width ?? 100.w,
          height ?? 7.h,
        ),
        primary: primaryColor ?? Colors.orangeAccent.shade400,
      ),
      child: AText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        textColor: textColor,
      ),
    );
  }
}
