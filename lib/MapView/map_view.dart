/*

map_view.dart

This is the view for the enitre map tab
has a lot of google maps stuff, so looks more complicated than it is.

*/

// Flutter tool packages
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Internal files located in this directory
import 'package:liquor_locate2/StoreView/condensed_store_view.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapView();
}

class _MapView extends State<MapView> {
  // This is the map controller so the user can interact with the map
  late GoogleMapController mapController;

  // Starting point when google map initialy loads
  final LatLng _initialLatLng = const LatLng(42.279594, -83.732124);

  // Controller for editing the text in the search bar
  TextEditingController textController = TextEditingController();

  // This is a function for if we want to initialize anything on the map when it is created
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
            // (Stack used here so the map won't be pushed down when the search bar expands)
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 305,
                // This is the GoogleMap widget, everything is manged by
                // Google's API so we only need to import this widget
                child: GoogleMap(
                  // Right now the markers are static but everntually they will be created dynamically
                  markers: {
                    const Marker(
                        markerId: MarkerId("id1"),
                        position:
                            LatLng(42.261240502744414, -83.73059051035652)),
                    const Marker(
                        markerId: MarkerId("id2"),
                        position:
                            LatLng(42.27123967529914, -83.73975634176435)),
                    const Marker(
                        markerId: MarkerId("id3"),
                        position:
                            LatLng(42.258599513621036, -83.73739599788769))
                  },
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialLatLng,
                    zoom: 12.5,
                  ),
                ),
              ),
              // Search bar, doesn't do anything right now
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: AnimSearchBar(
                  onSubmitted: (value) {},
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
          // This is the bottom store view, right now static,
          // but eventually will change when user clicks on marker
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 95, 95, 95)),
            ),
            child: const CondensedStoreView(
                storeImagePath: 'lib/assets/testLogo.jpg',
                storeName: "Stadium Market",
                storeMilage: "0.25 Miles Away",
                storeRating: 4.6,
                price: 12.97,
                color: Colors.green),
          )
        ],
      ),
    );
  }
}
