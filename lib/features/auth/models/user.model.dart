class User {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String userId;
  final String email;
  final String password;
  final String phone;
  final String dob;
  final String gender;
  final String profilePicture;
  final String location;
  final bool isHealthcare;
  final bool isNonHealthcare;
  final bool isVerified;
  final List<VerificationDocument> verificationDocuments;
  final List<Education> education;
  final List<ProfessionalDetails> professionalDetails;
  final List<String> connections;
  final List<String> follow;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final String tagline;
  final String aboutSection;
  final List<Link> links;
  final List<String> userTags;

  User({
    required this.id,
    required this.firstName,
    this.middleName = '',
    this.lastName = '',
    required this.userId,
    this.email = '',
    required this.password,
    required this.phone,
    required this.dob,
    required this.gender,
    this.profilePicture = '',
    this.location = '',
    this.isHealthcare = false,
    this.isNonHealthcare = false,
    this.isVerified = false,
    this.verificationDocuments = const [],
    this.education = const [],
    this.professionalDetails = const [],
    this.connections = const [],
    this.follow = const [],
    required this.createdAt,
    required this.updatedAt,
    this.role = 'user',
    this.tagline = '',
    this.aboutSection = '',
    this.links = const [],
    this.userTags = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      location: json['location'] ?? '',
      isHealthcare: json['isHealthcare'] ?? false,
      isNonHealthcare: json['isNonHealthcare'] ?? false,
      isVerified: json['isVerified'] ?? false,
      verificationDocuments: (json['verificationDocuments'] as List?)
              ?.map((i) => VerificationDocument.fromJson(i))
              .toList() ??
          [],
      education: (json['education'] as List?)
              ?.map((i) => Education.fromJson(i))
              .toList() ??
          [],
      professionalDetails: (json['professionalDetails'] as List?)
              ?.map((i) => ProfessionalDetails.fromJson(i))
              .toList() ??
          [],
      connections: List<String>.from(json['connections'] ?? []),
      follow: List<String>.from(json['follow'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      role: json['role'] ?? 'user',
      tagline: json['tagline'] ?? '',
      aboutSection: json['aboutSection'] ?? '',
      links: (json['links'] as List?)
              ?.map((i) => Link.fromJson(i))
              .toList() ??
          [],
      userTags: List<String>.from(json['userTags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'userId': userId,
      'email': email,
      'password': password,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'profilePicture': profilePicture,
      'location': location,
      'isHealthcare': isHealthcare,
      'isNonHealthcare': isNonHealthcare,
      'isVerified': isVerified,
      'verificationDocuments': verificationDocuments.map((i) => i.toJson()).toList(),
      'education': education.map((i) => i.toJson()).toList(),
      'professionalDetails': professionalDetails.map((i) => i.toJson()).toList(),
      'connections': connections,
      'follow': follow,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'role': role,
      'tagline': tagline,
      'aboutSection': aboutSection,
      'links': links.map((i) => i.toJson()).toList(),
      'userTags': userTags,
    };
  }
}

class VerificationDocument {
  final String name;
  final String url;

  VerificationDocument({
    required this.name,
    required this.url,
  });

  factory VerificationDocument.fromJson(Map<String, dynamic> json) {
    return VerificationDocument(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Education {
  final String degree;
  final String institution;
  final String fieldOfStudy;
  final String startYear;
  final String endYear;
  final String grade;
  final List<String> activities;
  final List<String> awards;
  final List<Project> projects;

  Education({
    required this.degree,
    required this.institution,
    this.fieldOfStudy = '',
     this.startYear ='',
    this.endYear = '',
    this.grade = '',
    this.activities = const [],
    this.awards = const [],
    this.projects = const [],
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] ?? '',
      institution: json['institution'] ?? '',
      fieldOfStudy: json['fieldOfStudy'] ?? '',
      startYear: json['startYear'] ?? '',
      endYear: json['endYear'] ?? '',
      grade: json['grade'] ?? '',
      activities: List<String>.from(json['activities'] ?? []),
      awards: List<String>.from(json['awards'] ?? []),
      projects: (json['projects'] as List?)
              ?.map((i) => Project.fromJson(i))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'fieldOfStudy': fieldOfStudy,
      'startYear': startYear,
      'endYear': endYear,
      'grade': grade,
      'activities': activities,
      'awards': awards,
      'projects': projects.map((i) => i.toJson()).toList(),
    };
  }
}

class Project {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String url;

  Project({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.url,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'url': url,
    };
  }
}

class ProfessionalDetails {
  final String status;
  final String institution;
  final String position;
  final String department;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> responsibilities;
  final List<String> achievements;
  final List<Certification> certifications;
  final List<Publication> publications;
  final List<Membership> memberships;
  final List<String> skills;

  ProfessionalDetails({
    required this.status,
    required this.institution,
    required this.position,
    this.department = '',
    required this.startDate,
    required this.endDate,
    this.responsibilities = const [],
    this.achievements = const [],
    this.certifications = const [],
    this.publications = const [],
    this.memberships = const [],
    this.skills = const [],
  });

  factory ProfessionalDetails.fromJson(Map<String, dynamic> json) {
    return ProfessionalDetails(
      status: json['status'] ?? '',
      institution: json['institution'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
      certifications: (json['certifications'] as List?)
              ?.map((i) => Certification.fromJson(i))
              .toList() ??
          [],
      publications: (json['publications'] as List?)
              ?.map((i) => Publication.fromJson(i))
              .toList() ??
          [],
      memberships: (json['memberships'] as List?)
              ?.map((i) => Membership.fromJson(i))
              .toList() ??
          [],
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'institution': institution,
      'position': position,
      'department': department,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'responsibilities': responsibilities,
      'achievements': achievements,
      'certifications': certifications.map((i) => i.toJson()).toList(),
      'publications': publications.map((i) => i.toJson()).toList(),
      'memberships': memberships.map((i) => i.toJson()).toList(),
      'skills': skills,
    };
  }
}

class Certification {
  final String name;
  final String issuingOrganization;
  final DateTime issueDate;
  final DateTime expirationDate;

  Certification({
    required this.name,
    required this.issuingOrganization,
    required this.issueDate,
    required this.expirationDate,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      name: json['name'] ?? '',
      issuingOrganization: json['issuingOrganization'] ?? '',
      issueDate: DateTime.parse(json['issueDate'] ?? DateTime.now().toIso8601String()),
      expirationDate: DateTime.parse(json['expirationDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'issuingOrganization': issuingOrganization,
      'issueDate': issueDate.toIso8601String(),
      'expirationDate': expirationDate.toIso8601String(),
    };
  }
}

class Publication {
  final String title;
  final String journal;
  final DateTime publicationDate;
  final String url;

  Publication({
    required this.title,
    required this.journal,
    required this.publicationDate,
    required this.url,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      title: json['title'] ?? '',
      journal: json['journal'] ?? '',
      publicationDate: DateTime.parse(json['publicationDate'] ?? DateTime.now().toIso8601String()),
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'journal': journal,
      'publicationDate': publicationDate.toIso8601String(),
      'url': url,
    };
  }
}

class Membership {
  final String organization;
  final String role;
  final DateTime startDate;
  final DateTime endDate;

  Membership({
    required this.organization,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      organization: json['organization'] ?? '',
      role: json['role'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'organization': organization,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}

class Link {
  final String name;
  final String url;

  Link({
    required this.name,
    required this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
