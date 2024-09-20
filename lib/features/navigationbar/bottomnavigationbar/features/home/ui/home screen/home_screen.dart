
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/user_summary.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/ui/post_button.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/jobs/ui/jobs_home_screen.dart';
import 'package:divmeds/features/messaging/ui/messaging_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/home/components/post_card.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/home/repositories/feed_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/notifications/ui/notification_screen.dart';
import 'package:divmeds/features/search/ui/search_screen.dart';
import 'package:divmeds/utils/logo%20widgets/blue_logo_widget.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({
    super.key,
    required this.user,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final FeedRepository feedRepository = FeedRepository(serverUrl: Config.serverUrl);
  final PostRepository postRepository = PostRepository(serverUrl: Config.serverUrl);
  final CommentRepository commentRepository = CommentRepository(serverUrl: Config.serverUrl);

  List<Post> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    // Simulating fetching of posts with dummy data
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    setState(() {
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Center(child: BlueLogoWidget()),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add_box),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostButtonScreen(userId: widget.user.userId,
                           userProfileImage: widget.user.profilePicture,
                           token: Config.token, user: widget.user),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 8, 0),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(token: Config.token, serverUrl: Config.serverUrl,
                          user: widget.user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 8, 0),
                child: Center(
                  child: IconButton(
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
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (posts.isEmpty) {
                  return Center(child: Text('No posts available.'));
                } else {
                  final post = posts[index];
                  return PostCard(
                    post: post,
                    postRepository: postRepository,
                    token: Config.token,
                    commentRepository: commentRepository,
                  );
                }
              },
              childCount: isLoading ? 1 : posts.length,
            ),
          ),
        ],
      ),
    );
  }
}

