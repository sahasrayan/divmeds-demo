class Message {
  final String userId;
  final String content;
  final List<String> attachments;
  final DateTime createdAt;

  Message({
    required this.userId,
    required this.content,
    required this.attachments,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['userId'],
      content: json['content'],
      attachments: List<String>.from(json['attachments']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'attachments': attachments,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Discussion {
  final String clubId;
  final List<Message> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  Discussion({
    required this.clubId,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      clubId: json['clubId'],
      messages: (json['messages'] as List)
          .map((message) => Message.fromJson(message))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clubId': clubId,
      'messages': messages.map((message) => message.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
