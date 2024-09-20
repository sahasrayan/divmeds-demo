import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/models/dummy_user.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/ui/explore_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/jobs/ui/jobs_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/clubs/ui/clubs_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/ui/explorescreen_old.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/home/ui/home%20screen/home_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/post/ui/post_button.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/profilesection.user.dart';


class BottomNavigationBarItems extends StatefulWidget {
  final User user;

  const BottomNavigationBarItems({
    super.key,
    required this.user,
  });

  @override
  State<BottomNavigationBarItems> createState() => _BottomNavigationBarItemsState();
}

class _BottomNavigationBarItemsState extends State<BottomNavigationBarItems> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    print('BottomNavigationBarItems initialized with user: ${widget.user.userId}');
    _screens = [
      HomeScreen(user: user),
      ExploreScreen(
        loggedInUserId: user.userId,
        token: Config.token,
      ),
      JobsHomeScreen(),
      ClubsScreen(),
      ProfileSectionUserOwn(user: user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 60,
        color: AppColors.divMedsColorWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home_outlined, index: 0, label: 'Home'),
            _buildNavItem(icon: Icons.explore_outlined, index: 1, label: 'Explore'),
            _buildNavItem(icon: Icons.work_outline, index: 2, label: 'Jobs'),
            _buildNavItem(icon: Icons.people_alt_outlined, index: 3, label: 'Clubs'),
            _buildNavItem(icon: Icons.person_outline_sharp, index: 4, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index, required String label}) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.divMedsColorBlueScaffoldBackground : Colors.black;

    return GestureDetector(
      onTap: () => _navigateBottomBar(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
