import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/silver_app_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';  // Ensure you have the correct imports

class CustomOutsiderTabBar extends StatelessWidget {
  final TabController controller;  // Add TabController to manage tab states

  const CustomOutsiderTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverAppBarDelegate(
        TabBar(
          controller: controller,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Discussions'),
          ],
        ),
      ),
    );
  }
}
