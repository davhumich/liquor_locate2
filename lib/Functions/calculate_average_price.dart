
import 'package:cloud_firestore/cloud_firestore.dart';

Future<double> calculateAveragePrice(String drinkId) async {
  double price = 0;

  await FirebaseFirestore.instance.collection("stores").get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          price += docSnapshot.data()[drinkId];
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return price / 5;
}