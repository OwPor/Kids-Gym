import 'package:flutter/material.dart';

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
  // Dark mode palette
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkText = Color(0xFFF1F5F9);
}

class AppTheme {
  // Built once — ColorScheme.fromSeed is expensive, never rebuild per frame.
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : AppColors.background;
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final onSurface = isDark ? AppColors.darkText : AppColors.navy;

    final base = ThemeData(brightness: brightness).textTheme.apply(fontFamily: 'Nunito');

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coral,
        brightness: brightness,
        primary: AppColors.coral,
        secondary: AppColors.golden,
        tertiary: AppColors.mint,
        surface: surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: background,
      textTheme: base.copyWith(
        headlineLarge: base.headlineLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w800),
        headlineMedium: base.headlineMedium?.copyWith(color: onSurface, fontWeight: FontWeight.w700),
        headlineSmall: base.headlineSmall?.copyWith(color: onSurface, fontWeight: FontWeight.w700),
        titleLarge: base.titleLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w600),
        titleMedium: base.titleMedium?.copyWith(color: onSurface, fontWeight: FontWeight.w600),
        bodyLarge: base.bodyLarge?.copyWith(color: onSurface),
        bodyMedium: base.bodyMedium?.copyWith(color: onSurface),
        bodySmall: base.bodySmall?.copyWith(color: AppColors.muted),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontFamily: 'Nunito', fontSize: 20, fontWeight: FontWeight.w700, color: onSurface),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: TextStyle(fontFamily: 'Nunito', fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coral,
          side: const BorderSide(color: AppColors.coral, width: 2),
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: TextStyle(fontFamily: 'Nunito', fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: AppColors.muted.withValues(alpha: 0.55)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.muted.withValues(alpha: 0.3))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.muted.withValues(alpha: 0.3))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.coral, width: 2)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: AppColors.coral,
        unselectedItemColor: AppColors.muted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        enableFeedback: false,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        modalBarrierColor: Colors.black45,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: surface,
        headerBackgroundColor: surface,
        headerForegroundColor: onSurface,
        headerHeadlineStyle: TextStyle(fontFamily: 'Nunito', fontSize: 28, fontWeight: FontWeight.w800, color: onSurface),
        headerHelpStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: AppColors.muted),
        weekdayStyle: TextStyle(fontFamily: 'Nunito', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.muted),
        dayStyle: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: onSurface),
        yearStyle: TextStyle(fontFamily: 'Nunito', fontSize: 16, color: onSurface),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : onSurface),
        dayOverlayColor: WidgetStateProperty.all(AppColors.coral.withValues(alpha: 0.1)),
        todayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : onSurface),
        todayBorder: BorderSide.none,
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.coral : null),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : onSurface),
        yearOverlayColor: WidgetStateProperty.all(AppColors.coral.withValues(alpha: 0.1)),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: onSurface),
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.muted),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
