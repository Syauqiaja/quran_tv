import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/config/routes/app_route.dart';
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/reciter_detail_screen.dart';

class ReciterLongCardItem extends StatefulWidget {
  final int index;
  final FocusNode focusNode;
  final ReciterModel data;
  const ReciterLongCardItem({
    super.key,
    required this.index,
    required this.focusNode,
    required this.data,
  });

  @override
  State<ReciterLongCardItem> createState() => _ReciterLongCardItemState();
}

class _ReciterLongCardItemState extends State<ReciterLongCardItem> {
  bool hasFocus = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayColor = Color.fromARGB(131, 19, 20, 25);
    return Focus(
      key: ValueKey(widget.index),
      focusNode: widget.focusNode,
      onFocusChange: _onFocusChange,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.select &&
            hasFocus) {
          ReciterDetailRoute.push(context, id: widget.data.id);
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: AnimatedScale(
          scale: hasFocus ? 1.02 : 0.99,
          curve: Curves.easeOutCirc,
          duration: Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () {
              ReciterDetailRoute.push(context, id: widget.data.id);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: overlayColor,
                border: Border.all(color: hasFocus ? Colors.white : Colors.transparent, width: 2)
              ),
              child: Stack(
                children: [
                  Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeOutCirc,
                        opacity: hasFocus ? 1 : 0.7,
                        child: Image.asset(
                          widget.data.imageUrl ?? "-",
                          fit: BoxFit.cover,
                          width: 100,
                          height: 80,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.name,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: hasFocus
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                            ),
                            Text(
                              widget.data.domicile ?? "-",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFocusChange(bool value) {
    setState(() {
      hasFocus = value;
    });

    if (value) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 200),
        alignment: 0.5,
        curve: Curves.easeOutSine,
      );
    }
  }
}
