import 'package:flutter/material.dart';

/// Paleta "verde bosque" de Talavera Dolores.
class Colores {
  static const bosque = Color(0xFF1F4D3A); // verde principal
  static const bosqueOscuro = Color(0xFF15382A);
  static const salvia = Color(0xFFDCE8DF); // verde clarito para fondos
  static const musgo = Color(0xFF6E8B74); // verde grisáceo para textos suaves
  static const crema = Color(0xFFF6F5EF); // fondo general
  static const dorado = Color(0xFFC9A55C); // acento
  static const tinta = Color(0xFF1C2A22); // texto principal
  static const borde = Color(0xFFE3E6DD);
}

class TemaTalavera {
  static ThemeData get claro {
    const esquema = ColorScheme(
      brightness: Brightness.light,
      primary: Colores.bosque,
      onPrimary: Colors.white,
      primaryContainer: Colores.salvia,
      onPrimaryContainer: Colores.bosqueOscuro,
      secondary: Colores.dorado,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF1E6CC),
      onSecondaryContainer: Color(0xFF4A3A14),
      error: Color(0xFFB3261E),
      onError: Colors.white,
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      surface: Colors.white,
      onSurface: Colores.tinta,
      onSurfaceVariant: Colores.musgo,
      outline: Colores.borde,
    );

    final redondo = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      scaffoldBackgroundColor: Colores.crema,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colores.crema,
        foregroundColor: Colores.bosqueOscuro,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colores.bosqueOscuro,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colores.borde),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Colores.bosque,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: redondo,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colores.bosque,
          side: const BorderSide(color: Colores.bosque),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: redondo,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colores.bosque),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colores.borde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colores.borde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colores.bosque, width: 1.6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: Colores.bosque,
        checkmarkColor: Colors.white,
        side: const BorderSide(color: Colores.borde),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: const TextStyle(color: Colores.tinta),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Colores.salvia,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected) ? Colores.bosque : Colores.musgo,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontSize: 12,
            fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w400,
            color: s.contains(WidgetState.selected) ? Colores.bosque : Colores.musgo,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colores.bosqueOscuro,
        behavior: SnackBarBehavior.floating,
      ),
      badgeTheme: const BadgeThemeData(backgroundColor: Colores.dorado),
      dividerTheme: const DividerThemeData(color: Colores.borde),
    );
  }
}
