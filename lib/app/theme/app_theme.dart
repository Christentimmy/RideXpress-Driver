import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black45,
    ),
  ),
);
