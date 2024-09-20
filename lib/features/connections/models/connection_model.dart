class Connection {
  final String id;
  final String requester;
  final String recipient;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Connection({
    required this.id,
    required this.requester,
    required this.recipient,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['_id'],
      requester: json['requester'],
      recipient: json['recipient'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requester': requester,
      'recipient': recipient,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
