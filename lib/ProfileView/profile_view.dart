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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 50),

            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[
                      300], 
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                        ),
                      ),
                    ),

                    SizedBox(height: 10), // Empty Space

                    SizedBox(
                      width: 200,
                      height: 20,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                        ),
                      ),
                    ),

                    SizedBox(height: 10), // Empty Space

                    SizedBox(
                      width: 200,
                      height: 20,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ])
            ]),
            // Profile Picture

            const SizedBox(height: 80), // Empty Space

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement Log Out functionality
                    // You can handle log out logic here
                  },
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20), // Adjust padding for size
                  ),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.red)),
                ),

                const SizedBox(height: 10), // Empty Space

                ElevatedButton(
                  onPressed: () {
                    // Implement Log Out functionality
                    // You can handle log out logic here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20), // Adjust padding for size
                  ),
                  child: const Text('Settings',
                      style: TextStyle(color: Colors.red)),
                ),

                const SizedBox(height: 10), // Empty Space

                ElevatedButton(
                  onPressed: () {
                    // Navigate to Settings screen
                    // You can implement the navigation logic here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20), // Adjust padding for size
                  ),
                  child: const Text('Log Out',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            )
          ]),
        ));
  }
}
