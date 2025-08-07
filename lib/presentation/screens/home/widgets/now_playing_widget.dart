import 'package:flutter/material.dart';
import 'package:quran_tv/core/constants/assets.dart';

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({super.key});

  @override
  State<NowPlayingWidget> createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          hasFocus = value;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedScale(
            scale: hasFocus ? 1.0 : 0.8,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutCirc,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Now Playing',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeOutCirc,
                  duration: Duration(milliseconds: 100),
                  width: hasFocus ? 8 : 0,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.arrow_right, size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeOutCirc,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: hasFocus
                          ? Colors.white
                          : Colors.white.withAlpha(0),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Theme.of(context).cardColor,
                      backgroundImage: AssetImage(Assets.thumbnailSudais),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Al-Baqarah'),
                        Text(
                          "Syeikh Abdurrahman as-Sudais",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
