
import 'package:cloud_firestore/cloud_firestore.dart';

Future<double> initPrice(String storeId, String drinkId) async {
  double price = 0;

  await FirebaseFirestore.instance.collection("prices").where("storeId", isEqualTo: storeId).where("drinkId", isEqualTo: drinkId).get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          price = docSnapshot.data()["Price"];
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    return price;
}