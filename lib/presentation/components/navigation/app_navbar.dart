import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/presentation/screens/settings/settings_screen.dart';

class AppNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onRouteChange;
  final FocusScopeNode focusScopeNode;
  final FocusScopeNode parentNode;

  const AppNavbar({
    super.key,
    required this.onRouteChange,
    required this.currentIndex,
    required this.focusScopeNode,
    required this.parentNode,
  });

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  final List<String> labels = ['Home', 'Search', 'Favorites', 'Downloads'];

  final List<FocusNode> focusNodes = [
    FocusNode(debugLabel: 'Home Navlink'),
    FocusNode(debugLabel: 'Search Navlink'),
    FocusNode(debugLabel: 'Favorite Navlink'),
    FocusNode(debugLabel: 'Download Navlink'),
    FocusNode(debugLabel: 'Setting Navlink'),
  ];

  @override
  void initState() {
    print("Navbar re-inits");
    super.initState();
  }

  @override
  void dispose() {
    for (var e in focusNodes) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: FocusScope(
                  node: widget.focusScopeNode,
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      print('Enter ${widget.focusScopeNode.debugLabel}');
                      focusNodes[widget.currentIndex].requestFocus();
                    } else {
                      print('Exit ${widget.focusScopeNode.debugLabel}');
                    }
                  },
                  descendantsAreFocusable: true,
                  child: FocusTraversalGroup(
                    child: Row(
                      children: [
                        for (int index = 0; index < labels.length; index++)
                          _buildNavButton(
                            context,
                            label: labels[index],
                            index: index,
                            focusNode: focusNodes[index],
                          ),
                        Spacer(),
                        IconButton(onPressed: (){
                          SettingsRoute.push(context);
                        }, icon: Icon(Icons.settings)),
                        const SizedBox(width: 8),
                        OutlinedButton(onPressed: (){

                        }, child: Row(
                          spacing: 8,
                          children: [
                            Text("QuranTV Pro"),
                            Icon(Icons.menu_book_rounded)
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required String label,
    required int index,
    required FocusNode focusNode,
  }) {
    final bool isSelected = widget.currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FocusTraversalOrder(
        order: NumericFocusOrder(index.toDouble()),
        child: GestureDetector(
          onTap: () => widget.onRouteChange(index),
          child: StatefulBuilder(
            builder: (context, setState) {
              bool hasFocus = focusNode.hasFocus;
              return Focus(
                focusNode: focusNode,
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    print("Enter ${focusNode.debugLabel}");
                    setState(() {
                      hasFocus = true;
                    });
                    widget.onRouteChange(index);
                  } else {
                    setState(() {
                      hasFocus = false;
                    });
                    print("Exit ${focusNode.debugLabel}");
                  }
                },
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                      widget.parentNode.requestFocus();
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: AnimatedContainer(
                  curve: Curves.easeOutCirc,
                  duration: Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: hasFocus
                            ? Colors.white
                            : Colors.white.withAlpha(0),
                      ),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isSelected
                          ? null
                          : Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withAlpha(150),
                      fontSize: isSelected
                          ? Theme.of(context).textTheme.titleMedium!.fontSize
                          : null,
                      shadows: isSelected
                          ? [
                              Shadow(
                                color: Colors.white.withAlpha(150),
                                blurRadius: 5,
                              ),
                            ]
                          : null,
                    ),
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOutCirc,
                    child: Text(label),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
