import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/comment.model.dart';

class PostRepository {
  final Dio _dio = Dio();
  final String serverUrl;

  PostRepository({required this.serverUrl});

  // Create a new post
  Future<Post?> createPost({
    required String content,
    required List<String> images,
    required List<String> videos,
     List<String>? links,
    required String privacy,
    required String token,
    required String userId,
    required String userProfileImage,
    List<String>? tags,
    Poll? poll,
    Doubt? doubt,
  }) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts',
        data: {
          'content': content,
          'images': images,
          'videos': videos,
          'links': links,
          'privacy': privacy,
          'tags': tags ?? [],
          'poll': poll?.toJson(),
          'doubt': doubt?.toJson(),
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
        return Post.fromJson(response.data);
      } else {
        log('Error creating post: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception creating post: $e');
      return null;
    }
  }

  // Get a specific post by ID
  Future<Post?> getPostById(String postId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/$postId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return Post.fromJson(response.data);
      } else {
        log('Error fetching post: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception fetching post: $e');
      return null;
    }
  }

  // Get posts by a specific user
  Future<List<Post>> getPostsByUserId(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/user/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((post) => Post.fromJson(post)).toList();
      } else {
        log('Error fetching user posts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching user posts: $e');
      return [];
    }
  }

  // Get posts of the logged-in user
  Future<List<Post>> getUserPosts(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/me/posts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((post) => Post.fromJson(post)).toList();
      } else {
        log('Error fetching user posts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching user posts: $e');
      return [];
    }
  }

  // Like a post
  Future<bool> likePost(String postId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception liking post: $e');
      return false;
    }
  }

  // Unlike a post
  Future<bool> unlikePost(String postId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/unlike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception unliking post: $e');
      return false;
    }
  }

  // Comment on a post
  Future<bool> commentOnPost(String postId, String content, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/comment',
        data: {'content': content},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception commenting on post: $e');
      return false;
    }
  }

  // Get post likes
  Future<List<String>> getPostLikes(String postId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/$postId/likes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return List<String>.from(data);
      } else {
        log('Error fetching post likes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching post likes: $e');
      return [];
    }
  }

  // Get post comments
  Future<List<Comment>> getPostComments(String postId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/$postId/comments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((comment) => Comment.fromJson(comment)).toList();
      } else {
        log('Error fetching post comments: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching post comments: $e');
      return [];
    }
  }

  // Update a post
  Future<Post?> updatePost({
    required String postId,
    required String content,
    required List<String> images,
    required List<String> videos,
    required List<String> links,
    required String privacy,
    required String token,
    List<String>? tags,
    Poll? poll,
    Doubt? doubt,
  }) async {
    try {
      final response = await _dio.put(
        '$serverUrl/posts/$postId',
        data: {
          'content': content,
          'images': images,
          'videos': videos,
          'links': links,
          'privacy': privacy,
          'tags': tags ?? [],
          'poll': poll?.toJson(),
          'doubt': doubt?.toJson(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return Post.fromJson(response.data);
      } else {
        log('Error updating post: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception updating post: $e');
      return null;
    }
  }

  // Delete a post
  Future<bool> deletePost(String postId, String token) async {
    try {
      final response = await _dio.delete(
        '$serverUrl/posts/$postId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception deleting post: $e');
      return false;
    }
  }

  // Share a post
  Future<bool> sharePost(String postId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/share',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception sharing post: $e');
      return false;
    }
  }

  // Vote on a poll option
  Future<bool> votePollOption(String postId, String optionId, String token) async {
    try {
      final response = await _dio.post(
        '$serverUrl/posts/$postId/vote',
        data: {'optionId': optionId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode! >= 200 && response.statusCode! <= 300;
    } catch (e) {
      log('Exception voting on poll option: $e');
      return false;
    }
  }

  // Get posts by tags
  Future<List<Post>> getPostsByTags(List<String> tags, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/tags',
        queryParameters: {'tags': tags.join(',')},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((post) => Post.fromJson(post)).toList();
      } else {
        log('Error fetching posts by tags: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching posts by tags: $e');
      return [];
    }
  }

  // Get logged-in user's doubts
  Future<List<Doubt>> getMyDoubts(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/me/doubts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((doubt) => Doubt.fromJson(doubt)).toList();
      } else {
        log('Error fetching my doubts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching my doubts: $e');
      return [];
    }
  }

  // Get logged-in user's polls
  Future<List<Poll>> getMyPolls(String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/me/polls',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((poll) => Poll.fromJson(poll)).toList();
      } else {
        log('Error fetching my polls: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching my polls: $e');
      return [];
    }
  }

  // Get another user's doubts
  Future<List<Doubt>> getUserDoubts(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/user/$userId/doubts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((doubt) => Doubt.fromJson(doubt)).toList();
      } else {
        log('Error fetching user doubts: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching user doubts: $e');
      return [];
    }
  }

  // Get another user's polls
  Future<List<Poll>> getUserPolls(String userId, String token) async {
    try {
      final response = await _dio.get(
        '$serverUrl/posts/user/$userId/polls',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        List<dynamic> data = response.data;
        return data.map((poll) => Poll.fromJson(poll)).toList();
      } else {
        log('Error fetching user polls: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Exception fetching user polls: $e');
      return [];
    }
  }
}
