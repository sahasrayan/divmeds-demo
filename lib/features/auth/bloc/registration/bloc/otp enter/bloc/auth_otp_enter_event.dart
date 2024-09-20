part of 'auth_otp_enter_bloc.dart';


@immutable
abstract class AuthOtpEnterEvent {}

class ContinueButtonPressedEvent extends AuthOtpEnterEvent {
  final String otp;
  final String phoneNumber;

  ContinueButtonPressedEvent({required this.otp, required this.phoneNumber});
}

class SendCodeAgainPressedEvent extends AuthOtpEnterEvent {
  final String phoneNumber;

  SendCodeAgainPressedEvent({required this.phoneNumber});
}
