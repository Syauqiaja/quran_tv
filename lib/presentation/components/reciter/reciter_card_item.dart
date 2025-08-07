import 'package:flutter/material.dart';
import 'package:quran_tv/core/constants/assets.dart';

class ReciterCardItem extends StatefulWidget {
  final int index;
  final FocusNode focusNode;
  const ReciterCardItem({
    super.key,
    required this.index,
    required this.focusNode,
  });

  @override
  State<ReciterCardItem> createState() => _ReciterCardItemState();
}

class _ReciterCardItemState extends State<ReciterCardItem> {
  bool hasFocus = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayColor = Color(0xFF131419);
    return Focus(
              key: ValueKey(widget.index),
      focusNode: widget.focusNode,
      onFocusChange: _onFocusChange,
      child: Container(
        width: 300,
        height: 128,
        margin: EdgeInsets.only(right: 16),
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    Assets.thumbnailSudais,
                    fit: BoxFit.fitHeight,
                    width: 170,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    overlayColor.withAlpha(0),
                    overlayColor.withAlpha(200),
                    overlayColor,
                  ],
                  stops: [0, 0.5, 1],
                ),
                border: BoxBorder.all(
                  color: hasFocus
                      ? Theme.of(context).focusColor
                      : Colors.transparent,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "${widget.index} Syeikh Abdurrahman as-Sudais",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                "Saudi Arabia",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Salafiyah",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange(bool value) {
    setState(() {
      hasFocus = value;
    });

    if (value) {
      // Scroll into view with animation when focused
      Future.microtask(() {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 200),
          alignment: 0.9,
          curve: Curves.easeOutSine,
        );
      });
    }
  }
}
