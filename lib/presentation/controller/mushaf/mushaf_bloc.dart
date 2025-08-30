import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:quran_tv/core/di/injections.dart';
import 'package:quran_tv/core/services/google_storage_service.dart';
import 'package:quran_tv/data/models/quran_line_model.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:quran_tv/domain/repositories/quran_repository.dart';
import 'package:quran_tv/main.dart';

part 'mushaf_event.dart';
part 'mushaf_state.dart';

class MushafBloc extends Bloc<MushafEvent, MushafState> {
  final QuranRepository quranRepository;

  MushafBloc(this.quranRepository) : super(const MushafState()) {
    on<MushafInit>(_onMushafInit);
    on<MushafPlay>(_onMushafPlay);
    on<MushafPause>(_onMushafPause);
    on<MushafJumpForward>(_onMushafJumpForward);
    on<MushafJumpBack>(_onMushafJumpBack);
    on<MushafGoToNext>(_onMushafGoToNext);
    on<MushafBackToPrevious>(_onMushafBackToPrevious);
  }

  Future<void> _onMushafInit(
    MushafInit event,
    Emitter<MushafState> emit,
  ) async {
    final quranModelResult = await quranRepository.getQuranModel(event.surah);
    switch (quranModelResult) {
      case Success():
        final quranModel = quranModelResult.value;
        final result = await quranRepository.getQuranLineModelOf(
          quranModel.number,
        );
        switch (result) {
          case Success():
            emit(
              state.copyWith(
                quranLineModel: result.value,
                quranModel: quranModel,
                totalDuration: null,
                playbackProgress: null,
                currentLinePlaying: result.value[0],
                nextLinePlaying: result.value[1],
                stateType: MushafStateType.initial,
              ),
            );
            break;
          case Error():
            emit(state.copyWith(errorMessage: result.error.toString()));
            break;
        }
        break;
      case Error():
        emit(state.copyWith(errorMessage: quranModelResult.error.toString()));
        break;
    }
  }

  Future _onMushafPlay(MushafPlay event, Emitter<MushafState> emit) async {
    if (state.stateType == MushafStateType.initial) {
      await getIt<GoogleStorageService>().getAudioTest().then((result){
        if(result is Success){
           _playAudio(result.value!, emit);
        }else{
          emit(state.copyWith(errorMessage: 'Failed to get audio : ${result.errorMessage}'));
        }
      });

      // await _copyAssetToFile('assets/quran/al-mulk/067.mp3')
      //     .then((uint8list) {
      //       _playAudio(uint8list, emit);
      //     });
    } else {
      await flutterSoundPlayer?.resumePlayer();
    }

    emit(state.copyWith(isPlaying: true, stateType: MushafStateType.playing));
  }

  void _onMushafPause(MushafPause event, Emitter<MushafState> emit) {
    flutterSoundPlayer?.pausePlayer();
    emit(state.copyWith(isPlaying: false));
  }

  Future _playAudio(Uint8List uint8list ,Emitter<MushafState> emit) async {
    flutterSoundPlayer?.startPlayer(
      codec: Codec.mp3,
      fromDataBuffer: uint8list,
    );
    emit.forEach(
      flutterSoundPlayer!.onProgress!,
      onData: (data) {
        emit(
          state.copyWith(
            totalDuration: data.duration,
            playbackProgress: data.position,
          ),
        );
        if (state.nextLinePlaying?.startTimeMs != null) {
          print(data.position.inMilliseconds);
          if (data.position.inMilliseconds >
              state.nextLinePlaying!.startTimeMs) {
            emit(
              state.copyWith(
                currentLinePlaying: state.nextLinePlaying,
                nextLinePlaying:
                    state.quranLineModel[state.quranLineModel.indexOf(
                          state.nextLinePlaying!,
                        ) +
                        1],
              ),
            );
          }
        }
        return state;
      },
    );

    flutterSoundPlayer?.setSubscriptionDuration(
      Duration(milliseconds: 100),
    );
  }

  Future _onMushafJumpForward(
    MushafJumpForward event,
    Emitter<MushafState> emit,
  ) async {
    if (state.currentLinePlaying != null) {
      QuranLineModel destinationLine =
          state.quranLineModel[state.quranLineModel.indexOf(
                state.currentLinePlaying!,
              ) +
              1];
      QuranLineModel nextLine = state
          .quranLineModel[state.quranLineModel.indexOf(destinationLine) + 1];

      flutterSoundPlayer?.seekToPlayer(
        Duration(milliseconds: destinationLine.startTimeMs),
      );

      emit(
        state.copyWith(
          currentLinePlaying: destinationLine,
          nextLinePlaying: nextLine,
          playbackProgress: Duration(milliseconds: destinationLine.startTimeMs)
        ),
      );
    }
  }

  Future _onMushafJumpBack(
    MushafJumpBack event,
    Emitter<MushafState> emit,
  ) async {
    if (state.currentLinePlaying != null) {
      int currentIndex = state.quranLineModel.indexOf(
        state.currentLinePlaying!,
      );

      // Ensure we don't go out of range
      if (currentIndex > 0) {
        QuranLineModel destinationLine = state.quranLineModel[currentIndex - 1];

        QuranLineModel? nextLine;
        if (currentIndex < state.quranLineModel.length) {
          nextLine = state.quranLineModel[currentIndex];
        }

        await flutterSoundPlayer?.seekToPlayer(
          Duration(milliseconds: destinationLine.startTimeMs),
        );

        emit(
          state.copyWith(
            currentLinePlaying: destinationLine,
            nextLinePlaying: nextLine,
          playbackProgress: Duration(milliseconds: destinationLine.startTimeMs)
          ),
        );
      }
    }
  }

  void _onMushafGoToNext(MushafGoToNext event, Emitter<MushafState> emit) {
    // Handle next surah
  }

  void _onMushafBackToPrevious(
    MushafBackToPrevious event,
    Emitter<MushafState> emit,
  ) {
    // Handle previous surah
  }
  Future<Uint8List> _copyAssetToFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
