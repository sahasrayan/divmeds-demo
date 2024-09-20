class Doubt {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> tags;
  final List<String> referredTo;
  final List<String> images;
  final List<Answer> answers;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doubt({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.tags,
    required this.referredTo,
    required this.images,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doubt.fromJson(Map<String, dynamic> json) {
    return Doubt(
      id: json['_id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      referredTo: List<String>.from(json['referredTo']),
      images: List<String>.from(json['images']),
      answers: (json['answers'] as List).map((i) => Answer.fromJson(i)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'tags': tags,
      'referredTo': referredTo,
      'images': images,
      'answers': answers.map((i) => i.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Answer {
  final String userId;
  final String answer;
  final DateTime createdAt;

  Answer({
    required this.userId,
    required this.answer,
    required this.createdAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      userId: json['userId'],
      answer: json['answer'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'answer': answer,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
