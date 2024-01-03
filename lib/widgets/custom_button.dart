import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_flutter/styles/colors.dart';

import 'headline_text.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color? textColor;
  final Color? borderColor;
  final void Function() onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? fontSize;
  final bool isUpper;
  final double borderRadius;
  final bool isLoading ;

  const MyButton({
    Key? key,
    this.color = AppColor.primaryColor,
    this.textColor,
    required this.onPressed,
    required this.text,
    this.width ,
    this.height,
    this.borderColor,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.topRightBorderRadius,
    this.topLeftBorderRadius,
    this.fontSize,
    required this.isLoading ,
    this.isUpper = true,
    this.borderRadius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading==false ? onPressed : (){},
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Container(
        height: height!.h,
        width: width ?? MediaQuery.of(context).size.width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          color: color,
        ),
        child: Center(
          child: isLoading ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(color: AppColor.white,strokeWidth: 1.5.w,semanticsLabel: 'loading',)): HeadLineText(
            text: text,
            color: textColor ?? AppColor.white,
            fontSize: fontSize ?? 16.sp,
            isUpper: isUpper,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

//Container(
//       width: width,
//       height: height ?? 52.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r),
//         gradient: LinearGradient(
//           begin: Alignment(0.00, -1.00),
//           end: Alignment(0, 1),
//           colors: [Color(0xFF5648C6), Color(0xFF3F32A4)],
//         ),
//         border: Border.all(
//           width: 1,
//           color: Color(0xff7563FF),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff000000).withOpacity(.14),
//             blurRadius: 1,
//             spreadRadius: 0,
//             blurStyle: BlurStyle.outer,
//             offset: Offset(0, 1),
//           ),
//           // BoxShadow(
//           //   color: Color(0xff4133AB),
//           //   blurRadius: 0,
//           //   spreadRadius: 1,
//           //   offset: Offset(0, 1),
//           //   blurStyle: BlurStyle.solid
//           // ),
//           // BoxShadow(
//           //   color: Color(0xff7563FF).withOpacity(.14),
//           //   blurRadius: 0,
//           //   spreadRadius: 0,
//           //   offset: Offset(0, 1),
//           // ),
//         ],
//
//       )
//
//       /// this important design
//       // BoxDecoration(
//       //   borderRadius: BorderRadius.circular(12),
//       //   gradient: LinearGradient(
//       //     begin: Alignment.topCenter,
//       //     end: Alignment.bottomCenter,
//       //     colors: [
//       //       Color(0xFF5648C7),
//       //       Color(0xFF3F32A4),
//       //     ],
//       //   ),
//       //   boxShadow: [
//       //     BoxShadow(
//       //       color: Color.fromRGBO(43, 31, 141, 0.10),
//       //       offset: Offset(0, 2),
//       //       blurRadius: 5,
//       //       spreadRadius: 0,
//       //     ),
//       //     BoxShadow(
//       //       color: Color(0xFF4133AB),
//       //       offset: Offset(0, 0),
//       //       blurRadius: 0,
//       //       spreadRadius: 1,
//       //     ),
//       //     BoxShadow(
//       //       color: Color.fromRGBO(0, 0, 0, 0.14),
//       //       offset: Offset(0, 1),
//       //       blurRadius: 1,
//       //       spreadRadius: 0,
//       //     ),
//       //     BoxShadow(
//       //       color: Color(0xFF7563FF),
//       //       offset: Offset(0, 1),
//       //       blurRadius: 0,
//       //       spreadRadius: .5,
//       //       // You can use 'inset' property to create an inset shadow.
//       //       // For example: spreadRadius: 0, offset: Offset(0, -1), blurRadius: 2, color: Color(0xFF7563FF).withOpacity(0.6)
//       //     ),
//       //   ],
//       // ),
//       ,
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: MaterialButton(
//         onPressed: onPressed,
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         child: HeadLineText(
//           text: text.tr(),
//           color: textColor ?? AppColor.white,
//           fontSize: fontSize ?? 16.sp,
//           isUpper: isUpper,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     )
