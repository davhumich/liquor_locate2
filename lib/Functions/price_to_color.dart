
import 'package:flutter/material.dart';

Color priceToColor(double drinkPrice, double avgPrice){
  double biggerThreshhold = avgPrice * 1.1;
  double smallerThreshold = avgPrice / 1.1;
  if (drinkPrice > biggerThreshhold){
    return Colors.red;
  } else if (drinkPrice < smallerThreshold){
    return Colors.green;
  } else {
    return const Color.fromARGB(255, 169, 156, 40);
  }
}