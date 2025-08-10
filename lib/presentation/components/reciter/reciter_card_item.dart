import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/config/routes/app_route.dart';
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/reciter_detail_screen.dart';

class ReciterCardItem extends StatefulWidget {
  final int index;
  final FocusNode focusNode;
  final ReciterModel data;
  const ReciterCardItem({
    super.key,
    required this.index,
    required this.focusNode,
    required this.data,
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
      onKeyEvent: (node, event) {
        if(event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.select && hasFocus){
            ReciterDetailRoute.push(context, id: widget.data.id);
            return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: AnimatedScale(
        scale: hasFocus ? 1.02 : 0.99,
        curve: Curves.easeOutCirc,
        duration: Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: () {
            ReciterDetailRoute.push(context, id: widget.data.id);
          },
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
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeOutCirc,
                      opacity: hasFocus ? 1 : 0.7,
                      child: Image.asset(
                        widget.data.imageUrl ?? "-",
                        fit: BoxFit.cover,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 170,
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
                                    widget.data.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: hasFocus
                                              ? Colors.white
                                              : Colors.white70,
                                        ),
                                  ),
                                  Text(
                                    widget.data.domicile ?? "-",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              widget.data.madzhab ?? "-",
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
