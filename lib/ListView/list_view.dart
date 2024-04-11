// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquor_locate2/Functions/calculate_average_price.dart';
import 'package:liquor_locate2/Functions/drink_to_id.dart';
import 'package:liquor_locate2/Functions/favorite_get.dart';
import 'package:liquor_locate2/Functions/init_list_view.dart';
import 'package:liquor_locate2/globals.dart';

// External packages from pub.dev
import 'package:dropdown_button2/dropdown_button2.dart';

// Internal files located in this directory
import 'package:liquor_locate2/StoreViews/condensed_store_view.dart';

// (ListView is already a flutter class, so we should use ListScreen as to not mix up the two)
class ListScreen extends StatefulWidget {
  const ListScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<ListScreen> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  late List<String> storeIds;
  late String userId;
  late List<String> favStores;
  late List<String> items;
  String? selectedValue;
  late double avgPrice;
  late String drinkId;
  late String sortBy;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    items = [
      'Beer',
      'Wine',
      'Vodka',
      'Whiskey',
      'Seltzer',
    ];
    selectedValue = "Beer";
    avgPrice = 0.0;
    drinkId = "13Dclb3TMT1SgvVhLvnc";
    sortBy = "Distance";
  }

  Future<String> storeInit() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
    userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    storeIds = await initListViewIds(sortBy, drinkId);
    avgPrice = await calculateAveragePrice(drinkId);
    favStores = await getFavoriteStores(userId);

    // Reorder the storeIds list to show favorite stores first
    List<String> favoriteStores = [];
    List<String> otherStores = [];
    for (var storeId in storeIds) {
      if (favStores.contains(storeId)) {
        favoriteStores.add(storeId);
      } else {
        otherStores.add(storeId);
      }
    }
    storeIds = [...favoriteStores, ...otherStores];

    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stores",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 236, 87, 95),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: storeInit(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(top: 80),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ClipPath(
                                clipper: WaveClipperOne(flip: true),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 40, left: 20, right: 10, top: 10),
                                  height: 130,
                                  color:
                                      const Color.fromARGB(255, 255, 231, 231),
                                  child: Row(
                                    children: [
                                      if (selectedValue == "Beer")
                                        const Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/Coronas.png')),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "6 Pack of Corona",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            )
                                          ],
                                        ),
                                      // Add conditions for other selected values here
                                      const Spacer(),
                                      Column(
                                        children: [
                                          const Text(
                                            "Avg:  ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(right: 20),
                                            child: Text(
                                                "\$${avgPrice.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // List of stores
                              for (var storeId in storeIds)
                                Column(
                                  children: [
                                    CondensedStoreView(
                                      storeId: storeId,
                                      drinkId: drinkId,
                                      avgPrice: avgPrice,
                                      userId: userId,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ));
                  }
                }
              }),

          // Search bar and sort button
          Container(
            color: const Color.fromARGB(255, 255, 231, 231),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width - 80,
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
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'What are you looking for...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                          drinkId = drinkToId(value!);
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
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
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    icon: const Icon(Icons.sort),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              "Sort by Distance",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const PopupMenuItem<int>(
                          padding: EdgeInsets.all(0),
                          height: 1,
                          value: 2,
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              "Sort by Price",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                        setState(() {
                          sortBy = "Distance";
                        });
                      }
                      if (value == 1) {
                        setState(() {
                          sortBy = "Price";
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
