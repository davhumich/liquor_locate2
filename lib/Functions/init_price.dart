
import 'package:cloud_firestore/cloud_firestore.dart';

Future<double> initPrice(String storeId, String drinkId) async {
  double price = 0;

  await FirebaseFirestore.instance.collection("stores").doc(storeId).get().then(
      (querySnapshot) async {
          price = querySnapshot.data()?[drinkId];
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return price;
}