import 'package:flutter/material.dart';
import 'package:liquor_locate2/StoreView/condensed_store_view.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class StoresView extends StatefulWidget {
  const StoresView({super.key});

  @override
  State<StoresView> createState() => _StoresView();
}

class _StoresView extends State<StoresView> {
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
          Container(
            margin: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                ClipPath(
            clipper: WaveClipperOne(flip: true),
            child: Container(
              padding: const EdgeInsets.only(bottom: 40, left: 35, right: 10, top: 10),
              height: 100,
              color: const Color.fromARGB(255, 255, 231, 231),
              child: Row(
                    children: [
                      const Image(image: AssetImage('lib/assets/titos.png')),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Fifth of Titos",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      const Text(
                        "Avg:     ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: const Text(
                          "\$16.01",
                          style: TextStyle(
                              fontSize: 18,)
                        ),
                      ),
                    ],
                  ),
            ),
          ),
                
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                  child: const CondensedStoreView(storeImagePath: 'lib/assets/testLogo.jpg', storeName: "Stadium Market", storeMilage: "0.25 Miles Away", storeRating: 4.6, price: 12.97, color: Colors.green),
                ),
                const CondensedStoreView(storeImagePath: 'lib/assets/testlogo2.png', storeName: "Main Street Beer and Wine", storeMilage: "0.71 Miles Away", storeRating: 3.6, price: 21.17, color: Colors.red),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                  child: const CondensedStoreView(storeImagePath: 'lib/assets/testlogo3.jpg', storeName: "Champion's Party Store", storeMilage: "1.3 Miles Away", storeRating: 3.1, price: 16.65, color: Color.fromARGB(255, 179, 165, 42)),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                  child: const CondensedStoreView(storeImagePath: 'lib/assets/testlogo4.jpg', storeName: "Campus Corner", storeMilage: "1.67 Miles Away", storeRating: 4.2, price: 13.55, color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 500,
            height: MediaQuery.of(context).size.height - 205,
            child: FloatingSearchBar(
              hint: 'Fifth of Titos',
              hintStyle: const TextStyle(color: Colors.black),
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: 0,
              openAxisAlignment: 0.0,
              width: 500,
              debounceDelay: const Duration(milliseconds: 500),
              onQueryChanged: (query) {
                // Call your model, bloc, controller here.
              },
              // Specify a custom transition to be used for
              // animating between opened and closed stated.
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.filter_list_rounded),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: Colors.accents.map((color) {
                        return Container(height: 112, color: color);
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
