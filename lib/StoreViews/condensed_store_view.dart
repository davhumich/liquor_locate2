/*

condensed_store_view.dart

This is the view for the small store views that are displayed
on the list view and the map view

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/init_price.dart';
import 'package:liquor_locate2/Functions/init_store.dart';
import 'package:liquor_locate2/Functions/price_to_color.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:liquor_locate2/Functions/calculate_distance.dart';
import 'package:liquor_locate2/Placeholder%20Skeletons/condensed_store_placeholder.dart';
import 'package:liquor_locate2/StoreViews/expanded_store_view.dart';

class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView(
      {super.key,
      required this.storeId,
      required this.drinkId,
      required this.avgPrice});

  // These are the varibles we input to the view so it will load with different stores
  // (Eventually we will only input a store id and load it from the database directly from this view)
  final String storeId;
  final String drinkId;
  final double avgPrice;

  @override
  State<CondensedStoreView> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStoreView> {
  // The variables initialzed in the actual view
  // (The reason they are late is because they are initialzed in initState, which is called after the widget loads)
  late String storeId;
  late Store store;
  late String drinkId;
  late double drinkPrice;
  late double avgPrice;
  late Color priceColor;

  // This function takes the variables inputed above and initialzes them in this state
  @override
  void initState() {
    super.initState();
    storeId = widget.storeId;
    drinkId = widget.drinkId;
    avgPrice = widget.avgPrice;
  }

  Future<String> storeIdInit() async {
    store = await initStore(storeId);
    drinkPrice = await initPrice(storeId, drinkId);
    priceColor = priceToColor(drinkPrice, avgPrice);
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    // This InkWell object makes it so when the user taps on this view,
    // they will be taken to the expanded store view
    storeId = widget.storeId;
    drinkId = widget.drinkId;
    avgPrice = widget.avgPrice;
    return FutureBuilder(
        future: storeIdInit(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CondensedStorePlaceholder();
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return InkWell(
                onTap: () {
                  // Pushes the Expanded store view onto the Widget Stack
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Const for now, will enevtually need to input the store id, so it can load the actual store data
                      builder: (BuildContext context) => ExpandedStoreView(
                        storeId: storeId,
                        storeName: store.name,
                      ),
                    ),
                  );
                },
                child: Container(
                  // This is the outside container used to contain the view
                  height: 98,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                            ),
                            child: ClipOval(
                                child: SizedBox.fromSize(
                              size: const Size.fromRadius(48), // Image radius
                              child: store.logo,
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
                              child: Text(store.name, style: const TextStyle(fontSize: 16),),
                            ),
                            Expanded(
                              child: FutureBuilder<String>(
                                future: getDistance(store.location),
                                builder: (context, distanceSnapshot) {
                                  if (distanceSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text(
                                        "Calculating distance...");
                                  } else if (distanceSnapshot.hasError) {
                                    return SizedBox(
                                      width: 100,
                                      child: Text(
                                        'Error: ${distanceSnapshot.error}',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      padding: const EdgeInsets.only(top: 2),
                                      width: 200,
                                      child: Text(
                                        distanceSnapshot.data ??
                                            'Unknown distance',
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: store.rating,
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
                                      store.rating.toString(),
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
                      // Price
                      if (avgPrice > 0)
                      Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "\$${drinkPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 18, color: priceColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }
}
