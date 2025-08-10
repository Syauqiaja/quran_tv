import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:quran_tv/domain/repositories/reciter_repository.dart';

part 'reciter_list_event.dart';
part 'reciter_list_state.dart';

class ReciterListBloc extends Bloc<ReciterListEvent, ReciterListState> {
  final ReciterRepository reciterRepository;

  ReciterListBloc(this.reciterRepository) : super(ReciterListInitial()) {
    on<ReciterListGet>(_onReciterListGet);
  }

  Future<void> _onReciterListGet(ReciterListGet event, Emitter<ReciterListState> emit) async {
    final result = await reciterRepository.getAllReciters(query: event.query);
    switch (result) {
      case Success():
        emit(ReciterListSuccess(data: result.value));
      case Error():
        emit(ReciterListError(message: result.error.toString()));
    }
  }
}
