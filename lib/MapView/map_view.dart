import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class MapView extends StatefulWidget {
  const MapView({ super.key });

  @override
  State<MapView> createState() => _MapView();
}

class _MapView extends State<MapView> {

  TextEditingController textController = TextEditingController();



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
        body: Container(
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
        )
    );
  }
}