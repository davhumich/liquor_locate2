import 'package:flutter/material.dart';
import 'package:liquor_locate2/CartView/store_cart_view.dart';

class TotalPricesView extends StatelessWidget {
  const TotalPricesView({super.key, required this.numberDrinksSelected});
  // 0 if not selected
  final List<int> numberDrinksSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 236, 87, 95),
        ),
        body: SingleChildScrollView(
          child:Column(
          children: [
            for (var storeId in [
              "4jzwzudEmlcNbTQMR2Sl",
              "AXHqSDExs8FUkNCjcZ8K",
              "aimeGAEFhlUmzty9ERYI",
              "nKmCb07Heh32gMgdonXc",
              "sGHiRnmXimv1tMb2Q11c"
            ])
              StoreCartView(
                  storeId: storeId, numberDrinks: numberDrinksSelected)
          ],
        ) ,
        )
        );
  }
}
