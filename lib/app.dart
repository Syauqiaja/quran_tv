import 'package:flutter/material.dart';
import 'package:quran_tv/config/routes/route.dart';
import 'package:quran_tv/config/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Altara Quran TV',
      theme: darkTheme,
      routerConfig: router,
    );
  }
}
