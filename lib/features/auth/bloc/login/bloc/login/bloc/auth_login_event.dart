part of 'auth_login_bloc.dart';

@immutable
sealed class AuthLoginEvent {}

final class AuthLoginRequestedEvent extends AuthLoginEvent {
  final String phoneNumber;
  final String password;

  AuthLoginRequestedEvent({
    required this.phoneNumber,
    required this.password,
  });
}

