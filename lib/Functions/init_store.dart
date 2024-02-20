
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<Store> initStore (String storeId) async {
    Store store = Store.empty();
    try {
        CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');
        DocumentSnapshot storeSnapshot = await storesCollection.doc(storeId).get();

        if (storeSnapshot.exists){
          String logoString = "";

            store.name = storeSnapshot['Name'];
            store.rating = storeSnapshot["StarRating"];
            store.address = storeSnapshot["Address"];

            logoString = storeSnapshot["Image"];

            final storageRef = FirebaseStorage.instance.ref();

            final imageUrl = await storageRef.child(logoString).getDownloadURL();

            store.logo = Image.network(imageUrl);
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