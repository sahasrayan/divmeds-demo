import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/ui/outsider_profile_section.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final String token;
  final CommentRepository commentRepository;
  final PostRepository postRepository;

  const PostCard({
    super.key,
    required this.post,
    required this.token,
    required this.commentRepository,
    required this.postRepository,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.likes.contains(widget.token);
  }

  void _toggleLike() async {
    // Implementation for like/unlike functionality
  }

  void _sharePost() async {
    final postUrl =
        '${widget.postRepository.serverUrl}/posts/${widget.post.id}';
    await Share.share('Check out this post: $postUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostHeader(
            username: widget.post.userSummary!.userId,
            userId: widget.post.userSummary!.userId,
            profileImageUrl: widget.post.userSummary!.profilePicture,
            summaryId: widget.post.userSummary!.id,
            token: widget.token,
            postRepository: widget.postRepository,
            commentRepository: widget.commentRepository,
            userRepository: UserRepository(serverUrl: Config.serverUrl),
          ),
          const SizedBox(height: 8.0),
          if (widget.post.images.isNotEmpty || widget.post.videos.isNotEmpty)
            _PostContent(
              images: widget.post.images,
              videos: widget.post.videos,
            ),
          if (widget.post.content.isNotEmpty &&
              widget.post.images.isEmpty &&
              widget.post.videos.isEmpty)
            _CaptionOnly(content: widget.post.content),
          if (widget.post.content.isNotEmpty &&
              (widget.post.images.isNotEmpty || widget.post.videos.isNotEmpty))
            _PostCaption(
                username: widget.post.userSummary!.userId,
                caption: widget.post.content),
          const SizedBox(height: 8.0),
          _PostActions(
            post: widget.post,
            token: widget.token,
            commentRepository: widget.commentRepository,
            isLiked: isLiked,
            onLikeToggle: _toggleLike,
            onShare: _sharePost,
          ),
          const SizedBox(height: 8.0),
          _PostLikes(likes: widget.post.likes),
          const SizedBox(height: 8.0),
          _PostComments(comments: widget.post.comments),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String username;
  final String userId;
  final String profileImageUrl;
  final String summaryId;
  final String token;
  final PostRepository postRepository;
  final CommentRepository commentRepository;
  final UserRepository userRepository;

  const _PostHeader({
    required this.username,
    required this.profileImageUrl,
    required this.summaryId,
    required this.token,
    required this.postRepository,
    required this.commentRepository,
    required this.userRepository,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    String role = _getUserRole();

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: profileImageUrl.isNotEmpty
              ? AssetImage(profileImageUrl)
              : const AssetImage('assets/images/default_avatar.png'),
          radius: 22.0,
        ),
        const SizedBox(width: 8.0),
        GestureDetector(
          onTap: () {
            navigateToOutsiderUserProfile(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // More options functionality
          },
        ),
      ],
    );
  }

  String _getUserRole() {
    if (userId.contains("doc")) {
      return "General Physician";
    } else if (userId.contains("nurse")) {
      return "Nurse";
    } else {
      return "Healthcare Professional";
    }
  }

  void navigateToOutsiderUserProfile(BuildContext context) {
    final String userIdfromPost = userId;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSectionOutsider(
          userId: userIdfromPost,
          token: token,
          loggedInUserId: SharedPreferencesManager.getUid(),
        ),
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final List<String> images;
  final List<String> videos;

  const _PostContent({required this.images, required this.videos});

  @override
  Widget build(BuildContext context) {
    List<Widget> mediaWidgets = [];

    for (var imageUrl in images) {
      mediaWidgets.add(_buildImageWidget(imageUrl));
    }

    for (var videoUrl in videos) {
      mediaWidgets.add(_buildVideoWidget(videoUrl));
    }

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView(
            children: mediaWidgets,
          ),
        ),
        if (mediaWidgets.length > 1)
          DotsIndicator(
            dotsCount: mediaWidgets.length,
            decorator: const DotsDecorator(
              activeColor: Colors.blue,
              size: Size(6.0, 6.0),
              activeSize: Size(8.0, 8.0),
              spacing: EdgeInsets.all(4.0),
            ),
          ),
      ],
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVideoWidget(String videoUrl) {
    // Handle video widget construction here
    return Container(
      height: 200,
      color: Colors.black,
      child: Center(
        child: Text(
          'Video Placeholder',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _PostCaption extends StatelessWidget {
  final String username;
  final String caption;

  const _PostCaption({required this.username, required this.caption});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: '$username ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: caption,
          ),
        ],
      ),
    );
  }
}

class _CaptionOnly extends StatelessWidget {
  final String content;

  const _CaptionOnly({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  final Post post;
  final String token;
  final CommentRepository commentRepository;
  final bool isLiked;
  final VoidCallback onLikeToggle;
  final VoidCallback onShare;

  const _PostActions({
    required this.post,
    required this.token,
    required this.commentRepository,
    required this.isLiked,
    required this.onLikeToggle,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            color: isLiked ? Colors.blue : Colors.grey,
          ),
          onPressed: onLikeToggle,
        ),
        IconButton(
          icon: const Icon(Icons.comment_outlined),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Will be implemented!')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: onShare,
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Will be implemented!')),
            );
          },
        ),
      ],
    );
  }
}

class _PostLikes extends StatelessWidget {
  final List<String> likes;

  const _PostLikes({required this.likes});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${likes.length} ${likes.length == 1 ? 'like' : 'likes'}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );
  }
}

class _PostComments extends StatelessWidget {
  final List<String> comments;

  const _PostComments({required this.comments});

  @override
  Widget build(BuildContext context) {
    return Text(
      'View all ${comments.length} comments',
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}


