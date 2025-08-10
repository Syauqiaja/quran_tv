part of 'reciter_list_bloc.dart';

sealed class ReciterListEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ReciterListGet extends ReciterListEvent{
  final bool isFresh;
  final String? query;

  ReciterListGet({this.isFresh = false, this.query});
}