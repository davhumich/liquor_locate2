
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

Future<Store> initStore (String storeId) async {
    Store store = Store.empty();
    try {
        CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');
        DocumentSnapshot storeSnapshot = await storesCollection.doc(storeId).get();

        if (storeSnapshot.exists){
          String logoString = "";
            store.id = storeSnapshot.id;
            store.name = storeSnapshot['Name'];
            store.rating = storeSnapshot["StarRating"];
            store.address = storeSnapshot["Address"];

            logoString = storeSnapshot["Image"];

            final storageRef = FirebaseStorage.instance.ref();

            final imageUrl = await storageRef.child(logoString).getDownloadURL();

            store.logo = Image.network(imageUrl);

            GeoPoint geoPoint = storeSnapshot["StorePosition"];
            store.location = Position(longitude: geoPoint.longitude, latitude: geoPoint.latitude, timestamp: DateTime.now(), accuracy: 0, altitude: 0, altitudeAccuracy: 0, speed: 0, speedAccuracy: 0, heading: 0, headingAccuracy: 0);
  
        }
        else{
            store.name = "Store Not Found";
        }

    }
    catch(e){
        store.name = 'Error initializing store: $e';
    }
    return store;
}