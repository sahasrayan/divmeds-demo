import 'package:divmeds/features/verification/models/verification_document_model.dart';

class Verification {
  final String id;
  final String userId;
  final String documentType;
  final List<VerificationDocument> documents;
  final String status;
  final String adminMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Verification({
    required this.id,
    required this.userId,
    required this.documentType,
    required this.documents,
    required this.status,
    required this.adminMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      id: json['_id'],
      userId: json['userId'],
      documentType: json['documentType'],
      documents: (json['documents'] as List)
          .map((i) => VerificationDocument.fromJson(i))
          .toList(),
      status: json['status'],
      adminMessage: json['adminMessage'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'documentType': documentType,
      'documents': documents.map((i) => i.toJson()).toList(),
      'status': status,
      'adminMessage': adminMessage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
