import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const coral = Color(0xFFFF6B4A);
  static const golden = Color(0xFFFFD166);
  static const mint = Color(0xFF06D6A0);
  static const navy = Color(0xFF1E293B);
  static const background = Color(0xFFF8F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const error = Color(0xFFEF4444);
  static const muted = Color(0xFF94A3B8);
  static const coralLight = Color(0xFFFFF0ED);
}

class AppTheme {
  static ThemeData get light {
    final base = GoogleFonts.nunitoTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coral,
        primary: AppColors.coral,
        secondary: AppColors.golden,
        tertiary: AppColors.mint,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: base.copyWith(
        headlineLarge: base.headlineLarge?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
        headlineMedium: base.headlineMedium?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w700),
        headlineSmall: base.headlineSmall?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w700),
        titleLarge: base.titleLarge?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w600),
        titleMedium: base.titleMedium?.copyWith(color: AppColors.navy, fontWeight: FontWeight.w600),
        bodyLarge: base.bodyLarge?.copyWith(color: AppColors.navy),
        bodyMedium: base.bodyMedium?.copyWith(color: AppColors.navy),
        bodySmall: base.bodySmall?.copyWith(color: AppColors.muted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.navy,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.navy),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coral,
          side: const BorderSide(color: AppColors.coral, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: TextStyle(color: AppColors.muted.withValues(alpha: 0.55)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.muted.withValues(alpha: 0.3))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.muted.withValues(alpha: 0.3))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.coral, width: 2)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.coral,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        enableFeedback: false,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        modalBackgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        modalBarrierColor: Colors.black45,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.surface,
        headerBackgroundColor: AppColors.surface,
        headerForegroundColor: AppColors.navy,
        headerHeadlineStyle: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.navy),
        headerHelpStyle: GoogleFonts.nunito(fontSize: 14, color: AppColors.muted),
        weekdayStyle: GoogleFonts.nunito(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.muted),
        dayStyle: GoogleFonts.nunito(fontSize: 14, color: AppColors.navy),
        yearStyle: GoogleFonts.nunito(fontSize: 16, color: AppColors.navy),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : AppColors.navy),
        dayOverlayColor: WidgetStateProperty.all(AppColors.coral.withValues(alpha: 0.1)),
        todayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : AppColors.navy),
        todayBorder: BorderSide.none,
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : AppColors.navy),
        yearOverlayColor: WidgetStateProperty.all(AppColors.coral.withValues(alpha: 0.1)),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.navy),
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.muted),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
