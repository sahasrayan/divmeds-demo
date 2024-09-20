import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/ui/tools/tools_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/home/components/post_card.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/user_summary.model.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/dummy_list.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/ui/articles/news_and_articles_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/search/repositories/search_repo.dart';

class ExploreScreen extends StatefulWidget {
  final String token;
  final String loggedInUserId;

  const ExploreScreen({
    super.key,
    required this.token,
    required this.loggedInUserId,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];
  List<Post> posts = [];
  bool isLoading = true;
  bool _isArticleLoading = true; // Loading state for articles

  final SearchRepository searchRepository = SearchRepository(serverUrl: Config.serverUrl);
  final PostRepository postRepository = PostRepository(serverUrl: Config.serverUrl);
  final CommentRepository commentRepository = CommentRepository(serverUrl: Config.serverUrl);

  @override
  void initState() {
    super.initState();
    _loadArticles(); // Simulate loading articles
    _loadPosts(); // Load posts
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a network delay
    if (!mounted) return; // Avoid calling setState if widget is no longer mounted
    setState(() {
      _isArticleLoading = false;
    });
  }

  void _loadPosts() {
    // Simulating loading of posts
    posts = List.generate(10, (index) {
      return Post(
        id: '$index',
        userSummary: UserSummary(
          id: 'divmeds_$index',
          userId: 'divmeds_$index',
          firstName: 'User',
          lastName: 'Number$index',
          profilePicture: 'assets/images/healthcare_worker_${index % 5}.jpg', // Asset path
        ),
        type: 'basic',
        content: 'Healthcare post content number $index',
        images: [
          'assets/images/healthcare_worker_${index % 5}.jpg', // Asset path
        ],
        videos: [],
        links: [],
        privacy: 'public',
        likes: [],
        comments: [],
        sharedPost: null,
        tags: ['healthcare', 'medical'],
        poll: null,
        doubt: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _searchUsers(String query) async {
    setState(() {
      // _isLoading = true;
    });

    final results = dummyUsers.where((user) {
      final lowerQuery = query.toLowerCase();
      return user.firstName.toLowerCase().contains(lowerQuery) ||
          user.lastName.toLowerCase().contains(lowerQuery) ||
          user.userId.toLowerCase().contains(lowerQuery);
    }).toList();

    if (!mounted) return; // Avoid calling setState if widget is no longer mounted
    setState(() {
      _searchResults = results;
      // _isLoading = false;
    });
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        autocorrect: false,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for users,articles,medicines...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _searchUsers(value);
          }
        },
      ),
    );
  }

  Widget _buildBoxContainer({required String title1, required IconData icon, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        width: MediaQuery.of(context).size.width * 0.42, // Adjust the width of each container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: AppColors.divMedsColorBlue1),
            const SizedBox(width: 8),
            Expanded( // Use Expanded to prevent overflow
              child: Column(
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRandomFeed() {
    if (_isArticleLoading && isLoading) {
      return Center(child: CircularProgressIndicator()); // Loading indicator
    }

    final List<dynamic> combinedFeed = [...dummyArticles, ...posts];

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = combinedFeed[index];
          if (item is Map<String, String>) {
            // Render article
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        item['content']!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle read more action
                            },
                            child: Text(
                              'Read more',
                              style: TextStyle(
                                color: AppColors.divMedsColorBlue1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (item is Post) {
            // Render post using PostCard
            return PostCard(
              post: item,
              postRepository: postRepository,
              token: widget.token,
              commentRepository: commentRepository,
            );
          }
          return SizedBox.shrink(); // Fallback in case of unexpected type
        },
        childCount: combinedFeed.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            title: _buildSearchBar(),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBoxContainer(
                    title1: 'Articles',
                    icon: Icons.article,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleListScreen(articles: dummyArticles),
                        ),
                      );
                    },
                  ),
                  _buildBoxContainer(
                    title1: 'Med Tools',
                    icon: Icons.medical_services,
                    onTap: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedToolsScreen(token: Config.token, loggedInUserId: '',),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildRandomFeed(),
        ],
      ),
    );
  }
}
