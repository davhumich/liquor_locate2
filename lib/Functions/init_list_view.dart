import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquor_locate2/Functions/calculate_distance.dart';

Future<List<String>> initListViewIds(String sortBy, String drinkId) async {
  List<String> storeIds = [];
  
    await FirebaseFirestore.instance.collection("stores").get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          storeIds.add(docSnapshot.id);
        }
      },
      // ignore: avoid_print
      onError: (e) => print("Error completing: $e"),
    );
    if (sortBy == "Distance"){
      return sortByDistance(storeIds);
    } else {
      return sortByPrice(storeIds, drinkId);
    }
}

Future<List<String>> sortByDistance(List<String> storeIds) async{
  final CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');

  QuerySnapshot querySnapshot = await storesCollection.get();
  Map<String, double> storeDistances = {};

  querySnapshot.docs.forEach((DocumentSnapshot document) {
    if (document.exists) {
      String storeId = document.id;
      if (storeIds.contains(storeId)){
        GeoPoint geoPoint = document["StorePosition"];
        double distance = getDistanceDouble(Position(longitude: geoPoint.longitude, latitude: geoPoint.latitude, timestamp: DateTime.now(), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0));
        storeDistances[storeId] = distance;
      }
    }
  });

  List<MapEntry<String, double>> distanceList = storeDistances.entries.toList();
  distanceList.sort((a, b) => a.value.compareTo(b.value));
  List<String> sortedStoreIds = distanceList.map((entry) => entry.key).toList();
  return sortedStoreIds;

}

Future<List<String>> sortByPrice(List<String> storeIds, String drinkId) async{
  var storesCollection = FirebaseFirestore.instance.collection('prices').where("drinkId", isEqualTo: drinkId);

  QuerySnapshot querySnapshot = await storesCollection.get();
  Map<String, double> storePrices = {};

  querySnapshot.docs.forEach((DocumentSnapshot document) {
    if (document.exists) {
      String storeId = document["storeId"];
      if (storeIds.contains(storeId)){
        double price = document["Price"];
        storePrices[storeId] = price;
      }
    }
  });

  List<MapEntry<String, double>> distanceList = storePrices.entries.toList();
  distanceList.sort((a, b) => a.value.compareTo(b.value));
  List<String> sortedStoreIds = distanceList.map((entry) => entry.key).toList();
  return sortedStoreIds;
}
