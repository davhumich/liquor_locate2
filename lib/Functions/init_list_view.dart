import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> initListViewIds() async {
  List<String> storeIds = [];
  
    FirebaseFirestore.instance.collection("stores").get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          storeIds.add(docSnapshot.id);
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
  return storeIds;
}
