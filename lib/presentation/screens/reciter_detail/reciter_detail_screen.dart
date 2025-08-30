import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/config/routes/app_route.dart';
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/core/utils/route_wrapper.dart';
import 'package:quran_tv/presentation/components/buttons/back_nav_button.dart';
import 'package:quran_tv/presentation/components/layouts/app_scaffold.dart';
import 'package:quran_tv/presentation/controller/quran_list/quran_list_bloc.dart';
import 'package:quran_tv/presentation/screens/quran/quran_play_screen.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/widgets/playlist_item_widget.dart';
import 'package:quran_tv/presentation/screens/reciter_detail/widgets/playlist_list.dart';

class ReciterDetailScreen extends StatefulWidget {
  final int id;
  const ReciterDetailScreen({super.key, required this.id});

  @override
  State<ReciterDetailScreen> createState() => _ReciterDetailScreenState();
}

class _ReciterDetailScreenState extends State<ReciterDetailScreen> {
  final FocusNode _backButtonFocusNode = FocusNode(debugLabel: 'Back button');
  final FocusScopeNode _playlistFocusScopeNode = FocusScopeNode(
    debugLabel: "Playlist",
  );
  final ScrollController _scrollController = ScrollController();
  late QuranListBloc _quranListBloc;

  bool _playlistFocused = false;

  @override
  void initState() {
    _quranListBloc = BlocProvider.of(context);
    _quranListBloc.add(QuranListGetAll());
    super.initState();
  }

  @override
  void dispose() {
    _backButtonFocusNode.dispose();
    _playlistFocusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backButtonFocusNode: _backButtonFocusNode,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
              height: 300,
              child: Row(
                children: [
                  Expanded(child: _buildReciterDetail(context)),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: 1,
                      duration: Duration(milliseconds: 100),
                      child: _buildReciterImage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Playlist : Abdurrahman as-Sudais",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: _playlistFocused ? 1 : 0.5,
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                            stops: [0, 0.1],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: PlaylistList(
                          focusScopeNode: _playlistFocusScopeNode,
                          onFocusChange: (hasFocus) {
                            setState(() {
                              _playlistFocused = hasFocus;
                            });
                            if (hasFocus) {
                              // Scroll to top of SliverFillRemaining
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            } else {
                              // Scroll back to top of the list
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
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
          ),
        ],
      ),
    );
  }

  Widget _buildReciterImage() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
          stops: [0.7, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        Assets.thumbnailSudais,
        height: 300,
        fit: BoxFit.contain,
        alignment: Alignment.bottomRight,
      ),
    );
  }

  Column _buildReciterDetail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Abdurrahman as-Sudais",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                print("Going tp quranscre");
                QuranPlayRoute.push(context, surah: 1, reciterId: 2);
              },
              label: Text("Play"),
              icon: Icon(Icons.play_arrow, size: 16),
              iconAlignment: IconAlignment.end,
            ),
            OutlinedButton.icon(
              onPressed: () {},
              label: Text("Download"),
              icon: Icon(Icons.download_outlined, size: 16),
              iconAlignment: IconAlignment.end,
            ),
            OutlinedButton.icon(
              onPressed: () {},
              label: Text("Add to favorite"),
              icon: Icon(Icons.favorite_outline, size: 16),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

final class ReciterDetailRoute extends RouteWrapper {
  ReciterDetailRoute()
    : super(path: '/reciter/detail', name: routeName, builder: _builder);

  static String get routeName => "reciter-detail";
  static Map<String, dynamic> queryParams({required int id}) => {
    'id': id.toString(),
  };

  static go(BuildContext context, {required int id}) =>
      context.goNamed(routeName, queryParameters: queryParams(id: id));

  static push(BuildContext context, {required int id}) =>
      context.pushNamed(routeName, queryParameters: queryParams(id: id));

  static Widget _builder(BuildContext context, GoRouterState state) {
    final id = int.tryParse(state.uri.queryParameters['id'] ?? '');
    if (id == null) {
      return Scaffold(body: Center(child: Text("Invalid Reciter ID")));
    }
    return ReciterDetailScreen(id: id);
  }
}
