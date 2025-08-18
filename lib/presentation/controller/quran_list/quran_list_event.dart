part of 'quran_list_bloc.dart';

sealed class QuranListEvent extends Equatable {
  const QuranListEvent();

  @override
  List<Object> get props => [];
}

final class QuranListGetAll extends QuranListEvent{}
final class QuranListRefreshed extends QuranListEvent{}