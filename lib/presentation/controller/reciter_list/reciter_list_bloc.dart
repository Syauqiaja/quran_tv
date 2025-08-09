import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reciter_list_event.dart';
part 'reciter_list_state.dart';

class ReciterListBloc extends Bloc<ReciterListEvent, ReciterListState> {
  ReciterListBloc() : super(ReciterListInitial()) {
    on<ReciterListEvent>((event, emit) {
    });
  }
}
