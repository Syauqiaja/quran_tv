import 'package:flutter/material.dart';
import 'package:quran_tv/core/utils/duration_extension.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/presentation/screens/quran/quran_play_screen.dart';

class PlaylistItemWidget extends StatefulWidget {
  final FocusScopeNode? focusNode;
  final QuranModel quranModel;
  const PlaylistItemWidget({super.key, this.focusNode, required this.quranModel});

  @override
  State<PlaylistItemWidget> createState() => _PlaylistItemWidgetState();
}

class _PlaylistItemWidgetState extends State<PlaylistItemWidget> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: widget.focusNode,
      onFocusChange: (value) {
        setState(() {
          hasFocus = value;
        });

        if (value) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 200),
            alignment: 0.2,
            curve: Curves.easeOutSine,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: hasFocus ? Colors.white : Colors.transparent)
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.quranModel.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: hasFocus ? FontWeight.bold : FontWeight.normal
                  ),),
                  Text(Duration(milliseconds: widget.quranModel.duration ?? 0).toPlaybackFormat(), style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: hasFocus ? Colors.white : Colors.white60,
                  ),),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: hasFocus ? 1 : 0,
              duration: Duration(milliseconds: 100),
              child: OutlinedButton(onPressed: (){
                QuranPlayRoute.push(context, surah: widget.quranModel.number, reciterId: 1);
              }, child: Text("Play")),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline), style: IconButton.styleFrom(
              overlayColor: Colors.white
            ),),
            IconButton(onPressed: () {}, icon: Icon(Icons.download_outlined)),
          ],
        ),
      ),
    );
  }
}
