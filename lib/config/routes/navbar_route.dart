// part of 'route.dart';

// final _homeNavigatorKey = GlobalKey<NavigatorState>();
// final _searchNavigatorKey = GlobalKey<NavigatorState>();
// final _favoritesNavigatorKey = GlobalKey<NavigatorState>();
// final _downloadsNavigatorKey = GlobalKey<NavigatorState>();

// /// This route settings the main layout of QuranTV App.
// /// which handle navigations between :
// /// - [HomeScreen]
// /// - [SearchScreen]
// /// - [FavoritesScreen]
// /// - [DownloadsScreen]
// final _navbarRoute = StatefulShellRoute.indexedStack(
//   builder: (context, state, navigationShell) {
//     return AppLayout();
//   },
//   branches: [
//     StatefulShellBranch(
//       navigatorKey: _homeNavigatorKey,
//       routes: [
//         GoRoute(
//           path: RouteNames.home,
//           builder: (context, state) => const HomeScreen(),
//         ),
//       ],
//     ),
//     StatefulShellBranch(
//       navigatorKey: _searchNavigatorKey,
//       routes: [
//         GoRoute(
//           path: RouteNames.search,
//           builder: (context, state) => const SearchScreen(),
//         ),
//       ],
//     ),
//     StatefulShellBranch(
//       navigatorKey: _favoritesNavigatorKey,
//       routes: [
//         GoRoute(
//           path: RouteNames.favorites,
//           builder: (context, state) => const FavoritesScreen(),
//         ),
//       ],
//     ),
//     StatefulShellBranch(
//       navigatorKey: _downloadsNavigatorKey,
//       routes: [
//         GoRoute(
//           path: RouteNames.downloads,
//           builder: (context, state) => const DownloadsScreen(),
//         ),
//       ],
//     ),
//   ],
// );
