import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_flutter/global_cubit/global_cubit.dart';

class HeadLineText extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final double fontSize;
  final int maxLines;
  final bool? isUpper;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow overflow;

  const HeadLineText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize = 16,
    this.maxLines = 1,
    this.fontFamily,
    this.overflow = TextOverflow.ellipsis,
    this.isUpper = true,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = GlobalCubit.get(context);
    return Text(
      isUpper! ? text.toUpperCase() : text,
      style: TextStyle(
          color: color ?? cubit.headLineTextColor,
          fontWeight: fontWeight ?? FontWeight.w700,
          fontSize: fontSize.sp,
          overflow: overflow,
      fontFamily:fontFamily??  'Bold',
      ),
      maxLines: maxLines,
      textAlign: textAlign,

    );
  }
}
