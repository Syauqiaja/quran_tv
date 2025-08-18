import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tv/presentation/controller/quran_list/quran_list_bloc.dart';
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
  List<FocusScopeNode> _items = [];
  late QuranListBloc _quranListBloc;

  @override
  void initState() {
    _quranListBloc = BlocProvider.of<QuranListBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    for (var item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  void _syncFocusNodes(int length) {
    // Dispose extra nodes
    if (_items.length > length) {
      _items.sublist(length).forEach((n) => n.dispose());
      _items = _items.sublist(0, length);
    }
    // Add missing nodes
    while (_items.length < length) {
      _items.add(FocusScopeNode(debugLabel: "Playlist Item ${_items.length}"));
    }
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
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: CustomScrollView(
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 24)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: BlocBuilder<QuranListBloc, QuranListState>(
                builder: (context, state) {
                  if (state is QuranListSuccess) {
                    _syncFocusNodes(state.data.length);

                    return SliverList.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return PlaylistItemWidget(focusNode: _items[index], quranModel: state.data[index],);
                      },
                    );
                  }

                  return const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
