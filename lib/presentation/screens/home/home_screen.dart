import 'package:flutter/material.dart';
import 'package:quran_tv/core/constants/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.bgMosque),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Scaffold(),
      );
  }
}
