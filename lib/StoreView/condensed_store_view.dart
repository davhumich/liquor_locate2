import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView({super.key, required this.storeImagePath, required this.storeName, required this.storeMilage, required this.storeRating, required this.price, required this.color});
  final String storeImagePath;
  final String storeName;
  final String storeMilage;
  final double storeRating;
  final double price;
  final Color color;

  @override
  State<CondensedStoreView> createState() => _CondensedStoreView();
}

class _CondensedStoreView extends State<CondensedStoreView> {

  late String storeImagePath;
  late String storeName;
  late String storeMilage;
  late double storeRating;
  late double price;
  late Color color;

  @override
  void initState() {
    super.initState();
    storeImagePath = widget.storeImagePath;
    storeName = widget.storeName;
    storeMilage = widget.storeMilage;
    storeRating = widget.storeRating;
    price = widget.price;
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: ClipOval(
                    child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child:
                      Image(image: AssetImage(storeImagePath)),
                ))),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(storeName),),
              Expanded(
                child: Text(storeMilage),),
                Expanded(child: Row(
                children: [
                  RatingBarIndicator(
                    rating: storeRating,
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
                      storeRating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),)
            ],
          ),
          ),
          const Spacer(),
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.only(right: 10),
            child: const Image(image: AssetImage('lib/assets/titos.png')),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Text("\$$price", style: TextStyle(fontSize: 18, color: color),),
          ),
        ],
      ),
    );
  }
}
