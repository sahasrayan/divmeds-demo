import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/utils/feature_not_available_screen.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/comment.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:video_player/video_player.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:share_plus/share_plus.dart';

class SinglePostViewer extends StatefulWidget {
  final Post post;

  final User user;

  const SinglePostViewer({
    super.key,
    required this.post,

    required this.user,
  });

  @override
  _SinglePostViewerState createState() => _SinglePostViewerState();
}

class _SinglePostViewerState extends State<SinglePostViewer> {
  bool isLiked = false;

  // @override
  // void initState() {
  //   super.initState();
  //   isLiked = widget.post.likes.contains(widget.token); // Assuming the likes contain user tokens
  // }

  Future<void> _toggleLike() async {
    // bool success;
    // if (isLiked) {
    //   success = await widget.postRepository.unlikePost(widget.post.id, widget.token);
    // } else {
    //   success = await widget.postRepository.likePost(widget.post.id, widget.token);
    // }
    // if (success) {
    //   setState(() {
    //     isLiked = !isLiked;
    //   });
    // }
  }

  // Future<void> _sharePost(BuildContext context) async {
  //  final postUrl =
  //       '${widget.postRepository.serverUrl}/posts/${widget.post.id}';
  //   await Share.share('Check out this post: $postUrl');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.userSummary!.userId),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostHeader(
                // username: widget.post.userSummary!.firstName,
                 username: widget.user.userId,
            
                profileImageUrl: widget.post.userSummary!.profilePicture,
              ),
              const SizedBox(height: 16.0),
              if (widget.post.images.isNotEmpty || widget.post.videos.isNotEmpty)
                _PostContent(
                  images: widget.post.images,
                  videos: widget.post.videos,
                ),
              if (widget.post.content.isNotEmpty && widget.post.images.isEmpty && widget.post.videos.isEmpty)
                _CaptionOnly(content: widget.post.content),
              if (widget.post.content.isNotEmpty && (widget.post.images.isNotEmpty || widget.post.videos.isNotEmpty))
                Column(
                  children: [
                    // _PostCaption(username: widget.post.userSummary!.firstName, caption: widget.post.content),
                        _PostCaption(username: widget.user.userId, caption: widget.post.content),
                    const SizedBox(height: 8.0),
                  ],
                ),
              _PostActions(
                post: widget.post,
                token: "",
          
            
                isLiked: isLiked,
                toggleLike: _toggleLike,
                
              ),
              const SizedBox(height: 8.0),
              _PostLikes(likes: widget.post.likes.length),
              const SizedBox(height: 8.0),
              // _PostComments(
              //   postId: widget.post.id,
              //   token: widget.token,
              //   commentRepository: widget.commentRepository,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String username;
  final String profileImageUrl;

  const _PostHeader({required this.username, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profileImageUrl),
          radius: 20.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
      ],
    );
  }
}

class _PostContent extends StatefulWidget {
  final List<String> images;
  final List<String> videos;

  const _PostContent({required this.images, required this.videos});

  @override
  __PostContentState createState() => __PostContentState();
}

class __PostContentState extends State<_PostContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _aspectRatio = 4 / 5;

  @override
  Widget build(BuildContext context) {
    List<Widget> mediaWidgets = [];

    for (var imageUrl in widget.images) {
      mediaWidgets.add(_buildImageWidget(imageUrl));
    }
    for (var videoUrl in widget.videos) {
      mediaWidgets.add(_buildVideoWidget(videoUrl));
    }

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: mediaWidgets,
          ),
        ),
        if (mediaWidgets.length > 1)
          DotsIndicator(
            dotsCount: mediaWidgets.length,
            position: _currentPage,
            decorator: DotsDecorator(
              activeColor: Colors.blue,
            ),
          ),
      ],
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 3,
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVideoWidget(String videoUrl) {
    late VideoPlayerController _controller;
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });

    return InteractiveViewer(
      minScale: 1,
      maxScale: 3,
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: VideoPlayer(_controller),
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
      height: 300,
      child: Center(
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _PostActions extends StatelessWidget {
  final Post post;
  final String token;
 

  final bool isLiked;
  final VoidCallback toggleLike;


  const _PostActions({
    required this.post,
    required this.token,


    required this.isLiked,
    required this.toggleLike,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : null),
          onPressed: toggleLike,
        ),
        IconButton(
          icon: const Icon(Icons.comment_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => 
                // CommentScreen(
                //   postId: post.id,
                //   token: token,
                //   commentRepository: commentRepository,
                // ),
                ComingSoonScreen(
                  backGroundColor: AppColors.divMedsColorBlueScaffoldBackground,
                ),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () =>{}
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.bookmark_border),
          onPressed: () {
            ComingSoonScreen(
              backGroundColor: AppColors.divMedsColorBlueScaffoldBackground,
            );
          },
        ),
      ],
    );
  }
}

class _PostLikes extends StatelessWidget {
  final int likes;

  const _PostLikes({required this.likes});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Liked by $likes others',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _PostComments extends StatefulWidget {
  final String postId;
  final String token;
  final CommentRepository commentRepository;

  const _PostComments({required this.postId, required this.token, required this.commentRepository});

  @override
  __PostCommentsState createState() => __PostCommentsState();
}

class __PostCommentsState extends State<_PostComments> {
  late Future<List<Comment>?> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = widget.commentRepository.getPostComments(widget.postId, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>?>(
      future: _commentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading comments');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No comments yet');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: snapshot.data!.map((comment) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(comment.content),
              );
            }).toList(),
          );
        }
      },
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
