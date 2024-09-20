import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/bloc/forgot%20password/bloc/forgot%20password/bloc/auth_forgot_password_bloc.dart';
import 'package:divmeds/features/auth/bloc/password%20reset/bloc/password%20reset/bloc/auth_password_reset_bloc.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/ui/password_reset/auth_password_reset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _forgotPasswordIdController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOTPSent = false;
  bool _isOTPSubmitted = false;
  void _wrongNumberPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const ForgotPassword();
        },
      ),
    );
  }

  void _passwordResetPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const PasswordReset();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthForgotPasswordBloc, AuthForgotPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.divMedsColorWhite,
                AppColors.divMedsColorWhite,
                AppColors.divMedsColorWhite,
                AppColors.divMedsColorBlue4,
              ],
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: [
                  !_isOTPSent
                      ? Column(
                          children: [
                            const Text(
                              "Find your account",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  TextInputField(
                                    hintText: "Enter your phone number",
                                    obscureText: false,
                                    controller: _forgotPasswordIdController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            _isOTPSent = true;
                                            print("OTP Sent!");
                                          },
                                        );
                                      },
                                      buttonName: "Send code"),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            children: [
                              const Text(
                                "Confirm your account",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              TextInputField(
                                hintText: "Enter code",
                                obscureText: false,
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _isOTPSubmitted = true;
                                      // navigating to the password reset page!
                                      _passwordResetPage();
                                      print("OTP Submitted!");
                                    },
                                  );
                                },
                                buttonName: "Continue",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Implement OTP resend method
                                      print("Send Code again pressed!");
                                    },
                                    child: const Text(
                                      "Send code again",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.divMedsColorBlue3,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // navigating to the forgot password page
                                      _wrongNumberPressed();
                                      print("Wrong number pressed!");
                                    },
                                    child: const Text(
                                      "Wrong number?",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.divMedsColorBlue3,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
