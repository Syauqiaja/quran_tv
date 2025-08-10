import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/core/utils/route_wrapper.dart';
import 'package:quran_tv/presentation/components/reciter/reciter_card_item.dart';
import 'package:quran_tv/presentation/controller/reciter_list/reciter_list_bloc.dart';
import 'package:quran_tv/presentation/screens/home/widgets/now_playing_widget.dart';
import 'package:quran_tv/presentation/screens/layouts/app_layout.dart';

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
    _reciterFocusNodes = List.generate(
      itemCount,
      (e) => FocusNode(debugLabel: 'Reciter $e'),
    );
    context.read<ReciterListBloc>().add(ReciterListGet(isFresh: true));
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NowPlayingWidget(),
                        const SizedBox(height: 48),
                        Text(
                          'Reciters',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 150,
                    child: FocusTraversalGroup(
                      policy: OrderedTraversalPolicy(),
                      child: BlocBuilder<ReciterListBloc, ReciterListState>(
                        builder: (context, state) {
                          if (state is ReciterListSuccess) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.data.length,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: ReciterCardItem(
                                    index: index,
                                    focusNode: _reciterFocusNodes[index],
                                    data: state.data[index],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: const SizedBox(
                                height: 64,
                                width: 64,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class HomeRoute extends RouteWrapper{
  HomeRoute() : super(path: '/', name: routeName, builder: _builder);

  static Widget _builder(BuildContext context, GoRouterState state) {
    return AppLayout();
  }

  static String get routeName => 'home';
}