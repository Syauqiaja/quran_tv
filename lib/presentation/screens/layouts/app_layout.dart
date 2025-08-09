import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/config/routes/route.dart';
import 'package:quran_tv/presentation/components/navigation/app_navbar.dart';
import 'package:quran_tv/presentation/screens/downloads/downloads_screen.dart';
import 'package:quran_tv/presentation/screens/favorites/favorites_screen.dart';
import 'package:quran_tv/presentation/screens/home/home_screen.dart';
import 'package:quran_tv/presentation/screens/search/search_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final FocusScopeNode mainFocusNode = FocusScopeNode(
    debugLabel: 'MainLayout Node',
  );
  final FocusScopeNode navbarFocusNode = FocusScopeNode(
    debugLabel: 'Navbar Node',
  );

  int activeScreen = 0;

  late List<Widget> children;

  final List<FocusScopeNode> screenFocusNodes = [
    FocusScopeNode(debugLabel: 'Home Screen'),
    FocusScopeNode(debugLabel: 'Search Screen'),
    FocusScopeNode(debugLabel: 'Favorites Screen'),
    FocusScopeNode(debugLabel: 'Downloads Screen'),
  ];

  @override
  void initState() {
    children = [
      HomeScreen(
        parentScopeNode: mainFocusNode,
        focusScopeNode: screenFocusNodes[0],
      ),
      SearchScreen(),
      FavoritesScreen(),
      DownloadsScreen(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    navbarFocusNode.dispose();
    mainFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 64),
            child: AppNavbar(
              focusScopeNode: navbarFocusNode,
              parentNode: mainFocusNode,
              currentIndex: activeScreen,
              onRouteChange: _onRouteChange,
            ),
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: FocusScope(
              node: mainFocusNode,
              autofocus: true,
              onFocusChange: (value) {
                if(value){
                  print("Enter ${mainFocusNode.debugLabel}");
                    screenFocusNodes[activeScreen].requestFocus();
                }
              },
              onKeyEvent: (node, event) {
                if (event is KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
                      mainFocusNode.hasFocus) {
                    navbarFocusNode.requestFocus();
                    return KeyEventResult.handled;
                  }
                }

                return KeyEventResult.ignored;
              },
              child: children[activeScreen],
            ),
          ),
        ),
      ],
    );
  }

  void _onRouteChange(int index) {
    setState(() {
      activeScreen = index;
    });
  }
}
