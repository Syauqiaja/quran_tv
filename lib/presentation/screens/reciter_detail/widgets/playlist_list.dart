import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/widgets/playlist_item_widget.dart';

class PlaylistList extends StatefulWidget {
  final FocusScopeNode focusScopeNode;
  final Function(bool hasFocus)? onFocusChange;
  const PlaylistList({
    super.key,
    required this.focusScopeNode,
    this.onFocusChange,
  });

  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  bool _playlistFocused = false;
  final List<FocusScopeNode> _items = List.generate(
    10,
    (e) => FocusScopeNode(debugLabel: "Playlist Item $e"),
  );

  @override
  void dispose() {
    for (var item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: widget.focusScopeNode,
      onFocusChange: (value) {
        setState(() {
          _playlistFocused = value;
        });
        widget.onFocusChange?.call(value);
      },
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && _playlistFocused) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            widget.focusScopeNode.nextFocus();
            return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            if (widget.focusScopeNode.focusedChild == _items.first) {
              widget.focusScopeNode.parent?.previousFocus();
            } else {
              widget.focusScopeNode.previousFocus();
            }
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return PlaylistItemWidget(focusNode: _items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
