import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/presentation/components/navigation/app_navbar.dart';

class AppLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(body: navigationShell),
        Positioned(top: 0, left: 0, right: 0, child: AppNavbar()),
      ],
    );
  }
}
