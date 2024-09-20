// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:divmeds/features/auth/bloc/auth/auth_bloc.dart';
// import 'package:divmeds/features/auth/bloc/auth/auth_event.dart';
// import 'package:divmeds/features/auth/bloc/auth/auth_state.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/bottomnavigationbar.dart';
// import 'package:divmeds/utils/logo%20widgets/blue_logo_widget.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/components/input_button.dart';
// import 'package:divmeds/features/auth/components/text_input_field.dart';
// import 'package:divmeds/features/auth/ui/forgot_password/auth_forgot_password.dart';
// import 'package:divmeds/features/auth/ui/registration/auth_user_registration.dart';
// import 'package:divmeds/utils/validators/validators_regex.dart';

// final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

// class AuthLoginScreen extends StatefulWidget {
//   const AuthLoginScreen({super.key});

//   @override
//   State<AuthLoginScreen> createState() => _AuthLoginScreenState();
// }

// class _AuthLoginScreenState extends State<AuthLoginScreen> {
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _mobileController.dispose();
//     _passwordController.dispose();
//   }

//   void _login(BuildContext context) {
//     final phoneNumber = _mobileController.text.trim();
//     final password = _passwordController.text.trim();

//     if (phoneNumber.isEmpty) {
//       _showSnackBar('Phone number is required.');
//       return;
//     }
//     if (!validateMobileNumber(phoneNumber)) {
//       _showSnackBar('Invalid phone number entered.');
//       return;
//     }
//     if (password.isEmpty) {
//       _showSnackBar('Password is required.');
//       return;
//     }
//     if (!validatePassword(password)) {
//       _showSnackBar('Invalid password format entered.');
//       return;
//     }

//     context.read<AuthBloc>().add(LoginEvent(phoneNumber, password));
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _userRegisterPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return UserRegistration();
//         },
//       ),
//     );
//   }

//   void _forgotPassword() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return ForgotPassword();
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BottomNavigationBarItems(user: state.user)));
//         } else if (state is AuthFailure) {
//           _showSnackBar(state.error);
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomCenter,
//             colors: const [
//               AppColors.divMedsColorWhite,
//               AppColors.divMedsColorWhite,
//               AppColors.divMedsColorWhite,
//               AppColors.divMedsColorBlue4,
//             ],
//           ),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Form(
//             key: _loginFormKey,
//             child: SingleChildScrollView(
//               child: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 90),
//                     BlueLogoWidget(),
//                     SizedBox(height: 50),
//                     TextInputField(
//                       hintText: "Enter your phone number",
//                       obscureText: false,
//                       controller: _mobileController,
//                       keyboardType: TextInputType.phone,
//                     ),
//                     SizedBox(height: 30),
//                     TextInputField(
//                       hintText: "Enter your password",
//                       obscureText: true,
//                       controller: _passwordController,
//                       keyboardType: TextInputType.text,
//                     ),
//                     SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           GestureDetector(
//                             onTap: _forgotPassword,
//                             child: Text(
//                               "Forgot password?",
//                               style: TextStyle(
//                                 color: AppColors.divMedsColorBlue3,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'By tapping ',
//                           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
//                         ),
//                         const Text(
//                           '\'Log in\', ',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 14,
//                           ),
//                         ),
//                         const Text(
//                           "you agree to our ",
//                           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             print("Terms Pressed");
//                           },
//                           child: const Text(
//                             "Terms",
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                         const Text('.'),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Learn how we process your data in our ',
//                           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             print("Privacy Pressed");
//                           },
//                           child: const Text(
//                             "Privacy",
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             print("Policy Pressed");
//                           },
//                           child: const Text(
//                             "Policy",
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                         const Text(
//                           " and ",
//                           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             print("Cookies Policy Pressed");
//                           },
//                           child: const Text(
//                             "Cookies Policy",
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 40),
//                     InputButton(onPressed: () => _login(context), buttonName: "Log in"),
//                     const SizedBox(height: 60),
//                     GestureDetector(
//                       onTap: () {
//                         _userRegisterPage();
//                       },
//                       child: Text(
//                         "Create a new account",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.divMedsColorBlue3,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/dummy_user.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/bottomnavigationbar.dart';
import 'package:divmeds/utils/logo%20widgets/blue_logo_widget.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/ui/forgot_password/auth_forgot_password.dart';
import 'package:divmeds/features/auth/ui/registration/auth_user_registration.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/utils/validators/validators_regex.dart'; // Ensure you have this import for validation

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio _dio = Dio();
  final String serverUrl = Config.serverUrl;

  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }
// Login Button Function
  Future<void> _logIn() async {
    // try {
    //   final phoneNumber = _mobileController.text.trim();
    //   final password = _passwordController.text.trim();

    //   if (phoneNumber.isEmpty) {
    //     _showSnackBar('Phone number is required.');
    //     return;
    //   }
    //   if (!validateMobileNumber(phoneNumber)) {
    //     _showSnackBar('Invalid phone number entered.');
    //     return;
    //   }
    //   if (password.isEmpty) {
    //     _showSnackBar('Password is required.');
    //     return;
    //   }
    //   if (!validatePassword(password)) {
    //     _showSnackBar('Invalid password format entered.');
    //     return;
    //   }

    //   final formattedPhoneNumber = '+91$phoneNumber';
    //   final response = await _dio.post(
    //     '$serverUrl/auth/login',
    //     data: {
    //       'phone': formattedPhoneNumber,
    //       'password': password,
    //     },
    //   );

    //   if (response.statusCode! >= 200 && response.statusCode! <= 300) {
    //     print('Login response: ${response.data}');
    //     final token = response.data['token'];
    //     final user = User.fromJson(response.data['user']);
        
    //     final prefs = await SharedPreferences.getInstance();
    //     await prefs.setString('token', token);
    //     await prefs.setString('uid', user.userId);

    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) {
    //         return BottomNavigationBarItems(user: user);
    //       }),
    //       (route) => false,
    //     );
    //   } else {
    //     print('Failed to login: ${response.data}');
    //     _showSnackBar('Failed to login. Please try again.');
    //   }
    // } catch (e) {
    //   print('An error occurred: $e');
    //   _showSnackBar('An unexpected error occurred. Please try again later.');
    // }
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BottomNavigationBarItems(user: user);
        },
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _userRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return UserRegistration();
        },
      ),
    );
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ForgotPassword();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: const [
            AppColors.divMedsColorWhite,
            AppColors.divMedsColorWhite,
            AppColors.divMedsColorWhite,
            AppColors.divMedsColorBlue4,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _loginFormKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 90),
                  BlueLogoWidget(),
                  SizedBox(height: 50),
                  TextInputField(
                    hintText: "Enter your phone number",
                    obscureText: false,
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 30),
                  TextInputField(
                    hintText: "Enter your password",
                    obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _forgotPassword,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: AppColors.divMedsColorBlue3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'By tapping ',
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        '\'Log in\', ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        "you agree to our ",
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Terms Pressed");
                        },
                        child: const Text(
                          "Terms",
                          style: TextStyle(
                              fontSize: 14.0,
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
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Privacy Pressed");
                        },
                        child: const Text(
                          "Privacy",
                          style: TextStyle(
                              fontSize: 14.0,
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
                          print("Policy Pressed");
                        },
                        child: const Text(
                          "Policy",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const Text(
                        " and ",
                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Cookies Policy Pressed");
                        },
                        child: const Text(
                          "Cookies Policy",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  InputButton(onPressed: _logIn, buttonName: "Log in"),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      // _userRegisterPage();
                    },
                    child: Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.divMedsColorBlue3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



