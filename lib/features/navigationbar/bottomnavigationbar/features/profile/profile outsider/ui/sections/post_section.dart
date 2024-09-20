import 'package:flutter/material.dart';

import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/single_post_viewer.dart';

class OutsiderPostSection extends StatefulWidget {
final List<Post> posts;
  final String token;
  final CommentRepository commentRepository;
  final PostRepository postRepository;
  final User user;
  const OutsiderPostSection({
    super.key,
    required this.posts,
    required this.token,
    required this.user,
    required this.commentRepository,
    required this.postRepository,
  });

  @override
  State<OutsiderPostSection> createState() => _OutsiderPostSectionState();
}

class _OutsiderPostSectionState extends State<OutsiderPostSection> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        final post = widget.posts[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SinglePostViewer(
            //       post: post,
              
            //       user: widget.user,
            //     ),
            //   ),
            // );
          },
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: post.images.isNotEmpty
                    ? _buildMediaPreview(post.images.first)
                    : _buildTextPreview(post.content),
              ),
              if (post.images.length > 1)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Icon(Icons.collections, color: Colors.white),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMediaPreview(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTextPreview(String caption) {
    return Center(
      child: Text(
        caption,
        style: TextStyle(fontSize: 16, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
