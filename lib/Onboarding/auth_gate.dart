/*

Gate to determine of a user is signed in or not.
If the user is signed in will direct to home view with current user id,
else will direct to sign in screen.

*/

//Internal Files
import 'package:liquor_locate2/main.dart';

//External Files
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Onboarding/login_signup_view.dart';

// ignore: must_be_immutable
class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  String uid = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //User is not signed in
        if (!snapshot.hasData) {
          return const LoginSignupView();
        }
        //User is signed in
        return TabView(currentUserId: FirebaseAuth.instance.currentUser!.uid, title: 'Liquor Locate Home View',);
      },
    );
  }
}
