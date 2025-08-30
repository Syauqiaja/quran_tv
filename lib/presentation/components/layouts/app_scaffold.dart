import 'package:flutter/material.dart';
import 'package:quran_tv/presentation/components/buttons/back_nav_button.dart';

class AppScaffold extends StatelessWidget {
  final FocusNode backButtonFocusNode;
  final Widget body;
  const AppScaffold({super.key, required this.backButtonFocusNode, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F1726), Color(0xFF0F1726).withAlpha(0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 64),
          child: Row(
            children: [
              const SizedBox(width: 16),
              BackNavButton(focusNode: backButtonFocusNode),
            ],
          ),
        ),
        body: body,
      ),
    );
  }
}