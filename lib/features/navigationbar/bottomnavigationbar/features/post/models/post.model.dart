import 'user_summary.model.dart';

class Post {
  final String id;
  final UserSummary? userSummary;
  final String type; // 'basic', 'poll', 'doubt'
  final String content;
  final List<String> images;
  final List<String> videos;
  final List<String> links;
  final String privacy;
  final List<String> likes;
  final List<String> comments;
  final String? sharedPost;
  final List<String> tags;
  final Poll? poll;
  final Doubt? doubt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    this.userSummary,
    required this.type,
    required this.content,
    required this.images,
    required this.videos,
    required this.links,
    required this.privacy,
    required this.likes,
    required this.comments,
    this.sharedPost,
    required this.tags,
    this.poll,
    this.doubt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '',
      userSummary: json['userSummary'] != null ? UserSummary.fromJson(json['userSummary']) : null,
      type: json['type'] ?? 'basic',
      content: json['content'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      links: List<String>.from(json['links'] ?? []),
      privacy: json['privacy'] ?? 'public',
      likes: List<String>.from(json['likes'] ?? []),
      comments: List<String>.from(json['comments'] ?? []),
      sharedPost: json['sharedPost'],
      tags: List<String>.from(json['tags'] ?? []),
      poll: json['poll'] != null ? Poll.fromJson(json['poll']) : null,
      doubt: json['doubt'] != null ? Doubt.fromJson(json['doubt']) : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userSummary': userSummary?.toJson(),
      'type': type,
      'content': content,
      'images': images,
      'videos': videos,
      'links': links,
      'privacy': privacy,
      'likes': likes,
      'comments': comments,
      'sharedPost': sharedPost,
      'tags': tags,
      'poll': poll?.toJson(),
      'doubt': doubt?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Poll {
  final String question;
  final List<PollOption> options;

  Poll({
    required this.question,
    required this.options,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      question: json['question'] ?? '',
      options: (json['options'] as List).map((i) => PollOption.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options.map((i) => i.toJson()).toList(),
    };
  }
}

class PollOption {
  final String option;
  final int votes;

  PollOption({
    required this.option,
    required this.votes,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      option: json['option'] ?? '',
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'option': option,
      'votes': votes,
    };
  }
}

class Doubt {
  final String title;
  final String description;
  final List<String> tags;
  final List<String> referredTo;
  final List<Answer> answers;

  Doubt({
    required this.title,
    required this.description,
    required this.tags,
    required this.referredTo,
    required this.answers,
  });

  factory Doubt.fromJson(Map<String, dynamic> json) {
    return Doubt(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      referredTo: List<String>.from(json['referredTo'] ?? []),
      answers: (json['answers'] as List).map((i) => Answer.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'tags': tags,
      'referredTo': referredTo,
      'answers': answers.map((i) => i.toJson()).toList(),
    };
  }
}

class Answer {
  final String userId;
  final String content;

  Answer({
    required this.userId,
    required this.content,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      userId: json['userId'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
    };
  }
}
