/*

View to display the settings

*/

//Internal Files
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

//External Packages
import 'package:flutter/material.dart';

//Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquor_locate2/ProfileView/settings_delete_account.dart';
import 'package:liquor_locate2/ProfileView/settings_edit_profile.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView(
      {super.key,
      required this.userId,
      required this.profilePic,
      required this.headerImage,
      required this.username,
      required this.firstName,
      required this.lastName});
  final String username;
  final String userId;
  final AssetImage profilePic;
  final AssetImage headerImage;
  FirebaseAuth auth = FirebaseAuth.instance;
  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 236, 87, 95),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromARGB(255, 170, 164, 164), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image(image: profilePic),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                username,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SettingsEditProfileView(userId: userId, selectedProfilePicImage: profilePic, firstName: firstName, lastName: lastName),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 170, 164, 164),
                            width: 0.1),
                        color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 61, 61, 61) : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light)
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(CupertinoIcons.pencil),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 170, 164, 164),
                          width: 0.1),
                      color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 61, 61, 61) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light)
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SettingsDeleteAccountView(username: "usernameTemp", userId: userId)
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 202, 72, 63) : const Color.fromARGB(255, 153, 42, 35),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Delete Account",
                            style: TextStyle(
                              fontSize: 16,
                              color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 221, 89, 79) : const Color.fromARGB(255, 153, 42, 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 170, 164, 164),
                          width: 0.1),
                      color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 61, 61, 61) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light)
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        auth.signOut();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 123, 186, 237) :const Color.fromARGB(255, 20, 90, 147),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 16,
                              color: SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? const Color.fromARGB(255, 123, 186, 237) :const Color.fromARGB(255, 20, 90, 147),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
