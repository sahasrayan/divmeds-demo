




import 'package:bloc/bloc.dart';
import 'package:divmeds/utils/validators/validators_regex.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final AuthRepository authRepository;

  AuthLoginBloc({required this.authRepository}) : super(AuthLoginInitial()) {
   on<AuthLoginRequestedEvent>(
  (event, emit) async {
    try {
      final phoneNumber = event.phoneNumber;
      final password = event.password;

      if (phoneNumber.isEmpty) {
        return emit(AuthLoginFailureState("Phone number is required."));
      }
      if (!validateMobileNumber(phoneNumber)) {
        return emit(AuthLoginFailureState("Invalid phone number entered."));
      }

      if (password.isEmpty) {
        return emit(AuthLoginFailureState("Password is required."));
      }
      if (!validatePassword(password)) {
        return emit(
            AuthLoginFailureState("Invalid password format entered."));
      }

      emit(AuthLoginLoadingState());

      // Concatenate phone number with country code +91
      final formattedPhoneNumber = '+91$phoneNumber';

      final result = await authRepository.login(phone: formattedPhoneNumber, password: password);

      if (result != null && result['user'] != null && result['token'] != null) {
        final user = result['user'] as User;
        final token = result['token'] as String;

        await SharedPreferencesManager.saveUid(user.userId);
        await SharedPreferencesManager.saveUser(user);
        await SharedPreferencesManager.saveToken(token);

        emit(AuthLoginSuccessState(user: user, token: token));
      } else {
        emit(AuthLoginFailureState("Failed to login. Missing token or user data."));
      }
    } catch (error) {
      emit(AuthLoginFailureState("An error occurred: ${error.toString()}"));
    }
  },
);
  }
}

