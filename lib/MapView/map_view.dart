import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liquor_locate2/StoreView/condensed_store_view.dart';

class MapView extends StatefulWidget {
  const MapView({ super.key });

  @override
  State<MapView> createState() => _MapView();
}

class _MapView extends State<MapView> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(42.279594, -83.732124);

  TextEditingController textController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Map",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 236, 87, 95),
        ),
        body: Column(
          children: [
            Stack(
          children: [
            SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 305,
          child: GoogleMap(
          markers: {
            const Marker(markerId: MarkerId("id1"), position: LatLng(42.261240502744414, -83.73059051035652)),
            const Marker(markerId: MarkerId("id1"), position: LatLng(42.27123967529914, -83.73975634176435)),
            const Marker(markerId: MarkerId("id1"), position: LatLng(42.258599513621036, -83.73739599788769))
            },
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.5,
          ),
        ),
        ),
            Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: AnimSearchBar(
        onSubmitted: (value) {
        },
        width: 400,
        textController: textController,
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),
        ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 95, 95, 95)),

                ),
          child: const CondensedStoreView(storeImagePath: 'lib/assets/testLogo.jpg', storeName: "Stadium Market", storeMilage: "0.25 Miles Away", storeRating: 4.6, price: 12.97, color: Colors.green),
        )
          ],
        )
    );
  }
}