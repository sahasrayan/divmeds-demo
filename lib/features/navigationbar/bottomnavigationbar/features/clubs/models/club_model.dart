class Club {
  final String id;
  final String name;
  final String clubId;
  final String description;
  final String? logo;
  final DateTime creationDate;
  final List<String> members;
  final String createdBy;
  final bool isPublic;

  Club({
    required this.id,
    required this.name,
    required this.clubId,
    required this.description,
    this.logo,
    required this.creationDate,
    required this.members,
    required this.createdBy,
    required this.isPublic,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['_id'],
      name: json['name'],
      clubId: json['clubId'],
      description: json['description'],
      logo: json['logo'],
      creationDate: DateTime.parse(json['creationDate']),
      members: List<String>.from(json['members']),
      createdBy: json['createdBy'],
      isPublic: json['isPublic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'clubId': clubId,
      'description': description,
      'logo': logo,
      'creationDate': creationDate.toIso8601String(),
      'members': members,
      'createdBy': createdBy,
      'isPublic': isPublic,
    };
  }
}
