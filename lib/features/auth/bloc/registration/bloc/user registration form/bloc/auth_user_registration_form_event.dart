part of 'auth_user_registration_form_bloc.dart';

@immutable
sealed class AuthUserRegistrationFormEvent {}

final class AuthSubmitRequestedEvent extends AuthUserRegistrationFormEvent {
  final String userID;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String dateOfBirth;
  final String gender;
  final String password;


  AuthSubmitRequestedEvent({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.password,
    
  });
}
