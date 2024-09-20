import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';

class MedToolsScreen extends StatefulWidget {
  final String token;
  final String loggedInUserId;

  const MedToolsScreen({
    Key? key,
    required this.token,
    required this.loggedInUserId,
  }) : super(key: key);

  @override
  _MedToolsScreenState createState() => _MedToolsScreenState();
}

class _MedToolsScreenState extends State<MedToolsScreen> {
  final TextEditingController _searchController = TextEditingController();

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        autocorrect: false,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for medicines...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            // Implement the search functionality here
          }
        },
      ),
    );
  }

  Widget _buildBoxContainer({required String title, required IconData icon, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        width: MediaQuery.of(context).size.width * 0.9, // Adjust width for full width container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: AppColors.divMedsColorBlue1),
            const SizedBox(width: 8),
            Expanded( // Use Expanded to prevent overflow
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  _buildSearchBar(),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
         
            _buildBoxContainer(
              title: 'Drugs Interaction Checker',
              icon: Icons.medical_services_outlined,
              onTap: () {
                // Navigate to Drugs Interaction Checker Screen
              },
            ),
            _buildBoxContainer(
              title: 'Prescription Maker',
              icon: Icons.receipt_long_outlined,
              onTap: () {
                // Navigate to Prescription Maker Screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
