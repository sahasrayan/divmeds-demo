// import 'package:divmeds/core/api/api.url.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/repositories/user_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/verify_yourself_button.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/forms/basic_details_forms.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/forms/education_details_form.dart';
// import 'package:flutter/material.dart';



// class EditProfilePage extends StatefulWidget {
//   final String userId;
//   final String token;
//   final String serverUrl;

//   const EditProfilePage({
//     super.key,
//     required this.userId,
//     required this.token,
//     required this.serverUrl,
//   });

//   @override
//   EditProfilePageState createState() => EditProfilePageState();
// }

// class EditProfilePageState extends State<EditProfilePage> {
 
//   late UserRepository _repository;


//   @override
//   void initState() {
//     super.initState();
//     _repository = UserRepository(serverUrl: widget.serverUrl);

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
//       appBar: AppBar(title: Text('Edit Profile')),
//       body: 
//           Padding(
//               padding: EdgeInsets.all(16.0),
//               child:SingleChildScrollView(
//                 child: Column(children: [
//                      EditProfileBasicDetailsSection(token: Config.token,userRepository: _repository,),
//                   SizedBox(height: 40),
//                   EditProfileEducationalDetailsSection(token: Config.token,userRepository: _repository,),
//                      SizedBox(height: 40),
//                     VerifyYourSelfButton(),
//                 ],),
//               ),
//             ),
//     );
//   }
// }















