part of 'route.dart';

final _sectionNavigatorKey = GlobalKey<NavigatorState>();

/// This route settings the main layout of QuranTV App.
/// which handle navigations between :
/// - [HomeScreen] 
/// - [SearchScreen]
/// - [FavoritesScreen]
/// - [DownloadsScreen]
final _navbarRoute = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return AppLayout(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _sectionNavigatorKey,
      routes: [
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => HomeScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _sectionNavigatorKey,
      routes: [
        GoRoute(
          path: RouteNames.search,
          builder: (context, state) => SearchScreen(),
        ),
      ],
    ),

    StatefulShellBranch(
      navigatorKey: _sectionNavigatorKey,
      routes: [
        GoRoute(
          path: RouteNames.favorites,
          builder: (context, state) => FavoritesScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _sectionNavigatorKey,
      routes: [
        GoRoute(
          path: RouteNames.downloads,
          builder: (context, state) => DownloadsScreen(),
        ),
      ],
    ),
  ],
);
