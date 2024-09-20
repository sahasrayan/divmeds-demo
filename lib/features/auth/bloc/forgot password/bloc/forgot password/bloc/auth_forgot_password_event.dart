part of 'auth_forgot_password_bloc.dart';

@immutable
sealed class AuthForgotPasswordEvent {}

final class SendCodeButtonPressedEvent extends AuthForgotPasswordEvent{

}

final class ContinueButtonPressedEvent extends AuthForgotPasswordEvent{
  
}
