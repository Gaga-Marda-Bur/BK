import 'package:flutter/material.dart';

class AppColors {
  static const Color darkGreen = Color(0xFF1B4D3E);
  static const Color darkerGreen = Color(0xFF0F3227);
  static const Color gold = Color(0xFFD4AF37);
  
  // Couleurs avec opacité prédéfinies
  static Color goldOpacity02 = Color.alphaBlend(
    gold.withAlpha((0.2 * 255).round()),
    Colors.transparent,
  );
  
  static Color goldOpacity03 = Color.alphaBlend(
    gold.withAlpha((0.3 * 255).round()),
    Colors.transparent,
  );
  
  static Color goldOpacity05 = Color.alphaBlend(
    gold.withAlpha((0.5 * 255).round()),
    Colors.transparent,
  );
  
  static Color goldOpacity08 = Color.alphaBlend(
    gold.withAlpha((0.8 * 255).round()),
    Colors.transparent,
  );
  
  static Color whiteOpacity70 = Color.alphaBlend(
    Colors.white.withAlpha((0.7 * 255).round()),
    Colors.transparent,
  );
  
  static Color whiteOpacity54 = Color.alphaBlend(
    Colors.white.withAlpha((0.54 * 255).round()),
    Colors.transparent,
  );
  
  static Color whiteOpacity50 = Color.alphaBlend(
    Colors.white.withAlpha((0.5 * 255).round()),
    Colors.transparent,
  );
  
  static Color whiteOpacity24 = Color.alphaBlend(
    Colors.white.withAlpha((0.24 * 255).round()),
    Colors.transparent,
  );
  
  static Color blackOpacity03 = Color.alphaBlend(
    Colors.black.withAlpha((0.3 * 255).round()),
    Colors.transparent,
  );
  
  static Color blackOpacity05 = Color.alphaBlend(
    Colors.black.withAlpha((0.5 * 255).round()),
    Colors.transparent,
  );
  
  static Color blackOpacity08 = Color.alphaBlend(
    Colors.black.withAlpha((0.8 * 255).round()),
    Colors.transparent,
  );
  
  // Méthodes pour générer des couleurs avec opacité dynamique (si nécessaire)
  static Color goldWithOpacity(double opacity) {
    return gold.withAlpha((opacity * 255).round());
  }
  
  static Color darkGreenWithOpacity(double opacity) {
    return darkGreen.withAlpha((opacity * 255).round());
  }
  
  static Color darkerGreenWithOpacity(double opacity) {
    return darkerGreen.withAlpha((opacity * 255).round());
  }
  
  static Color whiteWithOpacity(double opacity) {
    return Colors.white.withAlpha((opacity * 255).round());
  }
  
  static Color blackWithOpacity(double opacity) {
    return Colors.black.withAlpha((opacity * 255).round());
  }
}