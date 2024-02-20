/*

list_view.dart

The view for the list tab, only contains UI, interactactivity with firebase
should take place in an external file

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Functions/init_list_view.dart';

// External packages from pub.dev
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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

  Future<String> storeInit() async {
    storeIds = await initListViewIds();
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
                  return const Text("loading...");
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(top: 70),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ClipPath(
                                // ClipPath is an external package we used for the red wave border at the top of the view
                                clipper: WaveClipperOne(flip: true),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 40, left: 35, right: 10, top: 10),
                                  height: 100,
                                  color:
                                      const Color.fromARGB(255, 255, 231, 231),
                                  child: Row(
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                              'lib/assets/titos.png')),
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: const Text("\$16.01",
                                            style: TextStyle(
                                              fontSize: 18,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // This is where the list of stores begin
                              Divider(height: 1,),
                              for (var storeId in storeIds)
                                Column(
                                  children: [
                                    CondensedStoreView(
                                      storeId: storeId,
                                    ),
                                    Divider(height: 1,),
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
              onQueryChanged: (query) {},
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
