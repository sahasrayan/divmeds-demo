import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'post_review_screen.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/components/image_grid.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/components/media_picker.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/post_repo.dart';
import 'package:divmeds/designs/app_colors.dart';

class PostButtonScreen extends StatelessWidget {
  final String userId;
  final String userProfileImage;
  final String token;
  final User user;

  const PostButtonScreen({
    required this.userId,
    required this.userProfileImage,
    required this.token,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: PostButtonScreenContent(
        userId: userId,
        userProfileImage: userProfileImage,
        token: token,
        user: user,
      ),
    );
  }
}

class PostButtonScreenContent extends StatefulWidget {
  final String userId;
  final String userProfileImage;
  final String token;
  final User user;

  const PostButtonScreenContent({
    required this.userId,
    required this.userProfileImage,
    required this.token,
    required this.user,
    super.key,
  });

  @override
  _PostButtonScreenContentState createState() => _PostButtonScreenContentState();
}

class _PostButtonScreenContentState extends State<PostButtonScreenContent> {
  final PostRepository _postRepository = PostRepository(serverUrl: Config.serverUrl);

  Future<void> _pickImage(PostProvider provider) async {
    if (provider.images.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only upload up to 3 images.')),
      );
      return;
    }
    final List<XFile>? pickedImages = await provider.picker.pickMultiImage();
    if (pickedImages != null && provider.images.length + pickedImages.length <= 3) {
      provider.addImages(pickedImages.take(3 - provider.images.length).toList());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only upload up to 3 images in total.')),
      );
    }
  }

  void _reviewPost(PostProvider provider) {
    if (provider.captionController.text.isEmpty && provider.images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add some content to your post')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostReviewScreen(
          caption: provider.captionController.text,
          images: provider.images,
          videos: provider.videos,
        ),
      ),
    ).then((result) {
      if (result == true) {
        _submitPost(provider);
      }
    });
  }

  Future<void> _submitPost(PostProvider provider) async {
    provider.setLoading(true);

    try {
      final newPost = await _postRepository.createPost(
        userId: widget.userId,
        userProfileImage: widget.userProfileImage,
        content: provider.captionController.text,
        images: provider.images.map((e) => e.path).toList(),
        videos: provider.videos.map((e) => e.path).toList(),
        privacy: 'public',
        token: widget.token,
      );

      if (newPost != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully')),
        );
        provider.clear();
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create post')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      provider.setLoading(false);
    }
  }

 

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new post"),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _reviewPost(provider),
            ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildPostContent(provider),
      bottomNavigationBar: _buildFooter(provider),
    );
  }

  Widget _buildPostContent(PostProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                     
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.userProfileImage),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(Icons.cached, size: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userId,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     
                    },
                    child: const Text(
                      '',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            
            controller: provider.captionController,
            decoration: InputDecoration(
              hintText: 'Write something...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16.0),
          ImageGrid(
            images: provider.images,
            onRemove: (image) {
              provider.removeImage(image);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(PostProvider provider) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.link),
            onPressed: () {
              // Add link functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => _pickImage(provider),
          ),
          IconButton(
            icon: const Icon(Icons.poll),
            onPressed: () {
              // Add poll functionality
            },
          ),
          ElevatedButton(
            onPressed: () => _reviewPost(provider),
            child: Text('Post'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40), // Adjust button size if necessary
            ),
          ),
        ],
      ),
    );
  }
}
