part of 'auth_password_reset_bloc.dart';

@immutable
sealed class AuthPasswordResetState {}

final class AuthPasswordResetInitial extends AuthPasswordResetState {}
