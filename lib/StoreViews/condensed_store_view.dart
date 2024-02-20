/*

condensed_store_view.dart

This is the view for the small store views that are displayed
on the list view and the map view

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/init_store.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:liquor_locate2/StoreViews/expanded_store_view.dart';

class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView({super.key, required this.storeId});

  // These are the varibles we input to the view so it will load with different stores
  // (Eventually we will only input a store id and load it from the database directly from this view)
  final String storeId;

  @override
  State<CondensedStoreView> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStoreView> {
  // The variables initialzed in the actual view
  // (The reason they are late is because they are initialzed in initState, which is called after the widget loads)
  late String storeId;
  late Store store;

  // This function takes the variables inputed above and initialzes them in this state
  @override
  void initState() {
    super.initState();
    storeId = widget.storeId;
  }

  Future<String> storeInit() async {
    store = await initStore(storeId);
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    // This InkWell object makes it so when the user taps on this view,
    // they will be taken to the expanded store view
    return FutureBuilder(
          future: storeInit(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("loading...");
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
            builder: (BuildContext context) => ExpandedStoreView(storeId: storeId,),
          ),
        );
      },
      child: Container(
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
                    child: Text(store.name),
                  ),
                  const Expanded(
                    child: Text("0.6"),
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
              child: const Text(
                "\$",
                style: TextStyle(fontSize: 18, color: Colors.blue),
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
