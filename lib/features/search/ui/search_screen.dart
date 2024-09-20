import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/outsider_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/search/repositories/search_repo.dart';
import 'package:divmeds/designs/app_colors.dart';

class SearchScreen extends StatefulWidget {
  final String token;
  final String loggedInUserId;

  const SearchScreen({super.key, required this.token, required this.loggedInUserId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];
  bool _isLoading = false;
  final SearchRepository searchRepository = SearchRepository(serverUrl: Config.serverUrl);
    late User lookingForSearchedUser;
  Future<void> _searchUsers(String query) async {
    setState(() {
      _isLoading = true;
    });

    final results = await searchRepository.searchUsers(query, widget.token);

    setState(() {
      _searchResults = results ?? [];
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      appBar: AppBar(
        title: _buildSearchBar(),
        backgroundColor: AppColors.divMedsColorBlueScaffoldBackground,
      ),
      body: _buildSearchResults(),
    );
  }

  // SearchBar Widget
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        autocorrect: false,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey[600]),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _searchUsers(value);
          }
        },
      ),
    );
  }

  // Search Results
  Widget _buildSearchResults() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: user.profilePicture.isNotEmpty
                ? NetworkImage(user.profilePicture)
                : null,
            child: user.profilePicture.isEmpty
                ? Text(user.firstName[0].toUpperCase())
                : null,
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.userId),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileSectionOutsider(
                  userId: user.userId,
                  loggedInUserId: widget.loggedInUserId,
                  token: widget.token,
               
                ),
              ),
            );
          },
        );
      },
    );
  }
}
