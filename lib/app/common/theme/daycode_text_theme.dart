import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme daycodeTextTheme(ColorScheme colorScheme, BuildContext context) {

  return TextTheme(
    displayLarge: GoogleFonts.inter(
      color: colorScheme.onSurface,
      fontSize: 67.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: colorScheme.onSurface,
      fontSize: 55.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: colorScheme.onSurface,
      fontSize: 46.sp,
    ),
    headlineLarge: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 42.sp,
    ),
    headlineMedium: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 38.sp,
    ),
    headlineSmall: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 34.sp,
    ),
    bodyLarge: GoogleFonts.inter(
      color: colorScheme.onSurfaceVariant,
      fontSize: 20.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: colorScheme.onSurfaceVariant,
      fontSize: 16.sp,
    ),
    bodySmall: GoogleFonts.inter(
      color: colorScheme.onSurfaceVariant,
      fontSize: 12.sp,
    ),
    titleLarge: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 20.sp,
    ),
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 16.sp,
    ),
    titleSmall: GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
      fontSize: 12.sp,
    ),
    labelLarge: GoogleFonts.inter(
      color: colorScheme.secondary,
      fontSize: 18.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: colorScheme.secondary,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: colorScheme.secondary,
      fontSize: 10.sp,
    ),
  );
}
