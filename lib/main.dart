import 'package:flutter/material.dart';
import 'package:quran_tv/app.dart';
import 'package:quran_tv/core/di/injections.dart';


// App entrance
void main() {
  setupInjections();
  runApp(const MyApp());
}
