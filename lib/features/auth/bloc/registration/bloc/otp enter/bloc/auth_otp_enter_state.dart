part of 'auth_otp_enter_bloc.dart';

@immutable
abstract class AuthOtpEnterState {}

class AuthOtpEnterInitial extends AuthOtpEnterState {}

class AuthOtpEnterVerifyingOTPLoadingState extends AuthOtpEnterState {}

class AuthOtpEnterOTPVerificationSuccessState extends AuthOtpEnterState {
  final String otpVerifiedMessage;
  AuthOtpEnterOTPVerificationSuccessState(this.otpVerifiedMessage);
}

class AuthOtpEnterOTPVerificationFailedState extends AuthOtpEnterState {
  final String error;
  AuthOtpEnterOTPVerificationFailedState(this.error);
}