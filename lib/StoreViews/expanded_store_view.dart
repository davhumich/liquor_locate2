/*

expanded_store_view.dart

This is the view for when the condensed store view is selected
and the more detailed store view loads

*/

// Flutter tool packages
import 'package:flutter/material.dart';

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
    return Container(
      color: const Color(0xFFFFE306),
      child: const Center(
        child: Text("Expanded Store View"),
      ),
    );
  }
}
