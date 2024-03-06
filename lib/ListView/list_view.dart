/*

list_view.dart

The view for the list tab, only contains UI, interactactivity with firebase
should take place in an external file

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Functions/init_list_view.dart';

// External packages from pub.dev
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// Internal files located in this directory
import 'package:liquor_locate2/StoreViews/condensed_store_view.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

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
  String? selectedValue;

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
                        margin: const EdgeInsets.only(top: 60),
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
                              for (var storeId in storeIds)
                                Column(
                                  children: [
                                    CondensedStoreView(
                                      storeId: storeId,
                                    ),
                                    const Divider(height: 1,),
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
          DropdownButtonHideUnderline(
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
            });
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            width: MediaQuery.of(context).size.width,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
        ],
      ),
    );
  }
}
