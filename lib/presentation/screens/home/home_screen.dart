import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/presentation/components/reciter/reciter_card_item.dart';
import 'package:quran_tv/presentation/screens/home/widgets/now_playing_widget.dart';

class HomeScreen extends StatefulWidget {
  final FocusScopeNode focusScopeNode;
  final FocusScopeNode parentScopeNode;
  const HomeScreen({
    super.key,
    required this.focusScopeNode,
    required this.parentScopeNode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final int itemCount = 6;
  late List<FocusNode> _reciterFocusNodes;
  @override
  void initState() {
    _reciterFocusNodes = List.generate(itemCount, (e) => FocusNode(debugLabel: 'Reciter $e'));
    super.initState();
  }
  @override
  void dispose() {
    for (var node in _reciterFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(top: 64),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.bgMosque),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FocusScope(
          parentNode: widget.parentScopeNode,
          node: widget.focusScopeNode,
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.arrowUp) {
              if (widget.focusScopeNode.focusedChild !=
                  widget.focusScopeNode.traversalDescendants.first) {
                widget.focusScopeNode.previousFocus();
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          onFocusChange: (value) {
            if (value) {
              print('Enter ${widget.focusScopeNode.debugLabel}');
              widget.focusScopeNode.traversalDescendants.firstOrNull
                  ?.requestFocus();
            }
          },
          child: Stack(
            children: [
              Align(
                // Draw shadow
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        spreadRadius: 64,
                        blurRadius: 64,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NowPlayingWidget(),
                    const SizedBox(height: 48),
                    Text(
                      'Reciters',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 130,
                      child: FocusTraversalGroup(
                        policy: OrderedTraversalPolicy(),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return ReciterCardItem( index: index, focusNode: _reciterFocusNodes[index],);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
