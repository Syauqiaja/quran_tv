class SvgStyleConverter {
  /// Converts SVG with CSS classes to inline styles
  static String convertClassesToInlineStyles(
    String svgString, {
    bool isDarkMode = false,
  }) {
    // Extract CSS styles from <style> tags
    final Map<String, Map<String, String>> cssClasses = _extractCssClasses(
      svgString,
    );

    // Apply theme-specific modifications
    if (isDarkMode) {
      _applyDarkModeStyles(cssClasses);
    }

    // Remove <style> tags and unwanted elements from SVG
    String result = _cleanSvg(svgString);

    // Convert class attributes to inline styles
    result = _convertClassesToInline(result, cssClasses);

    return result;
  }

  /// Apply dark mode color transformations
  static void _applyDarkModeStyles(
    Map<String, Map<String, String>> cssClasses,
  ) {
    // Transform quran-text class for dark mode
    if (cssClasses.containsKey('quran-text')) {
      cssClasses['quran-text']!['fill'] = '#FFFFFF'; // White text for dark mode
    }

    // Transform aya-dark class for dark mode
    if (cssClasses.containsKey('aya-dark')) {
      cssClasses['aya-dark']!['stroke'] =
          '#FFFFFF'; // White stroke for dark mode
    }

    // Hide night class elements in light mode, show in dark mode
    if (cssClasses.containsKey('night')) {
      cssClasses['night']!.remove(
        'display',
      ); // Remove display:none for dark mode
    }

    // Hide day class elements in dark mode
    if (cssClasses.containsKey('day')) {
      cssClasses['day']!['display'] = 'none'; // Hide day elements in dark mode
    }
  }

  /// Extract CSS classes and their properties from <style> tags
  static Map<String, Map<String, String>> _extractCssClasses(String svgString) {
    final Map<String, Map<String, String>> cssClasses = {};

    // Find all <style> content
    final styleRegex = RegExp(r'<style[^>]*>(.*?)</style>', dotAll: true);
    final styleMatches = styleRegex.allMatches(svgString);

    for (final match in styleMatches) {
      final styleContent = match.group(1) ?? '';

      // Parse CSS rules
      final classRegex = RegExp(r'\.([^{]+)\s*\{([^}]+)\}');
      final classMatches = classRegex.allMatches(styleContent);

      for (final classMatch in classMatches) {
        final className = classMatch.group(1)?.trim() ?? '';
        final properties = classMatch.group(2) ?? '';

        cssClasses[className] = _parseProperties(properties);
      }
    }

    return cssClasses;
  }

  /// Parse CSS properties string into map
  static Map<String, String> _parseProperties(String properties) {
    final Map<String, String> props = {};

    final propRegex = RegExp(r'([^:;]+):([^:;]+)(?:;|$)');
    final matches = propRegex.allMatches(properties);

    for (final match in matches) {
      final prop = match.group(1)?.trim() ?? '';
      final value = match.group(2)?.trim() ?? '';
      if (prop.isNotEmpty && value.isNotEmpty) {
        props[prop] = value;
      }
    }

    return props;
  }

  /// Remove <style> tags and cleanup SVG for Flutter
  static String _cleanSvg(String svgString) {
    String result = svgString;

    // Remove <style> tags
    result = result.replaceAll(
      RegExp(r'<style[^>]*>.*?</style>', dotAll: true),
      '',
    );

    // Clean up extra whitespace
    result = result.replaceAll(RegExp(r'\s+'), ' ');
    result = result.replaceAll(RegExp(r'>\s+<'), '><');

    return result;
  }

  /// Convert class attributes to inline styles
  static String _convertClassesToInline(
    String svgString,
    Map<String, Map<String, String>> cssClasses,
  ) {
    // Find all elements with class attributes
    final classRegex = RegExp(r'(<[^>]+)class="([^"]*)"([^>]*>)');

    return svgString.replaceAllMapped(classRegex, (match) {
      final beforeClass = match.group(1) ?? '';
      final classNames = match.group(2) ?? '';
      final afterClass = match.group(3) ?? '';

      // Get existing style attribute if any
      final existingStyleRegex = RegExp(r'style="([^"]*)"');
      final existingStyleMatch = existingStyleRegex.firstMatch(
        beforeClass + afterClass,
      );
      final existingStyle = existingStyleMatch?.group(1) ?? '';

      // Build new style string
      final List<String> styleProperties = [];

      // Add existing styles first
      if (existingStyle.isNotEmpty) {
        styleProperties.add(existingStyle);
      }

      // Add styles from classes
      for (final className in classNames.split(' ')) {
        final trimmedClass = className.trim();
        if (trimmedClass.isNotEmpty && cssClasses.containsKey(trimmedClass)) {
          final classStyles = cssClasses[trimmedClass]!;
          for (final entry in classStyles.entries) {
            styleProperties.add('${entry.key}: ${entry.value}');
          }
        }
      }

      // Remove existing style attribute if present
      String elementStart = beforeClass.replaceAll(existingStyleRegex, '');
      String elementEnd = afterClass.replaceAll(existingStyleRegex, '');

      // Add new style attribute
      if (styleProperties.isNotEmpty) {
        final styleString = styleProperties.join('; ');
        return '$elementStart style="$styleString"$elementEnd';
      } else {
        return '$elementStart$elementEnd';
      }
    });
  }
}