part of 'auth_login_bloc.dart';

@immutable
sealed class AuthLoginState {}

final class AuthLoginInitial extends AuthLoginState {}

final class AuthLoginLoadingState extends AuthLoginState {}

final class AuthLoginSuccessState extends AuthLoginState {
  final User user;
  final String token;

  AuthLoginSuccessState( {required this.user, required this.token,});
}

final class AuthLoginFailureState extends AuthLoginState {
  final String error;

  AuthLoginFailureState(this.error);
}
