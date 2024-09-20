import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/silver_app_bar_delegate.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: CustomSliverAppBarDelegate(
        TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'About'),
            Tab(text: 'Posts'),
            Tab(text: 'Discussions'),
            Tab(text: 'Saved'),
          ],
        ),
      ),
      pinned: true,
    );
  }
}









// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/silver_app_bar_delegate.dart';
// import 'package:flutter/material.dart';



// class CustomTabBar extends StatelessWidget {
//   const CustomTabBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverPersistentHeader(
//       delegate: CustomSliverAppBarDelegate(
//         TabBar(
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           tabs: [
//             Tab(text: 'Posts'),
//             Tab(text: 'Discussions'),
//           ],
//         ),
//       ),
//       pinned: true,
//     );
//   }
// }
