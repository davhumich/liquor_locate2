import 'package:flutter/material.dart';

class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView({super.key});

  @override
  State<CondensedStoreView> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStoreView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: ClipOval(
                    child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: const Image(
                      image: AssetImage(
                          'lib/assets/testLogo.jpg')),
                ))),
          ),
        ],
      ),
    );
  }
}
