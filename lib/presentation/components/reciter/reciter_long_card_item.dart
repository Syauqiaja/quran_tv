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
  final Icon? icon;
  final int? progress;
  final Function(ReciterModel data)? onDelete;
  const ReciterLongCardItem({
    super.key,
    required this.index,
    required this.focusNode,
    required this.data,
    this.icon,
    this.onDelete,
    this.progress,
  });

  @override
  State<ReciterLongCardItem> createState() => _ReciterLongCardItemState();
}

class _ReciterLongCardItemState extends State<ReciterLongCardItem> {
  final FocusNode _actionFocusNode = FocusNode(
    debugLabel: "Action focus node",
    skipTraversal: true,
    descendantsAreTraversable: true,
  );

  bool hasFocus = false;
  bool actionFocused = false;

  @override
  void dispose() {
    _actionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overlayColor = Color.fromARGB(131, 19, 20, 25);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      child: AnimatedScale(
        scale: hasFocus ? 1.02 : 0.99,
        curve: Curves.easeOutCirc,
        duration: Duration(milliseconds: 200),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Focus(
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

                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.arrowRight) {
                    setState(() {
                      actionFocused = true;
                    });
                    _actionFocusNode.requestFocus();
                    return KeyEventResult.handled;
                  }
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                    widget.focusNode.requestFocus();
                    return KeyEventResult.handled;
                  }

                  return KeyEventResult.ignored;
                },
                child: GestureDetector(
                  onTap: () {
                    ReciterDetailRoute.push(context, id: widget.data.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: overlayColor,
                      border: Border.all(
                        color: hasFocus && !actionFocused
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
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
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                spacing: 16,
                                children: [
                                  if (widget.progress != null)
                                    SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: CircularProgressIndicator(
                                              value:
                                                  widget.progress!.toDouble() /
                                                  100,
                                                  color: Colors.white,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "${widget.progress}%",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (widget.icon != null) widget.icon!,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              width: actionFocused ? 128 : 0,
              height: 40,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOutCirc,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: overlayColor,
                border: Border.all(
                  color: actionFocused ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: FocusableActionDetector(
                autofocus: false,
                descendantsAreTraversable: false,
                focusNode: _actionFocusNode,
                onFocusChange: (value) {
                  setState(() {
                    actionFocused = value;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    widget.onDelete?.call(widget.data);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        child: Text("Remove "),
                      ),
                      Icon(Icons.highlight_remove_sharp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange(bool value) {
    setState(() {
      hasFocus = value;
      if (value) {
        actionFocused = false;
      }
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
