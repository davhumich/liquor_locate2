/*

View for the store header

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:liquor_locate2/Functions/open_maps.dart';
import 'package:liquor_locate2/Functions/store_to_header_image.dart';
import 'package:liquor_locate2/Models/store_model.dart';

class StoreHeaderView extends StatelessWidget {
  const StoreHeaderView({super.key, required this.store});
  final Store store;

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
                        image:
                            storeToHeaderImage(store.id),
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
                      child:
                          store.logo,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: RatingBarIndicator(
                      rating: store.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 16,
                    ),
                  ),
                  Text(
                    store.rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      store.address,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 1,
                thickness: 1,
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
                openAppleMaps(store.location.latitude, store.location.longitude, store.name);
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
