import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_birthday_picker_event.dart';
part 'auth_birthday_picker_state.dart';

class AuthBirthdayPickerBloc extends Bloc<AuthBirthdayPickerEvent, AuthBirthdayPickerState> {
  AuthBirthdayPickerBloc() : super(AuthBirthdayPickerInitial()) {
    on<AuthBirthdayPickerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
