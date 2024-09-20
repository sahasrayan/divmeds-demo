import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  const LoginEvent(this.phoneNumber, this.password);

  @override
  List<Object> get props => [phoneNumber, password];
}

class FetchUserProfileEvent extends AuthEvent {
  final String token;

  const FetchUserProfileEvent(this.token);

  @override
  List<Object> get props => [token];
}
