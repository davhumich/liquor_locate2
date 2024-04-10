import 'package:cloud_firestore/cloud_firestore.dart';

void addToFavorites(String userId, String storeId) {
  
FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .update({
        'favoriteStores': FieldValue.arrayUnion([storeId]),
      })
  .then((value) {
        print("Store added to favoriteStores array successfully");
      })
      .catchError((error) {
        print("Failed to add store to favoriteStores array: $error");
      });

  }
