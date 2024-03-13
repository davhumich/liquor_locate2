
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Models/drink_model.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';

Future<List<Drink>> initDrinks () async {
    List<Drink> drinks = [];
    try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('drinks').get();

        querySnapshot.docs.forEach((DocumentSnapshot doc) {

        String id = doc.id;
        String img = doc['img'];
        String name = doc['Name'];
        String size = doc['Size'];

      
          drinks.add(Drink(id, size, img, name)); 
        });
    }
    catch(e){
       print('Error fetching drinks: $e');
    }
    return drinks;

           
}