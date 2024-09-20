part of 'auth_user_registration_form_bloc.dart';

@immutable
sealed class AuthUserRegistrationFormState {}

final class AuthUserRegistrationFormInitial extends AuthUserRegistrationFormState {}

final class AuthUserRegistrationFormLoadingState extends AuthUserRegistrationFormState {}

final class AuthUserRegistrationFormSuccessState extends AuthUserRegistrationFormState {
  final User user;

  AuthUserRegistrationFormSuccessState({required this.user});
}

final class AuthUserRegistrationFormFailureState extends AuthUserRegistrationFormState {
  final String error;

  AuthUserRegistrationFormFailureState(this.error);
}
