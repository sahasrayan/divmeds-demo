import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/models/post.model.dart';

final List<Map<String, String>> dummyArticles = [
  {
    'title': 'The Impact of Telemedicine on Modern Healthcare',
    'content': '''Telemedicine has revolutionized modern healthcare by providing remote access to medical professionals. Key benefits include:

- **Convenience:** Patients can consult with doctors from the comfort of their homes.
- **Accessibility:** Telemedicine makes healthcare more accessible, particularly in remote areas.
- **Cost-Effectiveness:** Reduces the need for travel and associated expenses.

As technology continues to evolve, telemedicine is expected to play an increasingly vital role in healthcare delivery.''',
  },
  {
    'title': 'Understanding Mental Health: Breaking the Stigma',
    'content': '''Mental health is as crucial as physical health, yet stigma remains. This article explores:

- **Common Misconceptions:** Addressing myths and misconceptions about mental health.
- **The Importance of Support:** How community and professional support can make a difference.
- **Educational Initiatives:** The role of education in promoting mental health awareness.

Breaking the stigma requires collective effort and continuous education.''',
  },
  {
    'title': 'The Role of Nutrition in Preventing Chronic Diseases',
    'content': '''Proper nutrition is key to preventing chronic diseases such as diabetes, heart disease, and obesity. Key points include:

- **Balanced Diet:** Emphasizing fruits, vegetables, whole grains, and lean proteins.
- **Portion Control:** Understanding the importance of portion sizes in maintaining a healthy weight.
- **Nutritional Education:** The need for increased awareness about the impact of diet on long-term health.

Nutrition plays a crucial role in maintaining overall health and preventing disease.''',
  },
  {
    'title': 'Advancements in Cancer Treatment: What You Need to Know',
    'content': '''Recent advancements in cancer treatment have improved patient outcomes. Key advancements include:

- **Immunotherapy:** Harnessing the immune system to fight cancer.
- **Targeted Therapies:** Developing treatments that target specific cancer cells.
- **Personalized Medicine:** Tailoring treatments based on individual genetic profiles.

These innovations represent a promising future for cancer care and treatment.''',
  },
  {
    'title': 'Managing Diabetes: Tips and Strategies for a Healthier Life',
    'content': '''Managing diabetes involves a combination of lifestyle changes and medical intervention. Key strategies include:

- **Diet Management:** Monitoring carbohydrate intake and maintaining a balanced diet.
- **Regular Exercise:** The role of physical activity in controlling blood sugar levels.
- **Medication Adherence:** The importance of following prescribed treatments.

With proper management, individuals with diabetes can lead healthy and fulfilling lives.''',
  },
  {
    'title': 'The Importance of Regular Health Screenings',
    'content': '''Regular health screenings are essential for early detection of various health conditions. Key screenings include:

- **Blood Pressure:** Regular checks to detect hypertension.
- **Cholesterol Levels:** Monitoring cholesterol to prevent heart disease.
- **Cancer Screenings:** Early detection screenings for cancers such as breast, colon, and prostate.

Regular health screenings can save lives by catching conditions early.''',
  },
  {
    'title': 'The Future of Healthcare: AI and Machine Learning',
    'content': '''Artificial intelligence (AI) and machine learning are transforming healthcare. Key developments include:

- **Diagnostics:** AI-powered tools for accurate and rapid diagnosis.
- **Personalized Treatment:** Tailoring treatments using AI-based predictive models.
- **Patient Care:** Enhancing patient care through AI-driven monitoring and management.

The integration of AI in healthcare promises to revolutionize the industry.''',
  },
  {
    'title': 'Exercise and Mental Health: How Physical Activity Boosts Well-Being',
    'content': '''Physical activity is crucial for mental health. Key benefits include:

- **Reducing Anxiety and Depression:** Exercise as a natural mood booster.
- **Improving Sleep:** How regular activity contributes to better sleep quality.
- **Enhancing Cognitive Function:** The impact of exercise on brain health.

Incorporating regular exercise into your routine can significantly improve mental well-being.''',
  },
  {
    'title': 'Vaccination: Myths and Facts',
    'content': '''Vaccinations are essential for preventing infectious diseases. This article addresses:

- **Common Myths:** Debunking misconceptions about vaccine safety and efficacy.
- **Scientific Facts:** The evidence supporting the importance of vaccines.
- **Public Health Impact:** How vaccines contribute to herd immunity and public health.

Understanding the facts about vaccines is crucial for informed decision-making.''',
  },
  {
    'title': 'The Impact of Climate Change on Public Health',
    'content': '''Climate change poses significant risks to public health. Key areas of concern include:

- **Respiratory Issues:** Increased pollution leading to respiratory problems.
- **Spread of Infectious Diseases:** Changing climates contributing to the spread of diseases.
- **Food and Water Security:** The impact of climate change on food and water availability.

Addressing climate change is vital for safeguarding public health.''',
  },
  {
    'title': 'The Benefits of Mindfulness and Meditation',
    'content': '''Mindfulness and meditation offer numerous mental and physical health benefits. Key advantages include:

- **Stress Reduction:** Techniques to lower stress and anxiety levels.
- **Enhanced Focus:** Improving concentration and mental clarity.
- **Emotional Regulation:** Managing emotions and fostering a positive mindset.

Integrating mindfulness and meditation into daily life can enhance overall well-being.''',
  },
  {
    'title': 'Innovations in Surgical Techniques',
    'content': '''Surgical techniques have evolved significantly. Key innovations include:

- **Minimally Invasive Surgery:** Reducing recovery times and improving outcomes.
- **Robotic Surgery:** Precision and control in complex surgeries.
- **Advanced Imaging:** Enhancing surgical planning and execution.

These advancements are improving patient outcomes and redefining surgical care.''',
  },
  {
    'title': 'Elderly Care: Ensuring Quality of Life for Aging Populations',
    'content': '''As populations age, elderly care is becoming increasingly important. Key considerations include:

- **Home Care Services:** Providing support to elderly individuals in their homes.
- **Social Engagement:** The role of social activities in enhancing quality of life.
- **Health Monitoring:** Regular health checks to manage chronic conditions.

Focusing on elderly care is essential for promoting dignity and quality of life.''',
  },
  {
    'title': 'The Connection Between Sleep and Overall Health',
    'content': '''Adequate sleep is crucial for maintaining overall health. Key benefits of good sleep include:

- **Immune Function:** How sleep boosts the immune system.
- **Cognitive Performance:** The role of sleep in memory and learning.
- **Emotional Well-being:** Managing stress and emotional health through proper sleep.

Prioritizing sleep is a cornerstone of a healthy lifestyle.''',
  },
  {
    'title': 'The Benefits of Plant-Based Diets',
    'content': '''Plant-based diets are associated with numerous health benefits. Key benefits include:

- **Heart Health:** Lowering the risk of cardiovascular diseases.
- **Weight Management:** Supporting healthy weight loss and maintenance.
- **Nutrient-Rich:** Ensuring a diet rich in essential vitamins and minerals.

Exploring plant-based options can lead to significant health improvements.''',
  },
  {
    'title': 'Understanding and Managing Hypertension',
    'content': '''Hypertension, or high blood pressure, is a common condition that requires careful management. Key strategies include:

- **Dietary Adjustments:** Reducing sodium intake and eating a balanced diet.
- **Physical Activity:** The role of regular exercise in controlling blood pressure.
- **Medication Management:** Adhering to prescribed treatments for optimal results.

Managing hypertension effectively can prevent serious health complications.''',
  },
  {
    'title': 'Children’s Health: Promoting Healthy Development',
    'content': '''Promoting healthy development in children involves various strategies. Key areas of focus include:

- **Nutrition:** Ensuring a balanced diet for growth and development.
- **Physical Activity:** Encouraging regular exercise for physical and mental well-being.
- **Routine Check-Ups:** The importance of regular medical examinations.

Supporting children’s health is essential for their long-term success and happiness.''',
  },
  {
    'title': 'Exploring the Benefits of Alternative Medicine',
    'content': '''Alternative medicine practices are gaining popularity. Key areas of interest include:

- **Acupuncture:** The benefits of acupuncture for pain management.
- **Herbal Remedies:** Exploring natural remedies for common ailments.
- **Holistic Approaches:** Integrating mind-body practices for overall wellness.

Understanding alternative medicine can offer new perspectives on health care.''',
  },
  {
    'title': 'Addressing the Opioid Crisis: Prevention and Treatment Strategies',
    'content': '''The opioid crisis remains a major public health issue. Key strategies include:

- **Prevention:** Education and awareness programs to prevent opioid misuse.
- **Treatment:** Access to treatment programs for those affected by addiction.
- **Support Systems:** The role of community and family support in recovery.

Combating the opioid crisis requires a comprehensive and compassionate approach.''',
  },
  {
    'title': 'The Importance of Hydration for Health and Well-being',
    'content': '''Staying hydrated is essential for maintaining bodily functions and overall health. Key tips include:

- **Daily Water Intake:** Recommendations for optimal hydration.
- **Signs of Dehydration:** Recognizing and addressing dehydration early.
- **Hydration in Sports:** Ensuring adequate hydration during physical activity.

Prioritizing hydration can enhance both physical and mental performance.''',
  },
];

final List<User> dummyUsers = [
  User(
    id: '1',
    firstName: 'Alice',
    middleName: 'M.',
    lastName: 'Smith',
    userId: 'alice.smith',
    email: 'alice.smith@example.com',
    password: 'password1',
    phone: '+123456781',
    dob: '1985-03-12',
    gender: 'Female',
    profilePicture: 'https://example.com/alice.jpg',
    location: 'New York, USA',
    isHealthcare: true,
    isNonHealthcare: false,
    isVerified: true,
    verificationDocuments: [
      VerificationDocument(
        name: 'Medical License',
        url: 'https://example.com/license1.pdf',
      )
    ],
    education: [
      Education(
        degree: 'MD',
        institution: 'Harvard Medical School',
        fieldOfStudy: 'Cardiology',
        startYear: '2003',
        endYear: '2007',
        grade: 'A',
        activities: ['Cardiology Club', 'Research Assistant'],
        awards: ['Best Student Award'],
        projects: [
          Project(
            title: 'Cardiac Health Research',
            description: 'Research on improving cardiac health...',
            startDate: DateTime(2005, 6, 1),
            endDate: DateTime(2006, 6, 1),
            url: 'https://example.com/research1',
          )
        ],
      )
    ],
    professionalDetails: [
      ProfessionalDetails(
        status: 'Active',
        institution: 'NY Presbyterian Hospital',
        position: 'Cardiologist',
        department: 'Cardiology',
        startDate: DateTime(2008, 6, 1),
        endDate: DateTime.now(),
        responsibilities: ['Patient Care', 'Surgery'],
        achievements: ['Top Cardiologist 2015'],
        certifications: [
          Certification(
            name: 'Board Certification in Cardiology',
            issuingOrganization: 'American Board of Cardiology',
            issueDate: DateTime(2008, 7, 1),
            expirationDate: DateTime(2028, 7, 1),
          )
        ],
        publications: [
          Publication(
            title: 'Advances in Cardiology',
            journal: 'Cardiology Today',
            publicationDate: DateTime(2010, 5, 1),
            url: 'https://example.com/publication1',
          )
        ],
        memberships: [
          Membership(
            organization: 'American Heart Association',
            role: 'Member',
            startDate: DateTime(2008, 7, 1),
            endDate: DateTime.now(),
          )
        ],
        skills: ['Cardiac Surgery', 'Patient Care'],
      )
    ],
    connections: ['john.doe', 'sarah.johnson'],
    follow: ['michael.williams', 'emily.brown'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    role: 'user',
    tagline: 'Caring for hearts, one beat at a time',
    aboutSection: 'Dr. Alice Smith is a renowned cardiologist with over 15 years of experience...',
    links: [
      Link(
        name: 'LinkedIn',
        url: 'https://www.linkedin.com/in/alicesmith',
      )
    ],
    userTags: ['Cardiologist', 'Heart Specialist'],
  ),
  User(
    id: '2',
    firstName: 'John',
    middleName: 'A.',
    lastName: 'Doe',
    userId: 'john.doe',
    email: 'john.doe@example.com',
    password: 'password2',
    phone: '+123456782',
    dob: '1978-06-22',
    gender: 'Male',
    profilePicture: 'https://example.com/john.jpg',
    location: 'Los Angeles, USA',
    isHealthcare: true,
    isNonHealthcare: false,
    isVerified: true,
    verificationDocuments: [
      VerificationDocument(
        name: 'Dental License',
        url: 'https://example.com/license2.pdf',
      )
    ],
    education: [
      Education(
        degree: 'DDS',
        institution: 'UCLA School of Dentistry',
        fieldOfStudy: 'Dentistry',
        startYear: '1996',
        endYear: '2000',
        grade: 'A',
        activities: ['Dental Club', 'Community Service'],
        awards: ['Outstanding Student Award'],
        projects: [
          Project(
            title: 'Dental Health Initiative',
            description: 'Improving dental health in underserved communities...',
            startDate: DateTime(1998, 6, 1),
            endDate: DateTime(1999, 6, 1),
            url: 'https://example.com/project2',
          )
        ],
      )
    ],
    professionalDetails: [
      ProfessionalDetails(
        status: 'Active',
        institution: 'LA Dental Clinic',
        position: 'Dentist',
        department: 'General Dentistry',
        startDate: DateTime(2001, 6, 1),
        endDate: DateTime.now(),
        responsibilities: ['Patient Care', 'Dental Surgery'],
        achievements: ['Top Dentist 2012'],
        certifications: [
          Certification(
            name: 'Board Certification in Dentistry',
            issuingOrganization: 'American Dental Association',
            issueDate: DateTime(2001, 7, 1),
            expirationDate: DateTime(2021, 7, 1),
          )
        ],
        publications: [
          Publication(
            title: 'Innovations in Dentistry',
            journal: 'Dental Journal',
            publicationDate: DateTime(2012, 5, 1),
            url: 'https://example.com/publication2',
          )
        ],
        memberships: [
          Membership(
            organization: 'American Dental Association',
            role: 'Member',
            startDate: DateTime(2001, 7, 1),
            endDate: DateTime.now(),
          )
        ],
        skills: ['Dental Surgery', 'Patient Care'],
      )
    ],
    connections: ['alice.smith', 'sarah.johnson'],
    follow: ['michael.williams', 'emily.brown'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    role: 'user',
    tagline: 'Brightening smiles every day',
    aboutSection: 'Dr. John Doe is a dedicated dentist with a passion for dental health...',
    links: [
      Link(
        name: 'LinkedIn',
        url: 'https://www.linkedin.com/in/johndoe',
      )
    ],
    userTags: ['Dentist', 'Dental Health'],
  ),
  // Add more dummy users as needed...
];

Future<List<Post>> getDummyPosts() async {
    return List.generate(10, (index) {
      return Post(
        id: '$index',
   
        content: 'DivMeds: Revolutionizing the Indian Healthcare Ecosystem',
        images: [],
        videos: [],
        likes: [],
        comments: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(), type: '', links: [], privacy: '', tags: [],
      );
    });
  }

