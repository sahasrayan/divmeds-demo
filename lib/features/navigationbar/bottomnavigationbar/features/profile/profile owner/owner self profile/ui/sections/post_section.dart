import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:flutter/material.dart';

import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/single_post_viewer.dart';

class PostSection extends StatefulWidget {
  final List<Post> posts;
  final String token;
  final CommentRepository commentRepository;
  final PostRepository postRepository;
  final User user;

  const PostSection({
    super.key,
    required this.posts,
    required this.token,
    required this.commentRepository,
    required this.postRepository,
    required this.user,
  });

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  child: const Icon(Icons.collections, color: Colors.white),
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

  Widget _buildTextPreview(String content) {
    return Center(
      child: Text(
        content,
        style: const TextStyle(color: Colors.black),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}



