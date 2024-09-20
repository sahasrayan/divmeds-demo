import 'package:bloc/bloc.dart';
import 'package:divmeds/utils/validators/validators_regex.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_user_registration_form_event.dart';
part 'auth_user_registration_form_state.dart';

class AuthUserRegistrationFormBloc
    extends Bloc<AuthUserRegistrationFormEvent, AuthUserRegistrationFormState> {
  final AuthRepository authRepository;
  final String phoneNumber;
  final String gender;
  final String dob;

  AuthUserRegistrationFormBloc({
    required this.authRepository,
    required this.phoneNumber,
    required this.gender,
    required this.dob,
  }) : super(AuthUserRegistrationFormInitial()) {
    on<AuthSubmitRequestedEvent>(
      (event, emit) async {
        try {
          final String userID = event.userID;
          final String firstName = event.firstName;
          final String lastName = event.lastName;
          final String gender = event.gender;
          final String mobileNumber = phoneNumber;
          final String dateOfBirth = dob;
          final String password = event.password;
         

          if (userID.isEmpty) {
            return emit(AuthUserRegistrationFormFailureState(
                "UserID is empty. Enter a proper UserID to proceed with the registration"));
          }
          if (!validateUsername(userID)) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Invalid UserID Format. UserID must start with a lowercase letter, be between 4 and 20 characters long, and can only contain lowercase letters, digits, and underscores.",
              ),
            );
          }
          if (firstName.isEmpty) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "First name is empty. Please enter your first name!",
              ),
            );
          }
          if (!validateName(firstName)) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Invalid first name format!",
              ),
            );
          }
          if (lastName.isEmpty) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Last name is empty. Please enter your last name!",
              ),
            );
          }
          if (!validateName(lastName)) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Invalid last name format!",
              ),
            );
          }
          if (gender.isEmpty) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Gender is not selected. Please select your gender!",
              ),
            );
          }
          if (password.isEmpty) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Password field is empty. Please enter your password!",
              ),
            );
          }
          if (!validatePassword(password)) {
            return emit(
              AuthUserRegistrationFormFailureState(
                "Password must be between 8 and 12 characters and contain at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$&*~)",
              ),
            );
          }

          // if (confirmPassword.isEmpty) {
          //   return emit(
          //     AuthUserRegistrationFormFailureState(
          //       "Confirm password field is empty. Please enter your password!",
          //     ),
          //   );
          // }
          // if (password != confirmPassword) {
          //   return emit(
          //     AuthUserRegistrationFormFailureState(
          //       "Passwords do not match. Please re-enter your password!",
          //     ),
          //   );
          // }

          emit(AuthUserRegistrationFormLoadingState());

          final user = await authRepository.register(
            firstName: firstName,
            lastName: lastName,
            userId: userID,
            password: password,
            phone: mobileNumber,
            dob: dateOfBirth,
            gender: gender,
          );

          if (user != null) {
            final token = SharedPreferencesManager.getToken();
            await SharedPreferencesManager.saveUid(user.userId);
            await SharedPreferencesManager.saveUser(user);
            await SharedPreferencesManager.saveToken(token);

            emit(AuthUserRegistrationFormSuccessState(user: user));
          } else {
            emit(AuthUserRegistrationFormFailureState(
                "Registration failed. Please try again."));
          }
        } catch (error) {
          emit(
            AuthUserRegistrationFormFailureState(error.toString()),
          );
        }
      },
    );
  }
}
