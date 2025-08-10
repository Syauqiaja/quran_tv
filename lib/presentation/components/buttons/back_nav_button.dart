import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BackNavButton extends StatefulWidget {
  final FocusNode focusNode;
  const BackNavButton({super.key, required this.focusNode});

  @override
  State<BackNavButton> createState() => _BackNavButtonState();
}

class _BackNavButtonState extends State<BackNavButton> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: hasFocus ? 1.05 : 1,
      duration: Duration(milliseconds: 100),
          curve: Curves.easeOutCirc,
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (value) {
          setState(() {
            hasFocus =value;
          });
        },
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.select &&
              widget.focusNode.hasFocus) {
                print("Back button pressed");
            context.pop();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeOutCirc,
            height: 32,
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2, color: hasFocus ? Colors.white : Colors.white.withAlpha(0)))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_left),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: hasFocus ? 8 : 2,
                ),
                Text("Back"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
