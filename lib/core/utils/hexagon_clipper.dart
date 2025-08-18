import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;
    final double side = w / 2;
    final double triangleHeight = h / 2;

    path.moveTo(triangleHeight, 0);
    path.lineTo(w - triangleHeight, 0);
    path.lineTo(w, triangleHeight);
    path.lineTo(w - triangleHeight, h);
    path.lineTo(triangleHeight, h);
    path.lineTo(0, triangleHeight);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}