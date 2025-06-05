import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color surfaceColor = Color(0xFFFFFBFE);
  static const Color errorColor = Color(0xFFBA1A1A);
  
  // Cores específicas da Splash Screen
  static const Color splashBrownTop = Color(0xFF715848);
  static const Color splashBrownBottom = Color(0xFFBE7E51);
  static const Color splashGreenTop = Color(0xFF73C086);
  static const Color splashRedBottom = Color(0xFFE85A5A);
  
  // Cores da tela de escolha de idioma
  static const Color languageScreenBackground = Color(0xFFFFEDD3);
  static const Color languageCardBackground = Color(0xFFFCDFB6);
  static const Color languageCardBorder = Color(0xFF715848);
  static const Color textPrimary = Color(0xFF444444);
  static const Color primaryButton = Color(0xFF73C086);
  static const Color primaryButtonShadow = Color(0xFF347F43);
  
  // Cores da home screen
  static const Color homeClimateCard = Color(0xFF73C086);
  static const Color homeAmbientalCard = Color(0xFFE85A5A);
  static const Color homeBiologicalCard = Color(0xFF345995);
  static const Color homeBottomMenu = Color(0xFF262626);
  static const Color homeSelectedIconStart = Color(0xFF345995);
  static const Color homeSelectedIconEnd = Color(0xFF3AAEF8);
  static const Color homeUnselectedIcon = Color(0xFFADAFC0);
  static const Color homeMicrophoneIcon = Color(0xFFF1F1F1);
  static const Color homeMicrophoneGradientStart = Color(0xFFE85A5A);
  static const Color homeMicrophoneGradientEnd = Color(0xFF73C086);
  
  // Cores com opacidade
  static Color get textSecondary => textPrimary.withValues(alpha: 0.6);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'DINNext',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.largePadding,
            vertical: AppConstants.defaultPadding,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'DINNext',
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.largePadding,
            vertical: AppConstants.defaultPadding,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
      ),
    );
  }
} 