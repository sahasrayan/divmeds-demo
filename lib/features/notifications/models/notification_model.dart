import 'package:divmeds/features/auth/models/user.model.dart';

class NotificationModel {
  final String id;
  final String recipient;
  final User sender;
  final String type;
  final String message;
  final bool read;
  final DateTime createdAt;
  final String? postId;
  final String? userId;

  NotificationModel({
    required this.id,
    required this.recipient,
    required this.sender,
    required this.type,
    required this.message,
    required this.read,
    required this.createdAt,
    this.postId,
    this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      recipient: json['recipient'],
      sender: User.fromJson(json['sender']),
      type: json['type'],
      message: json['message'],
      read: json['read'],
      createdAt: DateTime.parse(json['createdAt']),
      postId: json['postId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'recipient': recipient,
      'sender': sender.toJson(),
      'type': type,
      'message': message,
      'read': read,
      'createdAt': createdAt.toIso8601String(),
      'postId': postId,
      'userId': userId,
    };
  }
}