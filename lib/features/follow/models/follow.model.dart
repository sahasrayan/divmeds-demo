class Follow {
  final String id;
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  Follow({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      id: json['_id'] ?? '',
      followerId: json['follower'] ?? '',
      followingId: json['following'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'follower': followerId,
      'following': followingId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
