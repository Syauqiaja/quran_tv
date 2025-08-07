import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/config/routes/route_names.dart';
import 'package:quran_tv/presentation/screens/layouts/app_layout.dart';

// part 'navbar_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteNames.home,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) {
        return AppLayout();
      },
    ),
  ],
);
