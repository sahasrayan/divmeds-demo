part of 'auth_enter_mobile_number_bloc.dart';

@immutable
abstract class AuthEnterMobileNumberState {}

class AuthEnterMobileNumberInitial extends AuthEnterMobileNumberState {}

class AuthEnterMobileNumberLoadingState extends AuthEnterMobileNumberState {}

class AuthEnterMobileNumberSuccessState extends AuthEnterMobileNumberState {}

class AuthMobileNumberSentToServerState extends AuthEnterMobileNumberState {
  final String mobileNumber;

  AuthMobileNumberSentToServerState(this.mobileNumber);
}

class AuthEnterMobileNumberFailureState extends AuthEnterMobileNumberState {
  final String error;
  AuthEnterMobileNumberFailureState(this.error);
}
