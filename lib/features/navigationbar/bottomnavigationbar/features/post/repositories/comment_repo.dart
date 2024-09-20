import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/comment.model.dart';

class CommentRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  CommentRepository({required this.serverUrl});

  // Fetch comments for a post
  Future<List<Comment>?> getPostComments(String postId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/$postId/comments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return (response.data as List)
            .map((i) => Comment.fromJson(i))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Add a comment to a post
  Future<Comment?> addComment(String postId, String content, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/comment',
        data: {
          'content': content,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return Comment.fromJson(response.data['comment']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Edit a comment
  Future<Comment?> editComment(String commentId, String content, String token) async {
    try {
      final response = await _dio.put(
        '$serverUrl/comments/$commentId',
        data: {
          'content': content,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(response.data.toString());
        return Comment.fromJson(response.data['comment']);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Delete a comment
  Future<bool> deleteComment(String commentId, String token) async {
    try {
      final response = await _dio.delete(
        '$serverUrl/comments/$commentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
   

// Integration in your main application:
// To use the CommentRepository, instantiate it and call its methods as needed:


// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/repositories/comment_repo.dart';

// final commentRepository = CommentRepository(serverUrl: 'your_server_url');

// // Example usage:
// final comments = await commentRepository.getPostComments(postId, token);
// final newComment = await commentRepository.addComment(postId, 'Great post!', token);
// final updatedComment = await commentRepository.editComment(commentId, 'Updated comment', token);
// final isDeleted = await commentRepository.deleteComment(commentId, token);