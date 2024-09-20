import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio _dio = Dio();
  final String serverUrl = Config.serverUrl;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<FetchUserProfileEvent>(_onFetchUserProfileEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final formattedPhoneNumber = '+91${event.phoneNumber}';
      final response = await _dio.post(
        '$serverUrl/auth/login',
        data: {
          'phone': formattedPhoneNumber,
          'password': event.password,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        final token = response.data['token'];
        await SharedPreferencesManager.saveToken(token);
        await SharedPreferencesManager.saveUid(response.data['user']['userId']);
        
        add(FetchUserProfileEvent(token));
      } else {
        emit(AuthFailure('Failed to login. Please try again.'));
      }
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred. Please try again later.'));
    }
  }

  Future<void> _onFetchUserProfileEvent(FetchUserProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _dio.get(
        '$serverUrl/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${event.token}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        final user = User.fromJson(response.data['user']);
        await SharedPreferencesManager.saveUser(user);
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('Failed to fetch user profile.'));
      }
    } catch (e) {
      emit(AuthFailure('An unexpected error occurred. Please try again later.'));
    }
  }
}
