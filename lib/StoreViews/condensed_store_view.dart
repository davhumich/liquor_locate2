import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/favorite_add.dart';
import 'package:liquor_locate2/Functions/favorite_check.dart';
import 'package:liquor_locate2/Functions/favorite_remove.dart';
import 'package:liquor_locate2/Functions/init_price.dart';
import 'package:liquor_locate2/Functions/init_store.dart';
import 'package:liquor_locate2/Functions/price_to_color.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:liquor_locate2/Functions/calculate_distance.dart';
import 'package:liquor_locate2/Placeholder%20Skeletons/condensed_store_placeholder.dart';
import 'package:liquor_locate2/StoreViews/expanded_store_view.dart';

class CondensedStoreView extends StatefulWidget {
  const CondensedStoreView({
    super.key,
    required this.storeId,
    required this.drinkId,
    required this.avgPrice,
    required this.userId,
    required this.onFavoriteChanged,
  });

  final String storeId;
  final String drinkId;
  final double avgPrice;
  final String userId;
  final VoidCallback onFavoriteChanged;

  @override
  State<CondensedStoreView> createState() => _CondensedStoreViewState();
}

class _CondensedStoreViewState extends State<CondensedStoreView> {
  late String storeId;
  late Store store;
  late String drinkId;
  late double drinkPrice;
  late double avgPrice;
  late Color priceColor;

  late Future<bool> _isFavoriteFuture;
  late String userId;
  late VoidCallback onFavoriteChanged;

  @override
  void initState() {
    super.initState();
    storeId = widget.storeId;
    drinkId = widget.drinkId;
    avgPrice = widget.avgPrice;
    userId = widget.userId;
    onFavoriteChanged = widget.onFavoriteChanged;
    _updateFavoriteStatus();
  }

  void _updateFavoriteStatus() {
    _isFavoriteFuture = isStoreInFavorites(userId, storeId);
  }

  @override
  void didUpdateWidget(covariant CondensedStoreView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId || oldWidget.storeId != widget.storeId) {
      userId = widget.userId;
      storeId = widget.storeId;
      _updateFavoriteStatus();
    }
  }

  Future<String> storeIdInit() async {
    store = await initStore(storeId);
    drinkPrice = await initPrice(storeId, drinkId);
    priceColor = priceToColor(drinkPrice, avgPrice);
    return 'Done';
  }

  @override
  Widget build(BuildContext context) {
    storeId = widget.storeId;
    drinkId = widget.drinkId;
    avgPrice = widget.avgPrice;
    return FutureBuilder(
      future: storeIdInit(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CondensedStorePlaceholder();
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ExpandedStoreView(
                      storeId: storeId,
                      storeName: store.name,
                      userId: userId,
                      onFavoriteChanged: onFavoriteChanged,
                    ),
                  ),
                );
              },
              child: Container(
                height: 98, // 78 for frank, normally 98
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
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
                            size: const Size.fromRadius(48),
                            child: store.logo,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              store.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: FutureBuilder<String>(
                              future: getDistance(store.location),
                              builder: (context, distanceSnapshot) {
                                if (distanceSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text("Calculating distance...");
                                } else if (distanceSnapshot.hasError) {
                                  return SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Error: ${distanceSnapshot.error}',
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: const EdgeInsets.only(top: 2),
                                    width: 200,
                                    child: Text(
                                      distanceSnapshot.data ?? 'Unknown distance',
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                              },
                            ),
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
                    (avgPrice > 0)
                        ? Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "\$${drinkPrice.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 18, color: priceColor),
                            ),
                          )
                        : Container(
                            child: FutureBuilder<bool>(
                              future: _isFavoriteFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  bool isFavorite = snapshot.data ?? false;
                                  return FavoriteButton(
                                    iconSize: 40,
                                    isFavorite: isFavorite,
                                    valueChanged: (_isFavourite) {
                                      if (_isFavourite) {
                                        addToFavorites(userId, storeId);
                                      } else {
                                        removeFromFavorites(userId, storeId);
                                      }
                                      widget.onFavoriteChanged();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
