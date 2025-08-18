import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import 'package:quran_tv/core/constants/assets.dart';
import 'package:quran_tv/core/di/injections.dart';
import 'package:quran_tv/core/utils/duration_extension.dart';
import 'package:quran_tv/core/utils/hexagon_clipper.dart';
import 'package:quran_tv/core/utils/route_wrapper.dart';
import 'package:quran_tv/core/utils/utility_svg_loader.dart';
import 'package:quran_tv/main.dart';
import 'package:quran_tv/presentation/components/buttons/back_nav_button.dart';
import 'package:quran_tv/presentation/controller/mushaf/mushaf_bloc.dart';
import 'package:quran_tv/presentation/screens/error/error_page.dart';
import 'package:quran_tv/presentation/screens/quran/widgets/player_linear_progress.dart';

class QuranPlayScreen extends StatefulWidget {
  final int surah;
  final int reciterId;
  const QuranPlayScreen({
    super.key,
    required this.surah,
    required this.reciterId,
  });

  @override
  State<QuranPlayScreen> createState() => _QuranPlayScreenState();
}

class _QuranPlayScreenState extends State<QuranPlayScreen> {
  final FocusNode _backButtonFocusNode = FocusNode(debugLabel: "Back button");
  late FlutterSoundPlayer _flutterSoundPlayer;
  late Future<FlutterSoundPlayer> _initSoundPlayer;
  late MushafBloc _mushafBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _mushafBloc = BlocProvider.of(context)
      ..add(MushafInit(surah: widget.surah, reciterId: widget.reciterId));
    _initSoundPlayer = initSoundPayer();
    super.initState();
  }

  @override
  void dispose() {
    _backButtonFocusNode.dispose();
    flutterSoundPlayer?.stopPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MushafBloc, MushafState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              debugPrint(state.errorMessage, wrapWidth: 100);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
        ),
        BlocListener<MushafBloc, MushafState>(
          listenWhen: (previous, current) =>
              previous.currentLinePlaying != current.currentLinePlaying,
          listener: (context, state) {
            if (state.currentLinePlaying != null) {
              final pos = state.quranLineModel.indexOf(
                state.currentLinePlaying!,
              );
              _scrollController.animateTo(
                pos * 44,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeOutCirc,
              );
            }
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F1726), Color(0xFF0F1726).withAlpha(0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.6, 1],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                Assets.bgMosque,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 64),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    BackNavButton(focusNode: _backButtonFocusNode),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: ClipPath(
                        clipper: HexagonClipper(),
                        child: Container(
                          color: Colors.black38,
                          width: 600,
                          height: 108,
                          padding: EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 16,
                            bottom: 8,
                          ),
                          child: BlocBuilder<MushafBloc, MushafState>(
                            builder: (context, state) {
                              if (state.quranLineModel.isEmpty) {
                                return Center(child: Text("Loading..."));
                              }

                              return Center(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: state.quranLineModel.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsetsGeometry.only(
                                        bottom: 12,
                                      ),
                                      child: FutureBuilder<String>(
                                        future: QuranSvgLoader.loadConvertedSvg(
                                          Assets.quranSvg(
                                            state.quranLineModel[index].line
                                                .toString(),
                                          ),
                                          isDarkMode: true,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  snapshot.error!.toString(),
                                                ),
                                              ),
                                            );
                                          }
                                          if (snapshot.hasData &&
                                              snapshot.data!.isNotEmpty) {
                                            return SvgPicture.string(
                                              snapshot.data!,
                                              height: 32,
                                              fit: BoxFit.contain,
                                            );
                                          }
                                          return SizedBox(height: 40);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Al-Baqarah"),
                                    Text(
                                      'May be filled with rewaya',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BlocSelector<
                                      MushafBloc,
                                      MushafState,
                                      Duration?
                                    >(
                                      selector: (state) =>
                                          state.playbackProgress,
                                      builder: (context, state) {
                                        if (state != null) {
                                          return Text(state.toPlaybackFormat());
                                        }
                                        return Text("--:--:--");
                                      },
                                    ),
                                    Text(
                                      'Ayah 3 of 103',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_double_arrow_left_outlined,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _mushafBloc.add(MushafJumpBack());
                                  },
                                  icon: Icon(Icons.chevron_left_outlined),
                                ),
                                BlocSelector<MushafBloc, MushafState, bool>(
                                  selector: (state) => state.isPlaying,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                      onPressed: () {
                                        if (isPlaying) {
                                          _mushafBloc.add(MushafPause());
                                        } else {
                                          _mushafBloc.add(MushafPlay());
                                        }
                                      },
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause_outlined
                                            : Icons.play_arrow_outlined,
                                      ),
                                      iconSize: 32,
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    _mushafBloc.add(MushafJumpForward());
                                  },
                                  icon: Icon(Icons.chevron_right_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      BlocSelector<MushafBloc, MushafState, double>(
                        selector: (state) {
                          if (state.totalDuration != null &&
                              state.playbackProgress != null) {
                            return state.playbackProgress!.inMilliseconds /
                                state.totalDuration!.inMilliseconds;
                          }
                          return 0;
                        },
                        builder: (context, state) {
                          return PlayerLinearProgress(value: state);
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Reciter : Abdurrahman as-Sudais",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FlutterSoundPlayer> initSoundPayer() async {
    _flutterSoundPlayer = await getIt.getAsync<FlutterSoundPlayer>();
    return _flutterSoundPlayer;
  }
}

final class QuranPlayRoute extends RouteWrapper {
  QuranPlayRoute()
    : super(path: '/quran/play', name: routeName, builder: _builder);

  static String get routeName => 'quran-play';

  static Widget _builder(BuildContext context, GoRouterState state) {
    final query = state.uri.queryParameters;
    final surah = int.tryParse(query['surah'] ?? '');
    final reciterId = int.tryParse(query['reciterId'] ?? '');
    if (surah == null || reciterId == null) {
      return ErrorPage(
        message: "Invalid parameter. surah and reciterId is required",
      );
    }
    return QuranPlayScreen(surah: surah, reciterId: reciterId);
  }

  static void go(
    BuildContext context, {
    required int surah,
    required int reciterId,
  }) => context.goNamed(
    routeName,
    queryParameters: {
      'surah': surah.toString(),
      'reciterId': reciterId.toString(),
    },
  );
  static void push(
    BuildContext context, {
    required int surah,
    required int reciterId,
  }) => context.pushNamed(
    routeName,
    queryParameters: {
      'surah': surah.toString(),
      'reciterId': reciterId.toString(),
    },
  );
}
