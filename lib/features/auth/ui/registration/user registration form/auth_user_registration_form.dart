import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/auth_global_variables.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/bottomnavigationbar.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/utils/validators/validators_regex.dart';

enum Gender { male, female, others }

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();
  final TextEditingController _genderController = TextEditingController(text: authGender);

  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  bool _isPasswordVisibleObscure = true;
  bool _isRetypePasswordVisibleObscure = true;
  Gender? _selectedGender;

  final AuthRepository authRepository = AuthRepository(serverUrl: Config.serverUrl);

  @override
  void dispose() {
    super.dispose();
    _userIDController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    _genderController.dispose();
  }
 final formattedPhoneNumber = '+91$SharedPreferencesManager.getPhoneNumber()';
  void _createAccount() async {
    if (_registrationFormKey.currentState!.validate()) {
      final user = await authRepository.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        userId: _userIDController.text.trim(),
        password: _passwordController.text.trim(),
        phone: formattedPhoneNumber,
        dob: SharedPreferencesManager.getDOB(),
        gender: _genderController.text.trim(),
      );

      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarItems(user: user),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
          ),
        );
      }
    }
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: _registrationFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Enter your details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Create a unique UserID for your DivMeds account.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                TextInputField(
                  hintText: "Create an UserID",
                  labelText: "UserID",
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  floatingLabelStyle: const TextStyle(color: AppColors.divMedsColorBlue2),
                  obscureText: false,
                  controller: _userIDController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "UserID is required";
                    }
                    if (!validateUsername(value)) {
                      return "Invalid UserID format";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "What's your name?",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextInputField(
                        hintText: "Firstname",
                        labelText: "Firstname",
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        floatingLabelStyle: const TextStyle(color: AppColors.divMedsColorBlue2),
                        obscureText: false,
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Firstname is required";
                          }
                          if (!validateName(value)) {
                            return "Invalid first name format";
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextInputField(
                        hintText: "Lastname",
                        labelText: "Lastname",
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        floatingLabelStyle: const TextStyle(color: AppColors.divMedsColorBlue2),
                        obscureText: false,
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Lastname is required";
                          }
                          if (!validateName(value)) {
                            return "Invalid last name format";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 25.8),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: Gender.male,
                          groupValue: _selectedGender,
                          onChanged: (genderValue) {
                            setState(() {
                              _selectedGender = Gender.male;
                              authGender = "male";
                              _genderController.text = "male";
                              SharedPreferencesManager.saveGender(_selectedGender.toString());
                            });
                          },
                          title: const Text("Male"),
                          contentPadding: const EdgeInsets.all(0),
                          toggleable: true,
                          activeColor: AppColors.divMedsColorBlue3,
                          tileColor: Colors.grey[200],
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: Gender.female,
                          groupValue: _selectedGender,
                          onChanged: (genderValue) {
                            setState(() {
                              _selectedGender = Gender.female;
                              authGender = "female";
                              _genderController.text = "female";
                              SharedPreferencesManager.saveGender(_selectedGender.toString());
                            });
                          },
                          title: const Text("Female"),
                          contentPadding: const EdgeInsets.all(0),
                          toggleable: true,
                          activeColor: AppColors.divMedsColorBlue3,
                          tileColor: Colors.grey[200],
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: Gender.others,
                          groupValue: _selectedGender,
                          onChanged: (genderValue) {
                            setState(() {
                              _selectedGender = Gender.others;
                              authGender = "others";
                              _genderController.text = "others";
                              SharedPreferencesManager.saveGender(_selectedGender.toString());
                            });
                          },
                          title: const Text("Others"),
                          contentPadding: const EdgeInsets.all(0),
                          toggleable: true,
                          activeColor: AppColors.divMedsColorBlue3,
                          tileColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create a secure password for your DivMeds account.",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                TextInputField(
                  hintText: "Create your password",
                  labelText: "Create your password",
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  floatingLabelStyle: const TextStyle(color: AppColors.divMedsColorBlue2),
                  obscureText: _isPasswordVisibleObscure,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIconWidget: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisibleObscure = !_isPasswordVisibleObscure;
                      });
                    },
                    icon: _isPasswordVisibleObscure
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (!validatePassword(value)) {
                      return "Password must be between 8 and 12 characters and contain at least one uppercase letter, one lowercase letter, one digit, and one special character (!@#\$&*~)";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextInputField(
                  hintText: "Confirm your password",
                  labelText: "Confirm your password",
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  floatingLabelStyle: const TextStyle(color: AppColors.divMedsColorBlue2),
                  obscureText: _isRetypePasswordVisibleObscure,
                  controller: _retypePasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIconWidget: IconButton(
                    onPressed: () {
                      setState(() {
                        _isRetypePasswordVisibleObscure = !_isRetypePasswordVisibleObscure;
                      });
                    },
                    icon: _isRetypePasswordVisibleObscure
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password is required";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputButton(
                  onPressed: _createAccount,
                  buttonName: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



















// import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/auth_global_variables.dart';
// import 'package:divmeds/features/auth/bloc/registration/bloc/user%20registration%20form/bloc/auth_user_registration_form_bloc.dart';
// import 'package:divmeds/features/auth/components/input_button.dart';
// import 'package:divmeds/features/auth/components/text_input_field.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/bottomnavigationbar.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // defining the global form key
// // final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

// // Enums, short for enumerations, are a way to define a collection of related constants in a programming language. They allow you to declare a type consisting of a set of named values, which can be treated as discrete entities.
// // ignore: constant_identifier_names
// enum Gender { male, female, others }

// Gender? _selectedGender;

// class UserRegistrationForm extends StatefulWidget {
//   const UserRegistrationForm({super.key});

//   @override
//   State<UserRegistrationForm> createState() => _UserRegistrationFormState();
// }

// class _UserRegistrationFormState extends State<UserRegistrationForm> {
//   final TextEditingController _userIDController = TextEditingController();
//   // Passing the mobile number and the dateofbirth via constructors.
//   // final TextEditingController _mobileController = TextEditingController(text:authMobileNumber);
//   // final TextEditingController _dateOfBirthController =TextEditingController(text:authDOB);
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _retypePasswordController =
//       TextEditingController();
//   // Initializing the _genderController's value to "", so that validations can be applied using BLOC.
//   final TextEditingController _genderController =
//       TextEditingController(text: authGender);


//   @override
//   void dispose() {
//     super.dispose();
//     _userIDController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _passwordController.dispose();
//     _retypePasswordController.dispose();
//     _genderController.dispose();
//   }

// // Password visibility togglers

//   bool _isPasswordVisibleObscure = true;
//   bool _isRetypePasswordVisibleObscure = true;

//   void _createAccount() async {
   
//     context.read<AuthUserRegistrationFormBloc>().add(
//           AuthSubmitRequestedEvent(
//             userID: _userIDController.text.trim(),
//             firstName: _firstNameController.text.trim(),
//             lastName: _lastNameController.text.trim(),
//             mobileNumber:  SharedPreferencesManager.getPhoneNumber(),
//             dateOfBirth: SharedPreferencesManager.getDOB(),
//             gender: _genderController.text.trim(),
//             password: _passwordController.text.trim(),
          
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//           colors: [
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorBlue4,
//           ],
//         ),
//       ),
//       child: BlocConsumer<AuthUserRegistrationFormBloc,
//           AuthUserRegistrationFormState>(
//         listener: (context, state) {
//           if (state is AuthUserRegistrationFormFailureState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error),
//               ),
//             );
//           }
//          if(state is AuthUserRegistrationFormSuccessState){
//           Navigator.pushAndRemoveUntil(context, 
//           MaterialPageRoute(builder: (context)=>  BottomNavigationBarItems(user: state.user,),)
//           , (route) => false);
//          }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//             ),
//             body: Form(
//               // key: _registrationFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children:
//                       // make sure all are required
//                       // username
//                       // Full Name
//                       // gender
//                       // password
//                       // confirm password

//                       [
//                     const Text(
//                       "Enter your details",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     const Text(
//                       "Create an unique UserID for your DivMeds account. ",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextInputField(
//                       hintText: "Create an UserID",
//                       labelText: "UserID",
//                       labelStyle: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                       floatingLabelStyle: const TextStyle(
//                         color: AppColors.divMedsColorBlue2,
//                       ),
//                       obscureText: false,
//                       controller: _userIDController,
//                       keyboardType: TextInputType.text,
//                       // validator: (value) {
//                       //   if (value == null || value.isEmpty) {
//                       //     return "UserID is required";
//                       //   }
//                       //   if (!usernameRegex.hasMatch(value)) {
//                       //     return "Invalid UserID format";
//                       //   }
//                       //   return null;
//                       // },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       "What's your name?                                                          ",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextInputField(
//                             hintText: "Firstname",
//                             labelText: "Firstname",
//                             labelStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             floatingLabelStyle: const TextStyle(
//                               color: AppColors.divMedsColorBlue2,
//                             ),
//                             obscureText: false,
//                             controller: _firstNameController,
//                             keyboardType: TextInputType.name,
//                           ),
//                         ),
//                         Expanded(
//                           child: TextInputField(
//                             hintText: "Lastname",
//                             labelText: "Lastname",
//                             labelStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             floatingLabelStyle: const TextStyle(
//                               color: AppColors.divMedsColorBlue2,
//                             ),
//                             obscureText: false,
//                             controller: _lastNameController,
//                             keyboardType: TextInputType.name,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     //  alignment: const Alignment(0.79, 0),
//                     const Text(
//                       "Gender                                                                               ",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       // decoration: BoxDecoration(
//                       //   color: Colors.grey[200],
//                       // ),
//                       width: 400,
//                       // padding: const EdgeInsets.only(
//                       //   left: 10,
//                       //   right: 10,
//                       //   top: 0,
//                       //   bottom: 0,
//                       // ),
//                       margin: const EdgeInsets.only(
//                         left: 25.8,
//                         right: 24.8,
//                         top: 0,
//                         bottom: 0,
//                       ),
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: RadioListTile(
//                               value: Gender.male,
//                               groupValue: _selectedGender,
//                               onChanged: (genderValue) {
//                                 setState(
//                                   () {
//                                     _selectedGender = Gender.male;
//                                     authGender = "male";
//                                     _genderController.text = "male";
//                                     SharedPreferencesManager.saveGender(_selectedGender.toString());
                                   
                                    
//                                   },
//                                 );
//                               },
//                               title: const Text("Male"),
//                               contentPadding: const EdgeInsets.all(0),
//                               toggleable: true,
//                               activeColor: AppColors.divMedsColorBlue3,
//                               tileColor: Colors.grey[200],
//                             ),
//                           ),
//                           // const SizedBox(width: 10,),
//                           Expanded(
//                             child: RadioListTile(
//                               value: Gender.female,
//                               groupValue: _selectedGender,
//                               onChanged: (genderValue) {
//                                 setState(
//                                   () {
//                                     _selectedGender = Gender.female;
//                                     authGender = "female";
//                                     _genderController.text = "female";
//                                      SharedPreferencesManager.saveGender(_selectedGender.toString());
//                                     // print(authGender);
//                                   },
//                                 );
//                               },
//                               title: const Text("Female"),
//                               contentPadding: const EdgeInsets.all(0),
//                               toggleable: true,
//                               activeColor: AppColors.divMedsColorBlue3,
//                               tileColor: Colors.grey[200],
//                             ),
//                           ),
//                           // const SizedBox(width: 10,),
//                           Expanded(
//                             child: RadioListTile(
//                               value: Gender.others,
//                               groupValue: _selectedGender,
//                               onChanged: (genderValue) {
//                                 setState(
//                                   () {
//                                     _selectedGender = Gender.others;
//                                     authGender = "others";
//                                     _genderController.text = "other";
//                                      SharedPreferencesManager.saveGender(_selectedGender.toString());
//                                     //  print(authGender);
//                                   },
//                                 );
//                               },
//                               title: const Text("Others"),
//                               contentPadding: const EdgeInsets.all(0),
//                               toggleable: true,
//                               activeColor: AppColors.divMedsColorBlue3,
//                               tileColor: Colors.grey[200],
//                               selectedTileColor: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       "Create a secure password for your DivMeds account.",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextInputField(
//                       hintText: "Create your password",
//                       labelText: "Create your password",
//                       labelStyle: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                       floatingLabelStyle: const TextStyle(
//                         color: AppColors.divMedsColorBlue2,
//                       ),
//                       obscureText: _isPasswordVisibleObscure,
//                       controller: _passwordController,
//                       keyboardType: TextInputType.visiblePassword,
//                       suffixIconWidget: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _isPasswordVisibleObscure =   !_isPasswordVisibleObscure;
                             
//                           });
//                         },
//                         icon: _isPasswordVisibleObscure ? const Icon(Icons.visibility_off_outlined) :
//                         const Icon(Icons.visibility_outlined),
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextInputField(
//                       hintText: "Confirm your password",
//                       // labelText: "Confirm your password",
//                       label: const Text("Confirm your password"),
//                       labelStyle: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                       floatingLabelStyle: const TextStyle(
//                         color: AppColors.divMedsColorBlue2,
//                       ),
//                       obscureText: _isRetypePasswordVisibleObscure,
//                       controller: _retypePasswordController,
//                       keyboardType: TextInputType.visiblePassword,
//                       suffixIconWidget: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _isRetypePasswordVisibleObscure =   !_isRetypePasswordVisibleObscure;
                             
//                           });
//                         },
//                         icon: _isRetypePasswordVisibleObscure ? const Icon(Icons.visibility_off_outlined) :
//                         const Icon(Icons.visibility_outlined),
//                       ),

//                     ),

//                     const SizedBox(
//                       height: 20,
//                     ),
//                     // InputButton(onPressed: (){
//                     //   print(authMobileNumber);
//                     // }, buttonName: "Print Mobile Number"),
//                     // const SizedBox(height: 10,),
//                     // InputButton(onPressed: (){
//                     //   print(authDOB);
//                     // }, buttonName: "Print Date of Birth"),
//                     InputButton(
//                         onPressed: () {
//                           _createAccount();
//                         },
//                         buttonName: "Submit")
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }























// Using the validators to validate the form

// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/components/input_button.dart';
// import 'package:divmeds/features/auth/components/text_input_field.dart';
// import 'package:divmeds/utils/validators/validators_regex.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// // defining the global form key
// final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

// // Enums, short for enumerations, are a way to define a collection of related constants in a programming language. They allow you to declare a type consisting of a set of named values, which can be treated as discrete entities.
// // ignore: constant_identifier_names
// enum Gender { male, female, others }

// Gender? _selectedGender;

// class UserRegistrationForm extends StatefulWidget {
//   const UserRegistrationForm({super.key});

//   @override
//   State<UserRegistrationForm> createState() => _UserRegistrationFormState();
// }

// class _UserRegistrationFormState extends State<UserRegistrationForm> {
//   final TextEditingController _userIDController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _retypePasswordController =
//       TextEditingController();
//   @override
//   void dispose() {
//     super.dispose();
//     _userIDController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _passwordController.dispose();
//     _retypePasswordController.dispose();
//   }

//   void _createAccount() {
//     if (_selectedGender == null) {
//     // If no gender is selected, display an error message
//     setState(() {
//       ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Please select a gender'),
//       ),
//     );
//     });
//   } 
//     if (_registrationFormKey.currentState!.validate() && _selectedGender != null) {
      
//       // Form is valid, continue with account creation logic
//       setState(() {
//         ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Form has been submitted'),
//       ),
//     );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomCenter,
//           colors: [
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorWhite,
//             AppColors.divMedsColorBlue4,
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//         ),
//         body: Form(
//           key: _registrationFormKey,
//           child: Column(
//             children:
//                 // make sure all are required
//                 // username
//                 // Full Name
//                 // gender
//                 // password
//                 // confirm password

//                 [
//               const Text(
//                 "Enter your details",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               const Text(
//                 "Create an unique UserID for your DivMeds account. ",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextInputField(
//                 hintText: "Create an UserID",
//                 labelText: "UserID",
//                 labelStyle: TextStyle(
//                   color: Colors.grey[500],
//                 ),
//                 floatingLabelStyle: const TextStyle(
//                   color: AppColors.divMedsColorBlue2,
//                 ),
//                 obscureText: false,
               
//                 controller: _userIDController,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "UserID is required";
//                   }
//                   if (!usernameRegex.hasMatch(value)) {
//                     return "Invalid UserID format";
//                   }
//                   return null;
//                 },
                
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "What's your name?                                                          ",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextInputField(
//                       hintText: "Firstname",
//                       labelText: "Firstname",
//                       labelStyle: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                       floatingLabelStyle: const TextStyle(
//                         color: AppColors.divMedsColorBlue2,
//                       ),
//                       obscureText: false,
//                       controller: _firstNameController,
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "First name is required";
//                         }
//                         if (!nameRegex.hasMatch(value)) {
//                           return "Invalid first name format";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: TextInputField(
//                       hintText: "Lastname",
//                       labelText: "Lastname",
//                       labelStyle: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                       floatingLabelStyle: const TextStyle(
//                         color: AppColors.divMedsColorBlue2,
//                       ),
//                       obscureText: false,
//                       controller: _lastNameController,
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value != null &&
//                             value.isNotEmpty &&
//                             !nameRegex.hasMatch(value)) {
//                           return "Invalid last name format";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               //  alignment: const Alignment(0.79, 0),
//               const Text(
//                 "Gender                                                                               ",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 // decoration: BoxDecoration(
//                 //   color: Colors.grey[200],
//                 // ),
//                 width: 400,
//                 // padding: const EdgeInsets.only(
//                 //   left: 10,
//                 //   right: 10,
//                 //   top: 0,
//                 //   bottom: 0,
//                 // ),
//                 margin: const EdgeInsets.only(
//                   left: 25.8,
//                   right: 24.8,
//                   top: 0,
//                   bottom: 0,
//                 ),
//                 child: Row(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: RadioListTile(
//                         value: Gender.male,
//                         groupValue: _selectedGender,
//                         onChanged: (genderValue) {
//                           setState(() {
//                             _selectedGender = Gender.male;
//                           });
//                         },
//                         title: const Text("Male"),
//                         contentPadding: const EdgeInsets.all(0),
//                         toggleable: true,
//                         activeColor: AppColors.divMedsColorBlue3,
//                         tileColor: Colors.grey[200],
//                       ),
//                     ),
//                     // const SizedBox(width: 10,),
//                     Expanded(
//                       child: RadioListTile(
//                         value: Gender.female,
//                         groupValue: _selectedGender,
//                         onChanged: (genderValue) {
//                           setState(() {
//                             _selectedGender = Gender.female;
//                           });
//                         },
//                         title: const Text("Female"),
//                         contentPadding: const EdgeInsets.all(0),
//                         toggleable: true,
//                         activeColor: AppColors.divMedsColorBlue3,
//                         tileColor: Colors.grey[200],
//                       ),
//                     ),
//                     // const SizedBox(width: 10,),
//                     Expanded(
//                       child: RadioListTile(
//                         value: Gender.others,
//                         groupValue: _selectedGender,
//                         onChanged: (genderValue) {
//                           setState(
//                             () {
//                               _selectedGender = Gender.others;
//                             },
//                           );
//                         },
//                         title: const Text("Others"),
//                         contentPadding: const EdgeInsets.all(0),
//                         toggleable: true,
//                         activeColor: AppColors.divMedsColorBlue3,
//                         tileColor: Colors.grey[200],
//                         selectedTileColor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 "Create a secure password for your DivMeds account.",
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextInputField(
//                 hintText: "Create your password",
//                 labelText: "Create your password",
//                 labelStyle: TextStyle(
//                   color: Colors.grey[500],
//                 ),
//                 floatingLabelStyle: const TextStyle(
//                   color: AppColors.divMedsColorBlue2,
//                 ),
//                 obscureText: true,
//                 controller: _passwordController,
//                 keyboardType: TextInputType.visiblePassword,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Password is required";
//                   }
//                   if (!validatePassword(value)) {
//                     return "Password must be between 8 and 12 characters and contain at least one uppercase letter, one lowercase letter, one digit, and one special character";
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(
//                 height: 10,
//               ),
//               TextInputField(
//                 hintText: "Confirm your password",
//                 // labelText: "Confirm your password",
//                 label: const Text("Confirm your password"),
//                 labelStyle: TextStyle(
//                   color: Colors.grey[500],
//                 ),
//                 floatingLabelStyle: const TextStyle(
//                   color: AppColors.divMedsColorBlue2,
//                 ),
//                 obscureText: true,
//                 controller: _retypePasswordController,
//                 keyboardType: TextInputType.visiblePassword,
//                 validator: (value) {
//                   if (value!.isEmpty || value != _passwordController.text) {
//                     return "Passwords do not match";
//                   }
//                   return null;
//                 },
//               ),

//               const SizedBox(
//                 height: 20,
//               ),
//               InputButton(
//                   onPressed: () {
//                     _createAccount();
//                   },
//                   buttonName: "Submit")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
