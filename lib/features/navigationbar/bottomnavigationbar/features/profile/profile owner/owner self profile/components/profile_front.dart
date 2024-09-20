// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/edit_user_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/auth/repositories/user_repo.dart';
// import 'package:divmeds/core/api/api.url.dart';
// import 'edit_profile_picture.dart';
// import 'package:divmeds/features/connections/ui/connection_screen.dart';
// import 'package:divmeds/utils/feature_not_available_screen.dart';

// class ProfileFront extends StatefulWidget {
//   final User user;
//     final String token;
//   final UserRepository userRepository;

//   const ProfileFront({
//     super.key,
//     required this.user,
//     required this.token, required this.userRepository
//   });

//   @override
//   _ProfileFrontState createState() => _ProfileFrontState();
// }

// class _ProfileFrontState extends State<ProfileFront> {
//   late String _profilePicture;
//   late Future<List<Education>?> _educationFuture;

//   @override
//   void initState() {
//     super.initState();
//     _profilePicture = widget.user.profilePicture.isNotEmpty
//         ? widget.user.profilePicture
//         : "https://via.placeholder.com/150"; // Default blank profile picture URL
//     _educationFuture = _fetchUserEducation();
//   }

//   Future<List<Education>?> _fetchUserEducation() async {
//     final userRepository = UserRepository(serverUrl: Config.serverUrl);
//     try {
//       List<Education>? educationList = await userRepository.getUserEducation(Config.token);
//       if (educationList != null && educationList.isNotEmpty) {
//         print("Education data fetched successfully: $educationList");
//       } else {
//         print("Education data is null or empty");
//       }
//       return educationList;
//     } catch (error) {
//       print("Error fetching education data: $error");
//       return null;
//     }
//   }

//   void _updateProfilePicture(String newImageUrl) {
//     setState(() {
//       _profilePicture = newImageUrl;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       color: Colors.white,
//       elevation: 5,
//       child: Stack(
//         children: [
//           Container(
//             width: 350,
//             height: 350,
//             padding: EdgeInsets.all(20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundImage: NetworkImage(_profilePicture),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => EditProfilePicture(
//                                   onUpdateProfilePicture: _updateProfilePicture,
//                                   userRepository: UserRepository(serverUrl: Config.serverUrl),
//                                   token: Config.token,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 15,
//                             backgroundColor: Colors.blue,
//                             child: Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Center(
//                   child: Text(
//                     '${widget.user.firstName} ${widget.user.lastName}',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                FutureBuilder<List<Education>?>(
//                   future: _educationFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       print("Error in FutureBuilder: ${snapshot.error}");
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       print("No Education Information available");
//                       return Center(child: Text('No Education Information'));
//                     } else {
//                       final education = snapshot.data!;
//                       print("Displaying Education Information: $education");
//                       return Column(
//                         children: education.map((edu) {
//                           return Column(
//                             children: [
//                               Text(
//                                 edu.institution,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     edu.degree,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   Text(
//                                     edu.currentYear,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       );
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ConnectionListScreen(
//                                   serverUrl: Config.serverUrl,
//                                   token: Config.token,
//                                   loggedInUserId: widget.user.userId,
//                                   userId: widget.user.userId,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             '${widget.user.connections.length}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ComingSoonScreen(
//                                   backGroundColor: AppColors.divMedsColorBlueScaffoldBackground,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             '0', // Replace with actual score
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 10,
//             child: IconButton(
//               icon: Icon(Icons.edit),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => EditProfilePage(
//                       userId: widget.user.userId,
//                       token: Config.token,
//                       serverUrl: Config.serverUrl,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
