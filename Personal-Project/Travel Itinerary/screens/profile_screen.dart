import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/profile_picture.png'),
          ),
          SizedBox(height: 20),
          ProfileCard(
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {},
          ),
          ProfileCard(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {},
          ),
          ProfileCard(
            icon: Icons.support,
            title: 'Support',
            onTap: () {},
          ),
          ProfileCard(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
