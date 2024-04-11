import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getFavoriteStores(String userId) async {
  try {
    List<String> favoriteStores = [];

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((userSnapshot) {
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data()!;
        if (userData.containsKey('favoriteStores')) {
          favoriteStores = List<String>.from(userData['favoriteStores']);
        }
      }
    }, onError: (error) {
      print("Error retrieving favorite stores: $error");
    });
    print(favoriteStores);
    return favoriteStores;
  } catch (error) {
    print("Failed to get favorite stores: $error");
    return [];
  }
}
