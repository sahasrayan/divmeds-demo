import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'owner_self_profile_event.dart';
part 'owner_self_profile_state.dart';

class OwnerSelfProfileBloc extends Bloc<OwnerSelfProfileEvent, OwnerSelfProfileState> {
  OwnerSelfProfileBloc() : super(OwnerSelfProfileInitial()) {
    on<OwnerSelfProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
