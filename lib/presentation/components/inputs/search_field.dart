import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchField extends StatefulWidget {
  final FocusScopeNode? focusNode;
  final FocusScope? parentNode;
  final TextEditingController? controller;
  final Function(String value) onSubmitted;

  const SearchField({
    super.key,
    this.focusNode,
    required this.onSubmitted,
    this.controller, this.parentNode,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode(
    skipTraversal: true,
    descendantsAreTraversable: false,
  );
  bool hasFocus = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = hasFocus
        ? Theme.of(context).focusColor.withAlpha(200)
        : Colors.transparent;
    final textColor = hasFocus
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).textTheme.bodyMedium?.color;
    return SizedBox(
      width: double.infinity,
      child: FocusScope(
        node: widget.focusNode,
        onFocusChange: (value) {
          setState(() {
            hasFocus = value && !_focusNode.hasFocus;
          });
        },
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            // If user press down button, go to the next focus
            if (
                widget.focusNode?.hasFocus == true) {
                  if(event.logicalKey == LogicalKeyboardKey.arrowDown){
                    widget.focusNode?.parent?.nextFocus();
              return KeyEventResult.handled;
                  }
            }
            // If user press select, focus to search field
            if (event.logicalKey == LogicalKeyboardKey.select &&
                widget.focusNode?.hasFocus == true) {
              widget.focusNode?.unfocus();
                _focusNode.requestFocus();
              return KeyEventResult.handled;
            }
          }

          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          onTap: () {
            if (widget.focusNode?.hasFocus == true) {
              widget.focusNode?.unfocus();
              _focusNode.requestFocus();
            } else {
              if (widget.focusNode != null) {
                widget.focusNode?.requestFocus();
              } else {
                setState(() {
                  hasFocus = false;
                });
                _focusNode.requestFocus();
              }
            }
          },
          child: TextFormField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(64),
              ),
              hintText: "Search",
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColor?.withAlpha(200),
                fontWeight: hasFocus ? FontWeight.bold : null,
              ),
              filled: true,
              fillColor: bgColor,
              suffixIcon: Icon(Icons.search, color: textColor),
              iconColor: textColor,
              suffixIconConstraints: BoxConstraints(minWidth: 48),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: textColor),
            onFieldSubmitted: (value) {
              _focusNode.unfocus();
              widget.onSubmitted(value);
            },
          ),
        ),
      ),
    );
  }
}
