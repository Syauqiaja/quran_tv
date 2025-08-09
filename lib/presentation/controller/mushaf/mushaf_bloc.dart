import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mushaf_event.dart';
part 'mushaf_state.dart';

class MushafBloc extends Bloc<MushafEvent, MushafState> {
  MushafBloc() : super(MushafInitial()) {
    on<MushafEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
