import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tv/presentation/components/inputs/search_field.dart';
import 'package:quran_tv/presentation/components/reciter/reciter_card_item.dart';
import 'package:quran_tv/presentation/controller/reciter_list/reciter_list_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<FocusNode> _reciterFocusNodes = List.generate(
    6,
    (e) => FocusNode(debugLabel: 'Reciter Item $e'),
  );
  final FocusScopeNode _searchFocus = FocusScopeNode(
    debugLabel: 'Search field',
  );

  @override
  void initState() {
    context.read<ReciterListBloc>().add(ReciterListGet(isFresh: true));
    super.initState();
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    for (var element in _reciterFocusNodes) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = 3;
    return Stack(
      children: [
        _buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: SearchField(
                    focusNode: _searchFocus,
                    onSubmitted: (text) {
                      _reciterFocusNodes.first.requestFocus();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: FocusScope(
                    onKeyEvent: (node, event) {
                      if (event is KeyDownEvent) {
                        bool itemHasFocus = false;
                        // Checking are there any top most items that has focus
                        for (
                          var i = 0;
                          i < min(crossAxisCount, _reciterFocusNodes.length);
                          i++
                        ) {
                          if (_reciterFocusNodes[i].hasFocus) {
                            itemHasFocus = true;
                            break;
                          }
                        }
                        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                          if (itemHasFocus) {
                            _searchFocus.requestFocus();
                            return KeyEventResult.handled;
                          } else if (_searchFocus.hasFocus) {
                            FocusManager.instance.rootScope.focusInDirection(
                              TraversalDirection.up,
                            );
                            return KeyEventResult.handled;
                          }
                        }
                      }

                      return KeyEventResult.ignored;
                    },
                    child: BlocBuilder<ReciterListBloc, ReciterListState>(
                      builder: (context, state) {
                        if (state is ReciterListSuccess) {
                          return GridView.builder(
                            itemCount: state.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: 2.3,
                                  mainAxisSpacing: 8,
                                ),
                            itemBuilder: (context, index) {
                              return Center(
                                child: ReciterCardItem(
                                  data: state.data[index],
                                  index: index,
                                  focusNode: _reciterFocusNodes[index],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: SizedBox(
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF043657).withAlpha(70),
                Color(0xFF0F1726).withAlpha(0),
              ],
              radius: 1.2,
              center: Alignment.topLeft,
            ),
          ),
        ),

        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF239BAF).withAlpha(30),
                Color(0xFF0F1726).withAlpha(0),
              ],
              radius: 1,
              focalRadius: 1,
              center: Alignment.bottomRight,
            ),
          ),
        ),
      ],
    );
  }
}
