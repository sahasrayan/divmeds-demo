import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'clubs_event.dart';
part 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubsEvent, ClubsState> {
  ClubsBloc() : super(ClubsInitial()) {
    on<ClubsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
