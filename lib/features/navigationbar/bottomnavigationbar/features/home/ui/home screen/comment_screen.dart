import 'package:flutter/material.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/comment.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String token;
  final CommentRepository commentRepository;

  const CommentScreen({
    super.key,
    required this.postId,
    required this.token,
    required this.commentRepository,
  });

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Comment> _comments = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final comments = await widget.commentRepository.getPostComments(widget.postId, widget.token);
      if (comments != null) {
        setState(() {
          _comments = comments;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load comments';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _addComment(String content) async {
    if (content.isNotEmpty) {
      try {
        final newComment = await widget.commentRepository.addComment(widget.postId, content, widget.token);
        if (newComment != null) {
          setState(() {
            _comments.add(newComment);
          });
          _controller.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add comment')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text(_errorMessage!))
                    : _comments.isEmpty
                        ? const Center(child: Text('No comments yet'))
                        : ListView.builder(
                            itemCount: _comments.length,
                            itemBuilder: (context, index) {
                              final comment = _comments[index];
                              return ListTile(
                                title: Text(comment.content),
                                subtitle: Text('By ${comment.userId}'),
                              );
                            },
                          ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _addComment(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
