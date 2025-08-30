import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/presentation/screens/home/home_screen.dart';
import 'package:quran_tv/presentation/screens/quran/quran_play_screen.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/reciter_detail_screen.dart';
import 'package:quran_tv/presentation/screens/settings/settings_screen.dart';
import 'package:quran_tv/presentation/screens/subscription/subscription_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    HomeRoute(),
    ReciterDetailRoute(),
    QuranPlayRoute(),
    SettingsRoute(),
    SubscriptionRoute(),
  ],
);