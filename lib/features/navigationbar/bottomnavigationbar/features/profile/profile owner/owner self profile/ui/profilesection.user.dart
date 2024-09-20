import 'package:divmeds/features/auth/models/dummy_list.dart';
import 'package:divmeds/features/connections/ui/connection_screen.dart';
import 'package:divmeds/features/messaging/ui/messaging_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/discussion_section.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/post_section.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/replies_section.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/settings_page.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/about_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/tab_bar.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class ProfileSectionUserOwn extends StatefulWidget {
  final User user;

  const ProfileSectionUserOwn({
    super.key,
    required this.user,
  });

  @override
  State<ProfileSectionUserOwn> createState() => _ProfileSectionUserOwnState();
}

class _ProfileSectionUserOwnState extends State<ProfileSectionUserOwn> {
  late Future<List<Post>?> _userProfilePosts;
  final UserRepository _userRepository = UserRepository(serverUrl: Config.serverUrl);
  final AuthRepository _authRepository = AuthRepository(serverUrl: Config.serverUrl);
  final PostRepository _postRepository = PostRepository(serverUrl: Config.serverUrl);
  final CommentRepository _commentRepository = CommentRepository(serverUrl: Config.serverUrl);

  String? _aboutSection;

  @override
  void initState() {
    super.initState();
    _initializeUserProfilePosts();
    _fetchAboutSection();
  }

  void _initializeUserProfilePosts() {
    final token = SharedPreferencesManager.getToken();
    if (token != null && token.isNotEmpty) {
      setState(() {
        _userProfilePosts = _postRepository.getUserPosts(token);
      });
    } else {
      _userProfilePosts = Future.value(null);
    }
  }

  void _fetchAboutSection() async {
    final token = SharedPreferencesManager.getToken();
    if (token != null && token.isNotEmpty) {
      final aboutSection = await getAboutSection(token);
      setState(() {
        _aboutSection = aboutSection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      appBar: AppBar(
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.user.userId,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                final token = SharedPreferencesManager.getToken();
                if (token != null && token.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(
                        authRepository: _authRepository,
                        token: token,
                        userRepository: _userRepository,
                      ),
                    ),
                  );
                } else {
                  _showSnackBar('User not authenticated');
                }
              },
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget.user.profilePicture),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          widget.user.firstName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          _aboutSection ?? "Hey, I'm on DivMeds",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.people_alt,),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnectionListScreen(serverUrl: Config.serverUrl, token: Config.token, loggedInUserId: widget.user.userId, userId: widget.user.userId,),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessagingScreen(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,),
                            onPressed: () {
                              final token = SharedPreferencesManager.getToken();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                    user: widget.user,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const CustomTabBar(),
            ];
          },
          body: TabBarView(
            children: [
              AboutScreen(
                user: widget.user,
              ),
              FutureBuilder<List<Post>?>(
                future: getDummyPosts(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (postSnapshot.hasError) {
                    return Center(child: Text('Error: ${postSnapshot.error}'));
                  } else if (postSnapshot.hasData) {
                    final posts = postSnapshot.data!;
                    return PostSection(
                      posts: posts,
                      token: Config.token,
                      commentRepository: _commentRepository,
                      postRepository: _postRepository,
                      user: widget.user,
                    );
                  } else {
                    return const Center(child: Text('No posts available'));
                  }
                },
              ),
              const DiscussionSection(),
              const RepliesSection(),
            ],
          ),
        ),
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

  Future<String?> getAboutSection(String token) async {
    try {
      final response = await Dio().get(
        '${Config.serverUrl}/me/about',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('About section fetched successfully');
        return response.data['aboutSection'];
      } else {
        throw Exception('Failed to get about section');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get about section');
    }
  }
}






// import 'package:flutter/material.dart';
// import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
// import 'package:divmeds/core/api/api.url.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/auth/repositories/auth_repo.dart';
// import 'package:divmeds/features/auth/repositories/user_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/profile_header.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/tab_bar.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/discussion_section.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/post_section.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/settings_page.dart';

// class ProfileSectionUserOwn extends StatefulWidget {
//   final User user;

//   const ProfileSectionUserOwn({
//     super.key,
//     required this.user,
//   });

//   @override
//   State<ProfileSectionUserOwn> createState() => _ProfileSectionUserOwnState();
// }

// class _ProfileSectionUserOwnState extends State<ProfileSectionUserOwn> {
//   late Future<List<Post>?> _userProfilePosts;
//   final UserRepository _userRepository = UserRepository(serverUrl: Config.serverUrl);
//   final AuthRepository _authRepository = AuthRepository(serverUrl: Config.serverUrl);
//   final PostRepository _postRepository = PostRepository(serverUrl: Config.serverUrl);
//   final CommentRepository _commentRepository = CommentRepository(serverUrl: Config.serverUrl);

//   @override
//   void initState() {
//     super.initState();
//     _initializeUserProfilePosts();
//   }

//   void _initializeUserProfilePosts() {
//   final token = SharedPreferencesManager.getToken();
//   if (token != null && token.isNotEmpty) {
//     setState(() {
//       _userProfilePosts = _postRepository.getUserPosts(token);
//     });
//   } else {
//     _userProfilePosts = Future.value(null);
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
//       appBar: AppBar(
        
//         backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
//         title: Padding(
          
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             widget.user.userId,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         centerTitle: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 final token = SharedPreferencesManager.getToken();
//                 if (token != null && token.isNotEmpty) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SettingsPage(
//                         authRepository: _authRepository,
//                         token: token,
//                         userRepository: _userRepository,
//                       ),
//                     ),
//                   );
//                 } else {
//                   _showSnackBar('User not authenticated');
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       body: DefaultTabController(
//         length: 2,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return [
//               ProfileHeader(user: widget.user),
//               const CustomTabBar(),
//             ];
//           },
//           body: TabBarView(
//             children: [
//               FutureBuilder<List<Post>?>(
//                 future: _userProfilePosts,
//                 builder: (context, postSnapshot) {
//                   if (postSnapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (postSnapshot.hasError) {
//                     return Center(child: Text('Error: ${postSnapshot.error}'));
//                   } else if (postSnapshot.hasData) {
//                     final posts = postSnapshot.data!;
//                     return PostSection(
//                       posts: posts,
//                       token: Config.token,
//                       commentRepository: _commentRepository,
//                       postRepository: _postRepository,
//                       user: widget.user,
//                     );
//                   } else {
//                     return const Center(child: Text('No posts available'));
//                   }
//                 },
//               ),
//               const DiscussionSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
// }

