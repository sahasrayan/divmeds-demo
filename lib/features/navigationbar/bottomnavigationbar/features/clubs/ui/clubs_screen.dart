import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';

class ClubsScreen extends StatefulWidget {
  @override
  _ClubsScreenState createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Club> allClubs = [
    Club(
      name: 'Anatomy Club',
      description: 'Explore the human body in-depth with interactive 3D diagrams and quizzes.',
      members: 1200,
      imageUrl: 'assets/anatomy.png',
    ),
    Club(
      name: 'Physiology Club',
      description: 'Understand the functions of the human body through engaging tutorials and flashcards.',
      members: 950,
      imageUrl: 'assets/physiology.png',
    ),
    Club(
      name: 'Pathology Club',
      description: 'Dive into the study of diseases and their impact on the human body.',
      members: 800,
      imageUrl: 'assets/anatomy.png',
    ),
    Club(
      name: 'Pharmacology Club',
      description: 'Explore the effects of drugs and their therapeutic uses.',
      members: 1050,
      imageUrl: 'assets/physiology.png',
    ),
    Club(
      name: 'Microbiology Club',
      description: 'Study microorganisms and their roles in health and disease.',
      members: 700,
      imageUrl: 'assets/anatomy.png',
    ),
    Club(
      name: 'Biochemistry Club',
      description: 'Discover the chemical processes within and related to living organisms.',
      members: 670,
      imageUrl: 'assets/physiology.png',
    ),
    Club(
      name: 'Clinical Skills Club',
      description: 'Sharpen your clinical skills with hands-on practice and workshops.',
      members: 1200,
      imageUrl: 'assets/anatomy.png',
    ),
    Club(
      name: 'Radiology Club',
      description: 'Learn about medical imaging techniques and their applications.',
      members: 850,
      imageUrl: 'assets/physiology.png',
    ),
    Club(
      name: 'Surgery Club',
      description: 'Gain insights into surgical procedures and techniques.',
      members: 1100,
      imageUrl: 'assets/anatomy.png',
    ),
    // Add more clubs here with repeating images
  ];

  List<Club> filteredClubs = [];

  @override
  void initState() {
    super.initState();
    filteredClubs = allClubs;
  }

  void _filterClubs(String query) {
    setState(() {
      filteredClubs = allClubs
          .where((club) => club.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for clubs...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          _filterClubs(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // AppColors.divMedsColorBlue1.withOpacity(0.8),
                    // AppColors.divMedsColorBluePurple.withOpacity(0.5),
                    AppColors.divMedsColorWhite,
                     AppColors.divMedsColorWhite,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                'Enhance Your Learning with Clubs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  // shadows: [
                  //   Shadow(
                  //     offset: Offset(2, 2),
                  //     blurRadius: 3.0,
                  //     color: Colors.black38,
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredClubs.length,
                  itemBuilder: (context, index) {
                    return ClubCard(club: filteredClubs[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Club {
  final String name;
  final String description;
  final int members;
  final String imageUrl;

  Club({
    required this.name,
    required this.description,
    required this.members,
    required this.imageUrl,
  });
}

class ClubCard extends StatelessWidget {
  final Club club;

  ClubCard({required this.club});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Hero(
                      tag: club.imageUrl,
                      child: Image.asset(
                        club.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.divMedsColorBlue1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    club.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle join action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.divMedsColorWhite, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          textStyle: TextStyle(fontSize: 14),
                        ),
                        // icon: Icon(Icons.add, size: 16),
                        label: Text('Join', style: TextStyle(fontSize: 16),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
