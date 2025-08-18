part of 'mushaf_bloc.dart';

sealed class MushafEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MushafInit extends MushafEvent{
  final int surah;
  final int reciterId;

  MushafInit({required this.surah, required this.reciterId}); 
}
final class MushafPlay extends MushafEvent{}
final class MushafPause extends MushafEvent{}
final class MushafJumpForward extends MushafEvent{}
final class MushafJumpBack extends MushafEvent{}
final class MushafGoToNext extends MushafEvent{}
final class MushafBackToPrevious extends MushafEvent{}