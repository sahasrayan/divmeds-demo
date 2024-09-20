// import 'package:divmeds/core/api/api.url.dart';
// import 'package:divmeds/features/auth/repositories/user_repo.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/profile_back.dart';
// import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/components/profile_front.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';

// import 'package:divmeds/features/auth/models/user.model.dart';

// class ProfileHeader extends StatelessWidget {
//   final User user;
//   const ProfileHeader({
//     super.key,
//     required this.user,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Center(
//         child: FlipCard(
//           direction: FlipDirection.HORIZONTAL,
//           front: ProfileFront(user: user, token: Config.token, userRepository: UserRepository(serverUrl: Config.serverUrl),),
//           back: ProfileBack(user:user),
//         ),
//       ),
//     );
//   }
// }
