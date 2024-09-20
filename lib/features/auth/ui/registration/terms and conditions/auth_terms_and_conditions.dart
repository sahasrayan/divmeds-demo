import 'package:divmeds/features/auth/bloc/registration/bloc/terms%20and%20conditions/bloc/auth_terms_and_conditions_enter_bloc.dart';
import 'package:divmeds/utils/logo%20widgets/blue_logo_widget.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/ui/registration/enter%20mobile%20number/auth_enter_mobile_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  void _termsAndConditionsAccepted() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const EnterMobileNumber();
          },
        ),
      );   
    }
    );
    
  }
  void _terms(){

  }
  void  _privacyPolicy(){

  }
  void _cookiesPolicy(){

  }



  @override
  Widget build(BuildContext context) {
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
              const BlueLogoWidget(),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Welcome to DivMeds",
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.divMedsColorBlue2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'By tapping ',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    '\'Continue\', ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "you agree to our ",
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      _terms();
                      // link for the terms and conditions
                    },
                    child: const Text(
                      "Terms",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const Text('.'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Learn how we process your data in our ',
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      _privacyPolicy();
                      // Implement link for the privacy policy page
                    },
                    child: const Text(
                      "Privacy",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                     _privacyPolicy();
                      // Implement link for the privacy policy page
                    },
                    child: const Text(
                      "Policy",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const Text(
                    " and ",
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      _cookiesPolicy();
                      // Implement link for the cookies policy page
                    },
                    child: const Text(
                      "Cookies Policy",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InputButton(
                onPressed: () {
                  _termsAndConditionsAccepted();
                },
                buttonName: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
