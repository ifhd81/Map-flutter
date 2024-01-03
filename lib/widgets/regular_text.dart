
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_flutter/global_cubit/global_cubit.dart';

class RegularText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final double lineHeight;
  final bool isLineThrow;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow overflow;
  final String? fontFamily;

  const RegularText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize = 13,
    this.maxLines = 10,
    this.fontWeight,
    this.fontFamily,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.lineHeight = 1.5,
    this.isLineThrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = GlobalCubit.get(context);
    return Text(
      text,
      style: TextStyle(
        color: color ?? cubit.regularTextColor,
        fontSize: fontSize.sp,
        overflow: overflow,
        decoration: isLineThrow == false
            ? TextDecoration.none
            : TextDecoration.lineThrough,
        height: lineHeight,
        fontWeight: fontWeight ?? FontWeight.w500,
          fontFamily: fontFamily ?? 'SemiBold'
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
