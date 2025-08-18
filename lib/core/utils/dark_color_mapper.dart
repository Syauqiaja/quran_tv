import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DarkThemeColorMapper extends ColorMapper {
  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    // Debug print to see what's being processed
    print(
      'ColorMapper - ID: $id, Element: $elementName, Attribute: $attributeName, Color: $color',
    );

    // Change specific SVG element by id
    if (id == 'special-path') {
      return Colors.deepPurple;
    }

    // Change by attribute (like fill/stroke)
    if (attributeName == 'fill') {
      return Colors.grey.shade300;
    }

    // Map black colors to white in dark theme
    if (color == const Color(0xFF000000)) {
      return Colors.white;
    }

    // Alternative: check if color is very dark and make it light
    if (color.computeLuminance() < 0.3) {
      return Colors.white;
    }

    // Default: return white for all colors (if you want everything white)
    return Colors.white;

    // Or return original color if you want selective mapping
    // return color;
  }
}