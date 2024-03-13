/*

list_view.dart

The view for the list tab, only contains UI, interactactivity with firebase
should take place in an external file

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Functions/calculate_average_price.dart';
import 'package:liquor_locate2/Functions/drink_to_id.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquor_locate2/Functions/init_list_view.dart';
import 'package:liquor_locate2/globals.dart';

// External packages from pub.dev
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// Internal files located in this directory
import 'package:liquor_locate2/StoreViews/condensed_store_view.dart';

// (ListView is already a flutter class, so we should use ListScreen as to not mix up the two)
class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  late List<String> storeIds;

  final List<String> items = [
    'Beer',
    'Wine',
    'Vodka',
    'Whiskey',
    'Seltzer',
  ];
  String? selectedValue = "Beer";
  late double avgPrice;
  String drinkId = "13Dclb3TMT1SgvVhLvnc";

  String sortBy = "Distance";

  Future<String> storeInit() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
    {
        await Geolocator.requestPermission();
    }
    userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
      storeIds = await initListViewIds(sortBy, drinkId);
    avgPrice = await calculateAveragePrice(drinkId);
    
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The AppBar builds the top bar
        title: const Text(
          "Stores",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 236, 87, 95),
      ),
      body: Stack(
        // (Using a stack here so the search bar doesn't push the other widgets down when it is expanded)
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
                        margin: const EdgeInsets.only(top: 60),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ClipPath(
                                // ClipPath is an external package we used for the red wave border at the top of the view
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
                                      if (selectedValue == "Wine")
                                        const Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/Barefoot.png')),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "Bottle of Barefoot",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            )
                                          ],
                                        ),
                                      if (selectedValue == "Vodka")
                                        const Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/titos.png')),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "Fifth of Titos",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            )
                                          ],
                                        ),
                                      if (selectedValue == "Whiskey")
                                        const Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/fireball.png')),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "Fifth of Fireball",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (selectedValue == "Seltzer")
                                        const Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/whiteClaw.png')),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                "6 Pack of White Claws",
                                                maxLines: 2,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                        child: Text("\$" + avgPrice.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 22,
                                            )),
                                      ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // This is where the list of stores begin
                              for (var storeId in storeIds)
                                Column(
                                  children: [
                                    CondensedStoreView(
                                        storeId: storeId, drinkId: drinkId, avgPrice: avgPrice,),
                                    const Divider(
                                      height: 1,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ));
                  }
                }
              }),

          // This is the search bar, it is at the bottom so that it will be at the top of the
          // stack when the view loads, this way, when it expands it will be in front of the store views
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child:DropdownButtonHideUnderline(
                
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
          ) ,
              ),
              
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
              icon: const Icon(Icons.sort),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: SizedBox(
                      width: 140,
                      child: Text("Sort by Distance", style: TextStyle(fontSize: 15),),
                    )
                    
                  ),
                  const PopupMenuItem<int>(
                    padding: EdgeInsets.all(0),
                    height: 1,
                    value: 2,
                    child: Divider(height: 1,),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: SizedBox(
                      width: 140,
                      child: Text("Sort by Price", style: TextStyle(fontSize: 15),),
                    )
                    
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  setState(() {
                    sortBy = "Distance";
                  },);
                }
                if (value == 1) {
                  setState(() {
                    sortBy = "Price";
                  },);
                }
              }),

            ],
          )
          
        ],
      ),
    );
  }
}
