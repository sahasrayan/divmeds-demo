import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_view_from_outside_event.dart';
part 'profile_view_from_outside_state.dart';

class ProfileViewFromOutsideBloc extends Bloc<ProfileViewFromOutsideEvent, ProfileViewFromOutsideState> {
  ProfileViewFromOutsideBloc() : super(ProfileViewFromOutsideInitial()) {
    on<ProfileViewFromOutsideEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
