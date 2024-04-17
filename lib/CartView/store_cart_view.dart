import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/caculate_drink_prices_array.dart';
import 'package:liquor_locate2/Functions/calculate_distance.dart';
import 'package:liquor_locate2/Functions/drink_value_to_index.dart';
import 'package:liquor_locate2/Functions/init_store.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:liquor_locate2/Placeholder%20Skeletons/condensed_store_placeholder.dart';

class StoreCartView extends StatefulWidget {
  const StoreCartView(
      {super.key, required this.storeId, required this.numberDrinks});
  final String storeId;
  final List<int> numberDrinks;

  @override
  State<StoreCartView> createState() => _StoreCartView();
}

class _StoreCartView extends State<StoreCartView> {
  late String storeId;
  late List<int> numberDrinks;
  late Store store;
  late List<double> drinksPricesArray;
  late List<double> finalArray = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];

  @override
  void initState() {
    super.initState();
    storeId = widget.storeId;
    numberDrinks = widget.numberDrinks;
  }

  Future<String> storeCartViewInit() async {
    store = await initStore(storeId);
    drinksPricesArray = await calculateDrinkPricesArray(storeId);
    for (var i = 0; i < 35; ++i) {
      finalArray[i] = numberDrinks[i] * drinksPricesArray[i];
    }
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: storeCartViewInit(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CondensedStorePlaceholder();
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                margin: const EdgeInsets.only(bottom: 6),
                child: ExpandedTile(
                  theme: const ExpandedTileThemeData(
                    contentBackgroundColor: Color.fromARGB(255, 244, 244, 244),
                      headerRadius: 0,
                      headerPadding: EdgeInsets.only(
                          left: 0, right: 20, top: 10, bottom: 10),
                      contentPadding: EdgeInsets.only(
                          left: 30, right: 20, top: 10, bottom: 10),
                      contentRadius: 12.0),
                  controller: ExpandedTileController(),
                  title: Row(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(store.name, style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,),
                          ),
                          FutureBuilder<String>(
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
                          Row(
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
                        ],
                      ),
                      const Spacer(),
                      Text("\$${finalArray.reduce((a, b) => a + b).toStringAsFixed(2)}", style: const TextStyle(fontSize: 18),)
                    ],
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 35; ++i)
                        Column(
                          children: [
                            if (numberDrinks[i] != 0)
                              Text("${drinkIndexToValue(i)}:    \$${drinksPricesArray[i].toStringAsFixed(2)}   x   ${numberDrinks[i].toStringAsFixed(0)}   =   \$${(drinksPricesArray[i] * numberDrinks[i]).toStringAsFixed(2)}", style: const TextStyle(fontSize: 16),)
                          ],
                        ),
                        Text(" = \$${finalArray.reduce((a, b) => a + b).toStringAsFixed(2)}", style: const TextStyle(fontSize: 16),)
                    ],
                  ),
                  onTap: () {},
                  onLongTap: () {},
                ),
              ),
                  ],
                ),
              );
              
              
            }
          }
        });
  }
}
