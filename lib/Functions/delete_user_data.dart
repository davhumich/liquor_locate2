// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteUserData(String userId) async {
  // remove user from all following arrays in other user objects

  FirebaseFirestore.instance.collection('users').get().then(
        (value) => value.docs.forEach(
          (element) {
            var docRef =
                FirebaseFirestore.instance.collection('users').doc(element.id);

            docRef.update({
              'userFollowingList': FieldValue.arrayRemove([userId])
            });
          },
        ),
      );

  // remove user from all follower arrays in other user objects

  FirebaseFirestore.instance.collection('users').get().then(
        (value) => value.docs.forEach(
          (element) {
            var docRef =
                FirebaseFirestore.instance.collection('users').doc(element.id);

            docRef.update({
              'userFollowerList': FieldValue.arrayRemove([userId])
            });
          },
        ),
      );

  // remove all user posts

  FirebaseFirestore.instance
      .collection('posts')
      .where("postUser", isEqualTo: userId)
      .get()
      .then(
        (value) => value.docs.forEach(
          (element) {
            var docRef =
                FirebaseFirestore.instance.collection('posts').doc(element.id);

            docRef.delete();
          },
        ),
      );

  // remove all user comments

  FirebaseFirestore.instance
      .collection('comments')
      .where("commentUser", isEqualTo: userId)
      .get()
      .then(
        (value) => value.docs.forEach(
          (element) {
            var docRef = FirebaseFirestore.instance
                .collection('comments')
                .doc(element.id);

            docRef.delete();
          },
        ),
      );

  // remove user from user has badge

  FirebaseFirestore.instance
      .collection('user_has_badge')
      .doc(userId)
      .delete();

  // remove user from user has drinkMap

  FirebaseFirestore.instance
      .collection('user_has_drinkMap')
      .doc(userId)
      .delete();

  // remove user from user has statistics

  FirebaseFirestore.instance
      .collection('user_has_statistics')
      .doc(userId)
      .delete();

  // remove user data from users collection

  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .delete();
}
