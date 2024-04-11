import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/favorite_check.dart';
import 'package:liquor_locate2/Functions/open_maps.dart';
import 'package:liquor_locate2/Functions/store_to_header_image.dart';
import 'package:liquor_locate2/Functions/favorite_add.dart';
import 'package:liquor_locate2/Functions/favorite_remove.dart';
import 'package:liquor_locate2/Models/store_model.dart';
import 'package:favorite_button/favorite_button.dart';

class StoreHeaderView extends StatefulWidget {
  const StoreHeaderView({Key? key, required this.store, required this.userId}) : super(key: key);
  
  final Store store;
  final String userId;

  @override
  _StoreHeaderViewState createState() => _StoreHeaderViewState();
}

class _StoreHeaderViewState extends State<StoreHeaderView> {
  late Future<bool> _isFavoriteFuture;

  @override
  void initState() {
    super.initState();
    _isFavoriteFuture = isStoreInFavorites(widget.userId, widget.store.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 70),
          height: 150,
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: storeToHeaderImage(widget.store.id),
                        fit: BoxFit.fitWidth),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                  )),
              Align(
                alignment: const FractionalOffset(0.5, 2.4),
                child: SizedBox(
                  width: 110,
                  height: 110,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: widget.store.logo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 170, 164, 164)),
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 5),
                    child: Text(
                      widget.store.address,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 15),
                    child: RatingBarIndicator(
                      rating: widget.store.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, bottom: 13),
                    child: Text(
                      widget.store.rating.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 160, bottom: 15),
                    width: 20,
                    height: 20,
                    child: FutureBuilder<bool>(
                      future: _isFavoriteFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          bool isFavorite = snapshot.data ?? false;
                          return FavoriteButton(
                            iconSize: 40,
                            isFavorite: isFavorite,
                            valueChanged: (_isFavourite) {
                              if (_isFavourite) {
                                print("favorite");
                                addToFavorites(widget.userId, widget.store.id);
                              } else {
                                print("unfavorite");
                                removeFromFavorites(widget.userId, widget.store.id);
                              }
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 10,
          height: 50,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                openAppleMaps(widget.store.location.latitude, widget.store.location.longitude,
                    widget.store.name);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Directions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.share_location,
                    color: Colors.white,
                  )
                ],
              )),
        ),
        const Divider(),
      ],
    );
  }
}
