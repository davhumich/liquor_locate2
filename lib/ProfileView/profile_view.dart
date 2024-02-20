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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile View",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 236, 87, 95),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement Log Out functionality
                  // You can handle log out logic here
                },
                child: Text('Edit Profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement Log Out functionality
                  // You can handle log out logic here
                },
                child: Text('Log Out'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Settings screen
                  // You can implement the navigation logic here
                },
                child: Text('View Settings'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement Delete Account functionality
                  // You can handle account deletion logic here
                },
                child: Text('Delete Account'),
              ),
            ],
        )
      ),
    );
  }
}
