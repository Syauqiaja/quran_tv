import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:quran_tv/domain/repositories/quran_repository.dart';

part 'quran_list_event.dart';
part 'quran_list_state.dart';

class QuranListBloc extends Bloc<QuranListEvent, QuranListState> {
  QuranListBloc(this.quranRepository) : super(QuranListInitial()) {
    on<QuranListGetAll>(_onQuranListGetAll);
    on<QuranListRefreshed>(_onQuranListRefreshed);
  }

  final QuranRepository quranRepository;

  FutureOr<void> _onQuranListGetAll(QuranListGetAll event, Emitter<QuranListState> emit) async {
    emit(QuranListLoading());
    
    final result = await quranRepository.getQuranList();
    switch (result) {
      case Success():
        emit(QuranListSuccess(data: result.value));
        break;
      case Error():
        emit(QuranListError(message: result.error.toString()));
        break;
    }
  }

  FutureOr<void> _onQuranListRefreshed(QuranListRefreshed event, Emitter<QuranListState> emit) async {
    emit(QuranListLoading());
    
    final result = await quranRepository.getQuranList();
    switch (result) {
      case Success():
        emit(QuranListSuccess(data: result.value));
        break;
      case Error():
        emit(QuranListError(message: result.error.toString()));
        break;
    }
  }
}
