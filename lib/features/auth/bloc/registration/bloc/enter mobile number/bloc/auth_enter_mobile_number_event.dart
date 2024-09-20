part of 'auth_enter_mobile_number_bloc.dart';

@immutable
abstract class AuthEnterMobileNumberEvent {}

class ContinueButtonPressedEvent extends AuthEnterMobileNumberEvent {
  final String phoneNumber;

  ContinueButtonPressedEvent({required this.phoneNumber});
}
