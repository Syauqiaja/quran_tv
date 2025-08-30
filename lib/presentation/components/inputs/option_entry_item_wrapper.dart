import 'package:flutter/material.dart';

class OptionEntryItemWrapper extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;

  const OptionEntryItemWrapper({super.key, required this.builder});

  @override
  State<OptionEntryItemWrapper> createState() => _OptionEntryItemWrapper();
}

class _OptionEntryItemWrapper extends State<OptionEntryItemWrapper> {
  bool focused = false;
  FocusNode? node;

  void focusListener() {
    if (mounted && node != null) {
      setState(() {
        focused = node!.hasFocus;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    node?.removeListener(focusListener);
    node = Focus.of(context);
    node?.addListener(focusListener);
  }

  @override
  void dispose() {
    node?.removeListener(focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, focused);
  }
}
