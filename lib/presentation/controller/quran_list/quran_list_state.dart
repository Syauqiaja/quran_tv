part of 'quran_list_bloc.dart';

sealed class QuranListState extends Equatable {
  const QuranListState();
  
  @override
  List<Object> get props => [];
}

final class QuranListInitial extends QuranListState{}
final class QuranListSuccess extends QuranListState{
  final List<QuranModel> data;

  const QuranListSuccess({required this.data});
  @override
  List<Object> get props => [data];
}
final class QuranListError extends QuranListState{
  final String? message;

  const QuranListError({required this.message});
  @override
  List<Object> get props => [message ?? ''];
}
final class QuranListLoading extends QuranListState{}