// import 'package:divmeds/features/auth/models/dummy_list.dart';
// import 'package:flutter/material.dart';
// import 'package:divmeds/core/api/api.url.dart';
// import 'package:divmeds/designs/app_colors.dart';
// import 'package:divmeds/features/auth/models/user.model.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/outsider_profile_section.dart';
// import 'package:divmeds/features/search/repositories/search_repo.dart';

// class ExploreScreen extends StatefulWidget {
//   final String token;
//   final String loggedInUserId;

//   const ExploreScreen({
//     super.key,
//     required this.token,
//     required this.loggedInUserId,
//   });

//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _searchController = TextEditingController();
//   List<User> _searchResults = [];
//   bool _isLoading = false;
//   bool _isArticleLoading = true; // Loading state for articles

//   final SearchRepository searchRepository = SearchRepository(serverUrl: Config.serverUrl);

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _loadArticles(); // Simulate loading articles
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadArticles() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
//     setState(() {
//       _isArticleLoading = false;
//     });
//   }

//   Future<void> _searchUsers(String query) async {
//     setState(() {
//       _isLoading = true;
//     });

//     final results = dummyUsers.where((user) {
//       final lowerQuery = query.toLowerCase();
//       return user.firstName.toLowerCase().contains(lowerQuery) ||
//           user.lastName.toLowerCase().contains(lowerQuery) ||
//           user.userId.toLowerCase().contains(lowerQuery);
//     }).toList();

//     setState(() {
//       _searchResults = results;
//       _isLoading = false;
//     });
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       height: 40,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         autocorrect: false,
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'Search for users',
//           hintStyle: TextStyle(color: Colors.grey),
//           prefixIcon: Icon(Icons.search, color: Colors.grey),
//           border: InputBorder.none,
//         ),
//         onSubmitted: (value) {
//           if (value.isNotEmpty) {
//             _searchUsers(value);
//             _tabController.animateTo(1);
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildSearchResults() {
//     if (_isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
//       return Center(child: Text('No results found', style: TextStyle(color: Colors.grey, fontSize: 18)));
//     }

//     return ListView.builder(
//       itemCount: _searchResults.length,
//       itemBuilder: (context, index) {
//         final user = _searchResults[index];
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: user.profilePicture.isNotEmpty ? NetworkImage(user.profilePicture) : null,
//             child: user.profilePicture.isEmpty ? Text(user.firstName[0].toUpperCase()) : null,
//           ),
//           title: Text('${user.firstName} ${user.lastName}'),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(user.userId),
//             ],
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ProfileSectionOutsider(
//                   userId: user.userId,
//                   loggedInUserId: widget.loggedInUserId,
//                   token: widget.token,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildArticles() {
//     if (_isArticleLoading) {
//       return Center(child: CircularProgressIndicator()); // Loading indicator
//     }

//     return ListView.builder(
//       itemCount: dummyArticles.length,
//       itemBuilder: (context, index) {
//         final article = dummyArticles[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Card(
//             color: Colors.white,
//             elevation: 4.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     article['title']!,
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     article['content']!,
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.grey[800],
//                       height: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 12.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           // Handle read more action
//                         },
//                         child: Text(
//                           'Read more',
//                           style: TextStyle(
//                             color: AppColors.divMedsColorBlue1,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: _buildSearchBar(),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.purple,
//           unselectedLabelColor: Colors.black,
//           indicatorColor: Colors.purple,
//           tabs: [
//             Tab(text: 'Articles'),
//             Tab(text: 'Users'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildArticles(),
//           _buildSearchResults(),
//         ],
//       ),
//     );
//   }
// }
