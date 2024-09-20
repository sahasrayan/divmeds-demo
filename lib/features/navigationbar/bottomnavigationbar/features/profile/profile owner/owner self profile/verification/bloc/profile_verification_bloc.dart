import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_verification_event.dart';
part 'profile_verification_state.dart';

class ProfileVerificationBloc extends Bloc<ProfileVerificationEvent, ProfileVerificationState> {
  ProfileVerificationBloc() : super(ProfileVerificationInitial()) {
    on<ProfileVerificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
