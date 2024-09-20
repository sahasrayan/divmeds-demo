import 'package:divmeds/designs/app_icons.dart';
import 'package:divmeds/features/auth/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';

class SettingsPage extends StatelessWidget {
  final AuthRepository authRepository;
  final String token;
  final UserRepository userRepository;

  const SettingsPage({
    super.key,
    required this.authRepository,
    required this.token,
    required this.userRepository,
  });

  void _whatsDirectMessage(BuildContext context) async {
    final Uri url = Uri.parse('https://www.whatsapp.com/channel/0029VaSRKJq7NoZxQRwsU40w');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link. Please try again later.')),
      );
    }
  }

  void _whatsAppLinkJoin(BuildContext context) async {
    final Uri url = Uri.parse('https://www.whatsapp.com/channel/0029VaSRKJq7NoZxQRwsU40w');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link. Please try again later.')),
      );
    }
  }

  Future<void> _logout(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout functionality coming soon!')),
    );
  }

  Future<void> _shareProfile(BuildContext context) async {
    try {
      await userRepository.shareUserProfile(token);
      final userProfileUrl = '${userRepository.serverUrl}/me';
      final message = 'Join DivMeds with me! Check out my profile: $userProfileUrl';
      Share.share(message);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsTile(
            context,
            title: 'Message Us',
            imageIcon: ImageIcon(AssetImage(AppIcons.contactUs)),
            onTap: () => _whatsDirectMessage(context),
          ),
          _buildSettingsTile(
            context,
            title: 'Join Whatsapp Channel',
            imageIcon: ImageIcon(AssetImage(AppIcons.whatsapp)),
            onTap: () => _whatsAppLinkJoin(context),
          ),
          _buildSettingsTile(
            context,
            title: 'Share Profile',
            icon: Icon(Icons.share),
            onTap: () => _shareProfile(context),
          ),
          _buildSettingsTile(
            context,
            title: 'Logout',
            icon: Icon(Icons.logout),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    Icon? icon,
    ImageIcon? imageIcon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: imageIcon ?? icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
