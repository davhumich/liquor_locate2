import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({ super.key });

  @override
  State<MapView> createState() => _MapView();
}

class _MapView extends State<MapView> {

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

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
          backgroundColor: Color.fromARGB(255, 236, 87, 95),
        ),
        body: Stack(
          children: [
            Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        ),
            Container(
          margin: EdgeInsets.only(left: 20, right: 20),
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
        )
    );
  }
}