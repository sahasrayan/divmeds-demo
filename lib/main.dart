import 'package:divmeds/features/auth/bloc/auth/auth_bloc.dart';
import 'package:divmeds/features/auth/twilio/repositories/twilio_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divmeds/app.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/designs/app_theme.dart';
import 'package:divmeds/features/auth/bloc/forgot%20password/bloc/forgot%20password/bloc/auth_forgot_password_bloc.dart';
import 'package:divmeds/features/auth/bloc/login/bloc/login/bloc/auth_login_bloc.dart';
import 'package:divmeds/features/auth/bloc/registration/bloc/enter%20mobile%20number/bloc/auth_enter_mobile_number_bloc.dart';
import 'package:divmeds/features/auth/bloc/registration/bloc/otp%20enter/bloc/auth_otp_enter_bloc.dart';
import 'package:divmeds/features/auth/bloc/registration/bloc/user%20registration%20form/bloc/auth_user_registration_form_bloc.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  Config.token = SharedPreferencesManager.getToken();
  Temp.tempPhoneNumber = SharedPreferencesManager.getPhoneNumber();
  final AuthRepository authRepository =
      AuthRepository(serverUrl: Config.serverUrl);
  final OtpRepository otpRepository = OtpRepository();

  runApp(MyApp(authRepository: authRepository, otpRepository: otpRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final OtpRepository otpRepository;

  const MyApp(
      {super.key, required this.authRepository, required this.otpRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider<AuthLoginBloc>(
          create: (context) => AuthLoginBloc(authRepository: authRepository),
        ),
        BlocProvider<AuthUserRegistrationFormBloc>(
          create: (BuildContext context) {
            return AuthUserRegistrationFormBloc(authRepository: authRepository,
            phoneNumber:  SharedPreferencesManager.getPhoneNumber(),
            gender: SharedPreferencesManager.getGender(), dob: SharedPreferencesManager.getDOB(),
            );
          },
        ),
        BlocProvider<AuthEnterMobileNumberBloc>(
          create: (BuildContext context) {
            return AuthEnterMobileNumberBloc(otpRepository);
          },
        ),
        BlocProvider<AuthOtpEnterBloc>(
          create: (BuildContext context) {
            // Retrieve the phone number from your flow
            return AuthOtpEnterBloc(
                otpRepository: otpRepository,
                phoneNumber:
                    // SharedPreferencesManager.getTemporaryPhoneNumber()
                    Temp.tempPhoneNumber,
                    );
          },
        ),
        BlocProvider<AuthForgotPasswordBloc>(
          create: (BuildContext context) {
            return AuthForgotPasswordBloc();
          },
        ),
      ],
      child: MaterialApp(
        title: "DivMeds",
        debugShowCheckedModeBanner: false,
        home: const DecidePage(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
