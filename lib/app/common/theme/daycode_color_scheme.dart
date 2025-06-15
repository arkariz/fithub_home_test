import 'package:flutter/material.dart';

const daycodeDarkColorScheme = ColorScheme.dark(
  primary: Color(0xFFFF5722),
  onPrimary: Colors.white,
  surface: Color(0xFF1E1E1E),
  onSurface: Color(0xFFFAFAFA),
  onSurfaceVariant: Color(0xFFB0B0B0),
  secondary: Color(0xFF44455A),
  surfaceContainerHigh: Color(0xFF2A2B3D),
  surfaceContainerHighest: Color(0xFF2A2B3D),
);

class DaycodeGradient {

  static LinearGradient get primaryColorGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFF5722), Color.fromARGB(255, 252, 172, 147)],
  );

  static LinearGradient get onSurfaceGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color.fromARGB(255, 85, 85, 85), Color.fromARGB(255, 139, 139, 139)],
  );

  static LinearGradient get backgroundGradient => const LinearGradient(
    colors: [
      Color(0xFF15141F),
      Color.fromARGB(255, 23, 22, 32),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
} 