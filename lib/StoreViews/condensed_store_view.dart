/*

condensed_store_view.dart

This is the view for the small store views that are displayed
on the list view and the map view

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView(
      {super.key,
      required this.storeImagePath,
      required this.storeName,
      required this.storeMilage,
      required this.storeRating,
      required this.price,
      required this.color});

  // These are the varibles we input to the view so it will load with different stores
  // (Eventually we will only input a store id and load it from the database directly from this view)
  final String storeImagePath;
  final String storeName;
  final String storeMilage;
  final double storeRating;
  final double price;
  final Color color;

  @override
  State<CondensedStoreView> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStoreView> {

  // The variables initialzed in the actual view 
  // (The reason they are late is because they are initialzed in initState, which is called after the widget loads)
  late String storeImagePath;
  late String storeName;
  late String storeMilage;
  late double storeRating;
  late double price;
  late Color color;

  // This function takes the variables inputed above and initialzes them in this state
  @override
  void initState() {
    super.initState();
    storeImagePath = widget.storeImagePath;
    storeName = widget.storeName;
    storeMilage = widget.storeMilage;
    storeRating = widget.storeRating;
    price = widget.price;
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // This is the outside container used to contain the view
      height: 98,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // Store image Widget
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: ClipOval(
                    child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image(image: AssetImage(storeImagePath)),
                ))),
          ),
          Container(
            // Store name, milage and rating
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(storeName),
                ),
                Expanded(
                  child: Text(storeMilage),
                ),
                Expanded(
                  child: Row(
                    children: [
                      RatingBarIndicator(
                        rating: storeRating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          storeRating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          // Drink logo (Hard coded as titos for now, but will need to change)
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.only(right: 10),
            child: const Image(image: AssetImage('lib/assets/titos.png')),
          ),
          // Price
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "\$$price",
              style: TextStyle(fontSize: 18, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
