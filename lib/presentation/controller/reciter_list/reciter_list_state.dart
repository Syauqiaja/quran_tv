part of 'reciter_list_bloc.dart';

sealed class ReciterListState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ReciterListInitial extends ReciterListState {}

final class ReciterListLoading extends ReciterListState{}

final class ReciterListSuccess extends ReciterListState{
  final List<ReciterModel> data;
  final String? message;

  ReciterListSuccess({required this.data, this.message});
}
final class ReciterListError extends ReciterListState{
  final String? message;

  ReciterListError({this.message});
}