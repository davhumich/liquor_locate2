/*

View for the store header

*/

// Flutter tool packages
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreHeaderPlaceholder extends StatelessWidget {
  const StoreHeaderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 3.5, color: Colors.grey),
                  ),
                  width: 110,
                  height: 110,
                  child: ClipOval(
                    
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 350,
          height: 100,
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
                  ),
                ],
              ),
              const Divider(
                height: 1,
                thickness: 1,
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
    ),
    );
  }
}