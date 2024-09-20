
import 'package:divmeds/features/auth/models/user.model.dart';

User user = User(
  id: '_id',
  firstName: 'DivMeds',
  middleName: '',
  lastName: '',
  userId: 'divmeds.user',
  email: 'john.doe@example.com',
  password: 'password123',
  phone: '+1234567890',
  dob: '1990-01-01',
  gender: 'Male',
  profilePicture: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
  location: 'New York, USA',
  isHealthcare: true,
  isNonHealthcare: false,
  isVerified: true,
  verificationDocuments: [
    VerificationDocument(name: 'ID Card', url: 'https://example.com/id_card.jpg'),
  ],
  education: [
    Education(
      degree: 'Bachelor of Science',
      institution: 'University of Example',
      fieldOfStudy: 'Computer Science',
      startYear: '2008',
      endYear: '2012',
    ),
  ],
  professionalDetails: [
    ProfessionalDetails(
      status: 'Employed',
      institution: 'Example Corp',
      position: 'Software Engineer',
      startDate: DateTime(2013, 1, 1),
      endDate: DateTime(2020, 1, 1),
    ),
  ],
  connections: ['user2', 'user3'],
  follow: ['user4', 'user5'],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  role: 'user',
  tagline: 'Just a dummy user',
  aboutSection: 'This is a dummy user created for UI testing purposes.',
  links: [
    Link(name: 'LinkedIn', url: 'https://linkedin.com/in/johndoe'),
  ],
  userTags: ['developer', 'engineer'],
);
