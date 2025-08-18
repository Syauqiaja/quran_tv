part of 'mushaf_bloc.dart';

@immutable
final class MushafState {
  final List<QuranLineModel> quranLineModel;
  final QuranModel? quranModel;
  final QuranLineModel? currentLinePlaying;
  final QuranLineModel? nextLinePlaying;
  final String? errorMessage;
  final bool isPlaying;
  final Duration? totalDuration;
  final Duration? playbackProgress;
  final MushafStateType stateType;

  const MushafState({
    this.quranLineModel = const [],
    this.quranModel,
    this.currentLinePlaying,
    this.nextLinePlaying,
    this.errorMessage,
    this.isPlaying = false,
    this.totalDuration,
    this.playbackProgress,
    this.stateType = MushafStateType.initial,
  });

  MushafState copyWith({
    List<QuranLineModel>? quranLineModel,
    QuranModel? quranModel,
    QuranLineModel? currentLinePlaying,
    QuranLineModel? nextLinePlaying,
    String? errorMessage,
    bool? isPlaying,
    Duration? playbackProgress,
    Duration? totalDuration,
    MushafStateType? stateType,
  }) {
    return MushafState(
      quranLineModel: quranLineModel ?? this.quranLineModel,
      quranModel: quranModel ?? this.quranModel,
      currentLinePlaying: currentLinePlaying ?? this.currentLinePlaying,
      nextLinePlaying: nextLinePlaying ?? this.nextLinePlaying,
      errorMessage: errorMessage,
      isPlaying: isPlaying ?? this.isPlaying,
      totalDuration: totalDuration ?? this.totalDuration,
      playbackProgress:  playbackProgress ?? this.playbackProgress,
      stateType: stateType ?? this.stateType,
    );
  }
}

enum MushafStateType{
  initial,
  playing,
  paused,
}