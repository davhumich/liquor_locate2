/*

Model for a Store

*/

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Store {

  String id = "";
  String name = "";
  String address = "";
  double rating = 0;
  Image logo = Image.asset("lib/assets/testLogo.jpg");
  Position location = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, altitudeAccuracy: 0, heading: 0, headingAccuracy: 0, speed: 0, speedAccuracy: 0);
  
  Store(this.id, this.name, this.address, this.rating, this.logo, this.location);

  Store.empty();
}