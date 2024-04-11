import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> isStoreInFavorites(String userId, String storeId) async {
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

    bool isFavorite = favoriteStores.contains(storeId);
    return isFavorite;
  } catch (error) {
    print("Failed to check if store is in favorites: $error");
    return false;
  }
}
