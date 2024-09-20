import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_forgot_password_event.dart';
part 'auth_forgot_password_state.dart';

class AuthForgotPasswordBloc extends Bloc<AuthForgotPasswordEvent, AuthForgotPasswordState> {
  AuthForgotPasswordBloc() : super(AuthForgotPasswordInitial()) {
    on<AuthForgotPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
