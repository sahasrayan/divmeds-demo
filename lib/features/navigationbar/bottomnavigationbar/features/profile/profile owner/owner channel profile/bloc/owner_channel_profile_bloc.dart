import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'owner_channel_profile_event.dart';
part 'owner_channel_profile_state.dart';

class OwnerChannelProfileBloc extends Bloc<OwnerChannelProfileEvent, OwnerChannelProfileState> {
  OwnerChannelProfileBloc() : super(OwnerChannelProfileInitial()) {
    on<OwnerChannelProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
