import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/user_summary.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/components/connection_button.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/connections/ui/connection_screen.dart';
import 'package:divmeds/features/messaging/ui/messaging_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/discussion_section_outsider.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/post_section.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/replies_section_outsider.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/widgets/about_screen_outsider.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/silver_app_bar_delegate.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';

class ProfileSectionOutsider extends StatefulWidget {
  final String userId;
  final String loggedInUserId;
  final String token;

  const ProfileSectionOutsider({
    super.key,
    required this.userId,
    required this.loggedInUserId,
    required this.token,
  });

  @override
  State<ProfileSectionOutsider> createState() => _ProfileSectionOutsiderState();
}

class _ProfileSectionOutsiderState extends State<ProfileSectionOutsider>
    with TickerProviderStateMixin {
  late Future<User?> _userProfile;
  late Future<List<Post>?> _userProfilePosts;
  late Future<String> _initialConnectionStatus;
  final PostRepository _postRepository =
      PostRepository(serverUrl: 'https://dummyurl.com');
  final CommentRepository _commentRepository =
      CommentRepository(serverUrl: 'https://dummyurl.com');
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeUserProfile();
    _initializeUserProfilePosts();
    _initialConnectionStatus = _fetchInitialConnectionStatus();
  }

  void _initializeUserProfile() {
    setState(() {
      _userProfile = Future.value(
        User(
          id: 'divmeds.user.111',
          userId: widget.userId,
          firstName: 'Dr. Dummy',
          lastName: 'Profile',
          profilePicture: 'https://via.placeholder.com/150',
          aboutSection: "I'm using DivMeds!",
          password: '',
          phone: '',
          dob: '',
          gender: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    });
  }

  void _initializeUserProfilePosts() {
    setState(() {
      _userProfilePosts = Future.value([
        Post(
          id: 'post123',
          userSummary: UserSummary(
            id: 'user123',
            userId: widget.userId,
            profilePicture: 'https://via.placeholder.com/150', firstName: '', lastName: '',
          ),
          content: 'This is a dummy post content for testing.',
          images: ['https://via.placeholder.com/300'],
          videos: [],
          likes: ['token1', 'token2'],
          comments: ['comment1', 'comment2'], type: '', links: [], privacy: '', tags: [], updatedAt: DateTime.now(), createdAt:DateTime.now(),
        ),
      ]);
    });
  }

  Future<String> _fetchInitialConnectionStatus() async {
    // Mocking connection status as 'none'
    return Future.value('none');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.userId,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder<User?>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final searchedUser = snapshot.data!;
            return DefaultTabController(
              length: 4,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(searchedUser.profilePicture),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              searchedUser.firstName + ' ' + searchedUser.lastName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              searchedUser.aboutSection ?? "Hey, I'm on DivMeds",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.people_alt),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConnectionListScreen(
                                        serverUrl: 'https://dummyurl.com',
                                        token: widget.token,
                                        loggedInUserId: widget.userId,
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessagingScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (widget.userId != widget.loggedInUserId)
                      SliverToBoxAdapter(
                        child: FutureBuilder<String>(
                          future: _initialConnectionStatus,
                          builder: (context, statusSnapshot) {
                            if (statusSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (statusSnapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${statusSnapshot.error}'));
                            } else if (statusSnapshot.hasData) {
                              return ConnectionButton(
                                userId: searchedUser.userId,
                                loggedInUserId: widget.loggedInUserId,
                                token: widget.token,
                                initialStatus: statusSnapshot.data!,
                              );
                            } else {
                              return const Center(
                                  child: Text('Failed to load connection status'));
                            }
                          },
                        ),
                      ),
                    SliverPersistentHeader(
                      delegate: CustomSliverAppBarDelegate(
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(text: 'About'),
                            Tab(text: 'Posts'),
                            Tab(text: 'Discussions'),
                            Tab(text: 'Replies'),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    FutureBuilder<User?>(
                      future: _userProfile,
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (userSnapshot.hasError) {
                          return Center(child: Text('Error: ${userSnapshot.error}'));
                        } else if (userSnapshot.hasData) {
                          final searchedUser = userSnapshot.data!;
                          return AboutScreenOutsider(user: searchedUser);
                        } else {
                          return const Center(child: Text('User not found'));
                        }
                      },
                    ),
                    FutureBuilder<List<Post>?>(
                      future: _userProfilePosts,
                      builder: (context, postSnapshot) {
                        if (postSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (postSnapshot.hasError) {
                          return Center(child: Text('Error: ${postSnapshot.error}'));
                        } else if (postSnapshot.hasData) {
                          final posts = postSnapshot.data!;
                          return OutsiderPostSection(
                            posts: posts,
                            token: widget.token,
                            commentRepository: _commentRepository,
                            postRepository: _postRepository,
                            user: searchedUser,
                          );
                        } else {
                          return const Center(child: Text('No posts available'));
                        }
                      },
                    ),
                    const OutsiderDiscussionSection(),
                    const OutsiderRepliesSection(),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}



// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/components/connection_button.dart';
// import 'package:flutter/material.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/widgets/about_screen_outsider.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';

// class ProfileSectionOutsider extends StatelessWidget {
//   final String userId;
//   final String loggedInUserId;
//   final String token;

//   const ProfileSectionOutsider({
//     super.key,
//     required this.userId,
//     required this.loggedInUserId,
//     required this.token,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Dummy user data
//     final dummyUser = User(
//       id: 'divmeds.user.111',
//       userId: userId,
//       firstName: 'John',
//       lastName: 'Doe',
//       profilePicture: 'https://via.placeholder.com/150',
//       aboutSection: "I'm a healthcare professional.", password: '', phone: '', dob: '', gender: '', createdAt: DateTime.now(), updatedAt: DateTime.now(),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(dummyUser.firstName + ' ' + dummyUser.lastName),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(dummyUser.profilePicture),
//             ),
//             SizedBox(height: 10),
//             Text(
//               dummyUser.firstName + ' ' + dummyUser.lastName,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               dummyUser.aboutSection ?? "No bio available",
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ConnectionButton(
//               userId: userId,
//               loggedInUserId: loggedInUserId,
//               token: token,
//               initialStatus: 'none', // Change this according to your logic
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:divmeds/features/auth/repositories/user_repo.dart';
// import 'package:divmeds/features/connections/repositories/connection_repo.dart';
// import 'package:divmeds/features/connections/ui/connection_screen.dart';
// import 'package:divmeds/features/messaging/ui/messaging_screen.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/components/connection_button.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/discussion_section_outsider.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/post_section.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/sections/replies_section_outsider.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/widgets/about_screen_outsider.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/silver_app_bar_delegate.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/discussion_section.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/sections/replies_section.dart';
// import 'package:flutter/material.dart';
// import 'package:divmeds/core/api/api.url.dart';
// import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/about_screen.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/tab_bar.dart';
// import 'package:dio/dio.dart';
// import 'dart:developer';

// class ProfileSectionOutsider extends StatefulWidget {
//   final String userId;
//   final String loggedInUserId;
//   final String token;

//   const ProfileSectionOutsider({
//     super.key,
//     required this.userId,
//     required this.loggedInUserId,
//     required this.token,
//   });

//   @override
//   State<ProfileSectionOutsider> createState() => _ProfileSectionOutsiderState();
// }

// class _ProfileSectionOutsiderState extends State<ProfileSectionOutsider>
//     with TickerProviderStateMixin {
//   late Future<User?> _userProfile;
//   late Future<List<Post>?> _userProfilePosts;
//   late Future<String> _initialConnectionStatus;
//   final PostRepository _postRepository =
//       PostRepository(serverUrl: Config.serverUrl);
//   final CommentRepository _commentRepository =
//       CommentRepository(serverUrl: Config.serverUrl);
//   final UserRepository _userRepository =
//       UserRepository(serverUrl: Config.serverUrl);
//   late TabController _tabController;
//   final ConnectionRepository _connectionRepository = ConnectionRepository(serverUrl: Config.serverUrl);

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     _initializeUserProfile();
//     _initializeUserProfilePosts();
//     _initialConnectionStatus = _fetchInitialConnectionStatus();
//   }

//   void _initializeUserProfile() {
//     setState(() {
//       _userProfile = getUserProfile(widget.userId, widget.token);
//     });
//   }

//   void _initializeUserProfilePosts() {
//     setState(() {
//       _userProfilePosts = _postRepository.getUserPosts(widget.token);
//     });
//   }

//   Future<User?> getUserProfile(String userId, String token) async {
//     try {
//       final response = await Dio().get(
//         '${Config.serverUrl}/$userId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       if (response.statusCode! >= 200 && response.statusCode! <= 300) {
//         log(response.data.toString());
//         User user = User.fromJson(response.data);
//         return user;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }

//   Future<String> _fetchInitialConnectionStatus() async {
  
//       return await _connectionRepository.getConnectionStatus(
//         widget.userId, widget.loggedInUserId, widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
//         title: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             widget.userId,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       body: FutureBuilder<User?>(
//         future: _userProfile,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final searchedUser = snapshot.data!;
//             return DefaultTabController(
//               length: 4,
//               child: NestedScrollView(
//                 headerSliverBuilder:
//                     (BuildContext context, bool innerBoxIsScrolled) {
//                   return [
//                     SliverToBoxAdapter(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: CircleAvatar(
//                               radius: 50,
//                               backgroundImage:
//                                   NetworkImage(searchedUser.profilePicture),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Center(
//                             child: Text(
//                               searchedUser.firstName,
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
                        
//                           Center(
//                             child: Text(
//                               searchedUser.aboutSection ?? "Hey, I'm on DivMeds",
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.people_alt,),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ConnectionListScreen(serverUrl: Config.serverUrl, token: Config.token,
//                                    loggedInUserId: widget.userId, userId: widget.userId,),
//                                 ),
//                               );
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.message),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MessagingScreen(),
//                                 ),
//                               );
//                             },
//                           ),
                          
//                         ],
//                       ),
//                         ],
//                       ),
//                     ),
//                     if (widget.userId != widget.loggedInUserId)
//                       SliverToBoxAdapter(
//                         child: FutureBuilder<String>(
//                           future: _initialConnectionStatus,
//                           builder: (context, statusSnapshot) {
//                             if (statusSnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                   child: CircularProgressIndicator());
//                             } else if (statusSnapshot.hasError) {
//                               return Center(
//                                   child:
//                                       Text('Error: ${statusSnapshot.error}'));
//                             } else if (statusSnapshot.hasData) {
//                               return ConnectionButton(
//                                 userId: searchedUser.userId,
//                                 loggedInUserId: widget.loggedInUserId,
//                                 token: widget.token,
//                                 initialStatus: statusSnapshot.data!,
//                               );
//                             } else {
//                               return const Center(
//                                   child: Text('Failed to load connection status'));
//                             }
//                           },
//                         ),
//                       ),
//                     SliverPersistentHeader(
//                       delegate: CustomSliverAppBarDelegate(
//                         TabBar(
//                           controller: _tabController,
//                           labelColor: Colors.black,
//                           unselectedLabelColor: Colors.grey,
//                           tabs: [
//                             Tab(text: 'About'),
//                             Tab(text: 'Posts'),
//                             Tab(text: 'Discussions'),
//                             Tab(text: 'Replies'),
//                           ],
//                         ),
//                       ),
//                       pinned: true,
//                     ),
//                   ];
//                 },
//                 body: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     FutureBuilder<User?>(
//                       future: _userProfile,
//                       builder: (context, userSnapshot) {
//                         if (userSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(child: CircularProgressIndicator());
//                         } else if (userSnapshot.hasError) {
//                           return Center(child: Text('Error: ${userSnapshot.error}'));
//                         } else if (userSnapshot.hasData) {
//                           final searchedUser = userSnapshot.data!;
//                           return AboutScreenOutsider(user: searchedUser);
//                         } else {
//                           return const Center(child: Text('User not found'));
//                         }
//                       },
//                     ),
//                     FutureBuilder<List<Post>?>(
//                       future: _userProfilePosts,
//                       builder: (context, postSnapshot) {
//                         if (postSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(child: CircularProgressIndicator());
//                         } else if (postSnapshot.hasError) {
//                           return Center(child: Text('Error: ${postSnapshot.error}'));
//                         } else if (postSnapshot.hasData) {
//                           final posts = postSnapshot.data!;
//                           return OutsiderPostSection(
//                             posts: posts,
//                             token: widget.token,
//                             commentRepository: _commentRepository,
//                             postRepository: _postRepository,
//                             user: searchedUser,
//                           );
//                         } else {
//                           return const Center(child: Text('No posts available'));
//                         }
//                       },
//                     ),
//                     const OutsiderDiscussionSection(),
//                     const  OutsiderRepliesSection(),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return const Center(child: Text('No data available'));
//         },
//       ),
//     );
//   }
// }






