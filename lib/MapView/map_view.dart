/*

map_view.dart

This is the view for the enitre map tab
has a lot of google maps stuff, so looks more complicated than it is.

*/

// Flutter tool packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// External packages from pub.dev
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:liquor_locate2/Functions/favorite_get.dart';
import 'package:search_map_location/search_map_location.dart';

// Internal files located in this directory
import 'package:liquor_locate2/StoreViews/condensed_store_view.dart';
import 'package:liquor_locate2/globals.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.userId});

  final String userId;



  @override
  State<MapView> createState() => _MapView();
}

class _MapView extends State<MapView> {
  late String userId;
  late List<String> favStores;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = widget.userId;
  }

  // This is the map controller so the user can interact with the map
  late GoogleMapController mapController;

  // Starting point when google map initialy loads
  final LatLng _initialLatLng = const LatLng(42.279594, -83.732124);

  // Controller for editing the text in the search bar
  TextEditingController textController = TextEditingController();
 
  Set<Marker> markers = {}; // Updated to store markers dynamically

  LatLng userLatLng = LatLng(userLocation.latitude, userLocation.longitude);

  Marker? selectedMarker;

  String SelectedStore = "blank";

  final List<String> items = [
    'Beer',
    'Wine',
    'Vodka',
    'Whiskey',
    'Seltzer',
  ];
  String? selectedValue = "Beer";
  double avgPrice = -1;
  String drinkId = "13Dclb3TMT1SgvVhLvnc";

  void _onMapTapped(LatLng latLng) {
    setState(() {
      selectedMarker = null;
      SelectedStore = "blank";
    });
  }

  void _onMarkerTapped(Marker marker) {
    setState(() {
      if (selectedMarker != marker)
       { 
        selectedMarker = marker;
        SelectedStore = marker.markerId.value;
       }
      else {
      selectedMarker = null;
      SelectedStore = "blank";
      }
    });
    print(selectedMarker);
  }


  // This is a function for if we want to initialize anything on the map when it is created
  void _onMapCreated(GoogleMapController controller) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
    {
        await Geolocator.requestPermission();
    }
    userLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    userLatLng = LatLng(userLocation.latitude, userLocation.longitude);
    mapController = controller;
    await _fetchMarkersFromFirestore();
    favStores = await getFavoriteStores(userId);


    mapController.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 14.0));
    
  }

  Future<void> _fetchMarkersFromFirestore() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('stores').get();
    setState(() {
      markers.clear();
    });
    
    // Iterate through the documents and add markers
    for (var document in snapshot.docs) {
      if (document.exists) {
        GeoPoint geoPoint = document["StorePosition"];
        LatLng storeLocation = LatLng(geoPoint.latitude, geoPoint.longitude);

        Marker marker = Marker(
          markerId: MarkerId(document.id),
          position: storeLocation,
          onTap: () => _onMarkerTapped(Marker(markerId: MarkerId(document.id), position: storeLocation)),
          infoWindow: InfoWindow(title: document["Name"])
        );

        setState(() {
          markers.add(marker);
        });
      }
    }
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
                height: MediaQuery.of(context).size.height - 325,
                // This is the GoogleMap widget, everything is manged by
                // Google's API so we only need to import this widget
                child: GoogleMap(
                  // Right now the markers are static but everntually they will be created dynamically
                  myLocationEnabled: true,
                  onTap: _onMapTapped,
                  markers: markers,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: userLatLng ?? _initialLatLng,
                    zoom: 12.5,
                  ),
                ),
              ),
              // Search bar, doesn't do anything right now
             Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                constraints: const BoxConstraints(maxHeight: 362),
                child: SearchLocation(
                  apiKey: 'AIzaSyCsHkeL1M3Nx6-yoheQ9x7_qbQp0qp5XCs',
                  radius: 15000,
                  onSelected: (place) async {
                    bool inDB = false;
                    final geolocation = await place.geolocation;
                    LatLng searchCoordinates = LatLng(geolocation!.coordinates.latitude, geolocation.coordinates.longitude);
                    mapController.animateCamera(CameraUpdate.newLatLng(searchCoordinates));
                    
                    if(selectedMarker != null) {
                      mapController.hideMarkerInfoWindow(selectedMarker!.markerId);
                    }
                    for (var marker in markers) {
                      if(marker.position.latitude == geolocation.coordinates.latitude && marker.position.longitude == geolocation.coordinates.longitude)
                      {
                        inDB = true;
                        setState(() {
                          selectedMarker = marker;
                          SelectedStore = marker.markerId.value;
                          mapController.showMarkerInfoWindow(selectedMarker!.markerId);
                        });
                      }
                     }

                    if(!inDB)
                    {
                      _onMapTapped(searchCoordinates);
                    }
                  },
                ),
              ),
            ],
          ),
          // This is the bottom store view, right now static,
          // but eventually will change when user clicks on marker
          if (SelectedStore != "blank")
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 95, 95, 95)),
              ),
              child: CondensedStoreView(
                storeId: SelectedStore,
                drinkId: drinkId,
                avgPrice: 0,
                userId: userId,
                favStores: favStores,
                onFavoriteChanged: () {
                  // Callback to refresh the list
                  
                  print("onFavoriteChanged"); // Just trigger setState to rebuild the widget
                },
              ),
            )
        ],
      ),
    );
  }
}