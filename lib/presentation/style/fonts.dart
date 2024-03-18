import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class Fonts {
   static TextStyle nextBoard = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
      static TextStyle skipBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
        static TextStyle main = TextStyle(
      fontSize: 24.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
      static TextStyle labelBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
      static TextStyle labelGreyBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
}