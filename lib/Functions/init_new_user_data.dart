import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> initNewUserData(
    String userId, String username, String firstName, String lastName) async {
  // Init user document

  Map<String, dynamic> userDoc = {};

  userDoc["favoriteStores"] = [];
  userDoc["firstName"] = firstName;
  userDoc["lastName"] = lastName;
  userDoc["userName"] = username;

  await FirebaseFirestore.instance.collection("users").doc(userId).set(userDoc);

}
