/*

profile_view.dart

This is the view for the profile tab, will be static to start, 
but once database initialized, should change by user.

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// (Stateful widget because eventually the data will need to chnage based on what user is signed in)
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  // This is the actual widget that creates the interface
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFE306),
      child: const Center(
        child: Text("Profile View"),
      ),
    );
  }
}
