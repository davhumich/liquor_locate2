/*

condensed_store_placeholder.dart

This provides the shimemer effect while the condensed store view is loading

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:shimmer/shimmer.dart';

class CondensedStorePlaceholder extends StatefulWidget {
  const CondensedStorePlaceholder({super.key});

  @override
  State<CondensedStorePlaceholder> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStorePlaceholder> {

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
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
                    border: Border.all(width: 1.5, color: Colors.grey),
                  ),
                  child: ClipOval(
                      child: SizedBox.fromSize(
                    size: const Size.fromRadius(48), // Image radius
                  ))),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              // Store name, milage and rating
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 140, height: 10, color: Colors.white,),
                  const SizedBox(height: 10,),
                  Container(width: 70, height: 10, color: Colors.white,),
                  const SizedBox(height: 10,),
                  Container(width: 100, height: 10, color: Colors.white,),
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
