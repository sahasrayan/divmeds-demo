class UserSummary {
  final String id;
  final String firstName;
  final String lastName;
  final String userId;
  final String profilePicture;

  UserSummary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.profilePicture,
  });

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName']??'', 
      profilePicture: json['profilePicture'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
    };
  }
}
