import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_password_reset_event.dart';
part 'auth_password_reset_state.dart';

class AuthPasswordResetBloc extends Bloc<AuthPasswordResetEvent, AuthPasswordResetState> {
  AuthPasswordResetBloc() : super(AuthPasswordResetInitial()) {
    on<AuthPasswordResetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
