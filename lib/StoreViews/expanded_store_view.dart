/*

expanded_store_view.dart

This is the view for when the condensed store view is selected
and the more detailed store view loads

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Functions/init_store.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:liquor_locate2/StoreViews/store_header_view.dart';

// (Stateful widget because eventually the data will need to chnage based on what store is being loaded)
class ExpandedStoreView extends StatefulWidget {
  const ExpandedStoreView({super.key, required this.storeId});
  final String storeId;

  @override
  State<ExpandedStoreView> createState() => _ExpandedStoreView();
}

class _ExpandedStoreView extends State<ExpandedStoreView> {
  late Store store;
  late String storeId;

@override
  void initState() {
    super.initState();
    storeId = widget.storeId;
  }

  Future<String> storeInit() async {
    store = await initStore(storeId);
    return 'Done';
  }

  // This is the actual widget that creates the interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expanded Store View",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 236, 87, 95),
      ),
      body: FutureBuilder(
          future: storeInit(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("loading...");
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Column(
                  children: [
                    StoreHeaderView(store: store),
                  ],
                );
              }
            }
          }),
    );
  }
}
