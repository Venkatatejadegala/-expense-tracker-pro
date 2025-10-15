import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  final String name;
  final ColorScheme colorScheme;
  final Color scaffoldBackground;
  final Color cardBackground;
  final Color primaryGradientStart;
  final Color primaryGradientEnd;

  const AppTheme({
    required this.name,
    required this.colorScheme,
    required this.scaffoldBackground,
    required this.cardBackground,
    required this.primaryGradientStart,
    required this.primaryGradientEnd,
  });

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      
      // Enhanced AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: cardBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Enhanced Text Theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w900,
          fontSize: 32,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: colorScheme.onBackground.withOpacity(0.9),
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.onBackground.withOpacity(0.7),
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      
      // Enhanced Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.6)),
        hintStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.4)),
      ),
      
      // Enhanced Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      
      // Enhanced Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 8,
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'selected_theme';
  AppTheme _currentTheme = _themes[0]; // Default to first theme
  
  AppTheme get currentTheme => _currentTheme;
  
  static List<AppTheme> get _themes => [
    // Modern Indigo
    AppTheme(
      name: 'Modern Indigo',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.dark,
        primary: const Color(0xFF6366F1),
        secondary: const Color(0xFF8B5CF6),
        surface: const Color(0xFF1E1E2E),
        onSurface: const Color(0xFFE2E8F0),
      ),
      scaffoldBackground: const Color(0xFF0F0F23),
      cardBackground: const Color(0xFF1E1E2E),
      primaryGradientStart: const Color(0xFF6366F1),
      primaryGradientEnd: const Color(0xFF8B5CF6),
    ),
    
    // Deep Ocean
    AppTheme(
      name: 'Deep Ocean',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0EA5E9),
        brightness: Brightness.dark,
        primary: const Color(0xFF0EA5E9),
        secondary: const Color(0xFF06B6D4),
        surface: const Color(0xFF1E293B),
        onSurface: const Color(0xFFF1F5F9),
      ),
      scaffoldBackground: const Color(0xFF0F172A),
      cardBackground: const Color(0xFF1E293B),
      primaryGradientStart: const Color(0xFF0EA5E9),
      primaryGradientEnd: const Color(0xFF06B6D4),
    ),
    
    // Forest Green
    AppTheme(
      name: 'Forest Green',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF059669),
        brightness: Brightness.dark,
        primary: const Color(0xFF059669),
        secondary: const Color(0xFF10B981),
        surface: const Color(0xFF1F2937),
        onSurface: const Color(0xFFF9FAFB),
      ),
      scaffoldBackground: const Color(0xFF111827),
      cardBackground: const Color(0xFF1F2937),
      primaryGradientStart: const Color(0xFF059669),
      primaryGradientEnd: const Color(0xFF10B981),
    ),
    
    // Sunset Orange
    AppTheme(
      name: 'Sunset Orange',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFEA580C),
        brightness: Brightness.dark,
        primary: const Color(0xFFEA580C),
        secondary: const Color(0xFFF97316),
        surface: const Color(0xFF292524),
        onSurface: const Color(0xFFFAFAF9),
      ),
      scaffoldBackground: const Color(0xFF1C1917),
      cardBackground: const Color(0xFF292524),
      primaryGradientStart: const Color(0xFFEA580C),
      primaryGradientEnd: const Color(0xFFF97316),
    ),
    
    // Royal Purple
    AppTheme(
      name: 'Royal Purple',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7C3AED),
        brightness: Brightness.dark,
        primary: const Color(0xFF7C3AED),
        secondary: const Color(0xFFA855F7),
        surface: const Color(0xFF2D1B69),
        onSurface: const Color(0xFFF3F4F6),
      ),
      scaffoldBackground: const Color(0xFF1E1B4B),
      cardBackground: const Color(0xFF2D1B69),
      primaryGradientStart: const Color(0xFF7C3AED),
      primaryGradientEnd: const Color(0xFFA855F7),
    ),
    
    // Cherry Red
    AppTheme(
      name: 'Cherry Red',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFDC2626),
        brightness: Brightness.dark,
        primary: const Color(0xFFDC2626),
        secondary: const Color(0xFFEF4444),
        surface: const Color(0xFF3F1F1F),
        onSurface: const Color(0xFFFEF2F2),
      ),
      scaffoldBackground: const Color(0xFF2C1810),
      cardBackground: const Color(0xFF3F1F1F),
      primaryGradientStart: const Color(0xFFDC2626),
      primaryGradientEnd: const Color(0xFFEF4444),
    ),
  ];
  
  List<AppTheme> get availableThemes => _themes;
  
  ThemeProvider() {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      if (themeIndex < _themes.length) {
        _currentTheme = _themes[themeIndex];
        notifyListeners();
      }
    } catch (e) {
      // If loading fails, use default theme
      _currentTheme = _themes[0];
    }
  }
  
  Future<void> setTheme(int themeIndex) async {
    if (themeIndex >= 0 && themeIndex < _themes.length) {
      _currentTheme = _themes[themeIndex];
      notifyListeners();
      
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_themeKey, themeIndex);
      } catch (e) {
        // Handle error silently
      }
    }
  }
  
  Future<void> setThemeByName(String themeName) async {
    final themeIndex = _themes.indexWhere((theme) => theme.name == themeName);
    if (themeIndex != -1) {
      await setTheme(themeIndex);
    }
  }
}
