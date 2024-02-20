/*

Model for a Store

*/

import 'package:flutter/material.dart';

class Store {

  String id = "";
  String name = "";
  String address = "";
  double rating = 0;
  Image logo = Image.asset("lib/assets/testLogo.jpg");
  
  Store(this.id, this.name, this.address, this.rating, this.logo);

  Store.empty();
}