/*

View for the store header

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StoreHeaderView extends StatelessWidget {
  const StoreHeaderView({super.key, required this.storeName});
  final String storeName;

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
                    image: const DecorationImage(
                        image:
                            AssetImage("lib/assets/storeBackgroundImage.jpg"),
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
                    child: Text(
                      storeName,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
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
                          const Image(image: AssetImage("lib/assets/testLogo.jpg")),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: RatingBarIndicator(
                      rating: 4.6,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 16,
                    ),
                  ),
                  Container(
                    child: const Text(
                      "4.6",
                      style: TextStyle(
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
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: const Text(
                      "1423 E Stadium Blvd STE D, Ann Arbor, MI 48104",
                      style: TextStyle(
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
              onPressed: () {},
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