
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_flutter/global_cubit/global_cubit.dart';

class MediumText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final double fontSize;
  final int maxLines;
  final bool isUnderLine;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  const MediumText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize = 14,
    this.maxLines = 3,
    this.fontFamily,
    this.isUnderLine = false,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = GlobalCubit.get(context);
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? cubit.mediumTextColor,
        fontSize: fontSize.sp,
          decoration: isUnderLine == false
              ? TextDecoration.none
              : TextDecoration.underline,
        overflow: overflow,
        fontWeight: fontWeight ?? FontWeight.w700,
          fontFamily: fontFamily ?? 'Regular'
      ),
      maxLines: maxLines,
    );
  }
}
