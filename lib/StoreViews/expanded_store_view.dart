/*

expanded_store_view.dart

This is the view for when the condensed store view is selected
and the more detailed store view loads

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:liquor_locate2/StoreViews/store_header_view.dart';

// (Stateful widget because eventually the data will need to chnage based on what store is being loaded)
class ExpandedStoreView extends StatefulWidget {
  const ExpandedStoreView({super.key});

  @override
  State<ExpandedStoreView> createState() => _ExpandedStoreView();
}

class _ExpandedStoreView extends State<ExpandedStoreView> {
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
      body: const Column(
        children: [
          StoreHeaderView(),
        ],
      )
    );
  }
}
