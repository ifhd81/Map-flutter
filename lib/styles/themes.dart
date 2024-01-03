import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColor.white,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColor.white,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 12,
    elevation: 0,
    scrolledUnderElevation : 0 ,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.black54,
    ),
    backgroundColor: AppColor.white,
    iconTheme: const IconThemeData(
      color: Colors.black54,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24.sp,
      color: AppColor.black,
      fontFamily: 'Bold',
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColor.white,
    selectedItemColor: AppColor.red,
    unselectedItemColor: AppColor.backgroundGreyColor,
    elevation: 0,
    selectedLabelStyle: TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 12.sp,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 12.sp,
    ),
    selectedIconTheme: const IconThemeData(
      size: 20,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 20,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColor.black,
  ),
  fontFamily: 'Regular',
  cardColor: AppColor.backgroundGreyColor,
  cardTheme: CardTheme(
    color: AppColor.backgroundGreyColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.r),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColor.black,
  appBarTheme: const AppBarTheme(
    titleSpacing: 12,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: AppColor.black,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: AppColor.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'Bold',
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0xff242526),
    selectedItemColor: AppColor.primaryColor,
    unselectedItemColor: AppColor.white,
    elevation: 0,
    selectedLabelStyle: TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 12.sp,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'SemiBold',
      fontSize: 12.sp,
    ),
    selectedIconTheme: const IconThemeData(
      size: 20,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 20,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Color(0xFFD4D4D4),
    ),
  ),
  fontFamily: 'Regular',
  iconTheme: const IconThemeData(
    color: AppColor.white,
  ),
  cardColor: const Color(0xff242526),
  cardTheme: CardTheme(
    color: const Color(0xff242526),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.r),
      ),
    ),
  ),
);
