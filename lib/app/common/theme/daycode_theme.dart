import 'package:fithub_home_test/app/common/theme/daycode_color_scheme.dart';
import 'package:fithub_home_test/app/common/theme/daycode_text_theme.dart';
import 'package:flutter/material.dart';

ThemeData daycodeDarkTheme(ThemeData theme, BuildContext context) => theme.copyWith(
  colorScheme: daycodeDarkColorScheme,
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    enableFeedback: false,
  ),
  cardTheme: CardTheme(
    color: daycodeDarkColorScheme.surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: daycodeDarkColorScheme.outline),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: daycodeDarkColorScheme.primary,
      foregroundColor: daycodeDarkColorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: daycodeDarkColorScheme.onSurfaceVariant.withAlpha(30),
    focusColor: daycodeDarkColorScheme.onSurfaceVariant,
    contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    hintStyle: TextStyle(
      color: daycodeDarkColorScheme.onSurfaceVariant,
      fontSize: 16
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  ),
  textTheme: daycodeTextTheme(daycodeDarkColorScheme, context),
);

class DaycodeTheme {
  static final instance = DaycodeTheme._internal();
  factory DaycodeTheme() => instance;
  DaycodeTheme._internal();

  late ThemeData theme;

  void init(BuildContext context) {
    theme = Theme.of(context);
  }

  static ThemeData dark(ThemeData theme, BuildContext context) => daycodeDarkTheme(theme, context);
}

