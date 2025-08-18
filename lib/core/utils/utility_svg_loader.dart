// Utility class for loading and caching converted SVGs
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/core/utils/svg_style_converter.dart';

class QuranSvgLoader {
  static final Map<String, String> _cache = {};

  /// Load SVG from assets and convert it, with caching
  static Future<String> loadConvertedSvg(
    String assetPath, {
    bool isDarkMode = false,
  }) async {
    final cacheKey = '${assetPath}_${isDarkMode ? 'dark' : 'light'}';

    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final svgString = await rootBundle.loadString(assetPath);
      final converted = SvgStyleConverter.convertClassesToInlineStyles(
        svgString,
        isDarkMode: isDarkMode,
      );

      _cache[cacheKey] = converted;
      return converted;
    } catch (e) {
      debugPrint('Error loading SVG: $e');
      return '';
    }
  }

  /// Clear the cache (useful for memory management)
  static void clearCache() {
    _cache.clear();
  }
}
