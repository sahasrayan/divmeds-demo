import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';

class JobsHomeScreen extends StatefulWidget {
  @override
  _JobsHomeScreenState createState() => _JobsHomeScreenState();
}

class _JobsHomeScreenState extends State<JobsHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Job> allJobs = [
    Job(
      title: 'General Physician',
      company: 'XYZ Hospitals',
      location: 'Chennai, India',
      description: 'Provide primary care to patients, manage chronic conditions, and prescribe medications as necessary.',
      salary: '₹60,000 - ₹80,000 per month',
      type: 'Full-Time',
    ),
    Job(
      title: 'Registered Nurse',
      company: 'XYZ Healthcare',
      location: 'Mumbai, India',
      description: 'Provide nursing care to patients, assist in surgeries, and ensure patient safety and comfort.',
      salary: '₹30,000 - ₹50,000 per month',
      type: 'Part-Time',
    ),
    Job(
      title: 'Pharmacist',
      company: 'ABC Pharma',
      location: 'Bangalore, India',
      description: 'Dispense medications, counsel patients on drug use, and manage inventory.',
      salary: '₹40,000 - ₹55,000 per month',
      type: 'Full-Time',
    ),
    Job(
      title: 'Lab Technician',
      company: 'HealthCheck Labs',
      location: 'Hyderabad, India',
      description: 'Perform diagnostic tests, prepare specimens, and maintain lab equipment.',
      salary: '₹25,000 - ₹35,000 per month',
      type: 'Contract',
    ),
    Job(
      title: 'Medical Assistant',
      company: 'Wellness Clinic',
      location: 'Pune, India',
      description: 'Assist doctors during examinations, record patient information, and manage administrative tasks.',
      salary: '₹20,000 - ₹30,000 per month',
      type: 'Full-Time',
    ),
    Job(
      title: 'Physical Therapist',
      company: 'Healthy Life Center',
      location: 'Kolkata, India',
      description: 'Help patients recover from injuries through physical exercises and therapy.',
      salary: '₹35,000 - ₹50,000 per month',
      type: 'Part-Time',
    ),
    Job(
      title: 'Dietitian',
      company: 'Nutrition Plus',
      location: 'Delhi, India',
      description: 'Create nutritional plans for patients, conduct health assessments, and provide dietary advice.',
      salary: '₹45,000 - ₹60,000 per month',
      type: 'Full-Time',
    ),
  ];

  List<Job> filteredJobs = [];

  @override
  void initState() {
    super.initState();
    filteredJobs = allJobs;
  }

  void _filterJobs(String query) {
    setState(() {
      filteredJobs = allJobs
          .where((job) =>
              job.title.toLowerCase().contains(query.toLowerCase()) ||
              job.company.toLowerCase().contains(query.toLowerCase()) ||
              job.location.toLowerCase().contains(query.toLowerCase()))
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
          hintText: 'Search for jobs...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          _filterJobs(value);
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: filteredJobs.length,
          itemBuilder: (context, index) {
            return JobCard(job: filteredJobs[index]);
          },
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.divMedsColorBlue2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              job.company,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              job.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Icon(Icons.attach_money, color: Color(0xFF2A9D8F), size: 16),
                      SizedBox(width: 4),
                      Text(
                        job.salary,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A9D8F),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.work, color: Color(0xFF457B9D), size: 16),
                    SizedBox(width: 4),
                    Text(
                      job.type,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF457B9D),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String location;
  final String description;
  final String salary;
  final String type;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.salary,
    required this.type,
  });
}
