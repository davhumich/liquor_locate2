import 'package:flutter/material.dart';
import 'package:liquor_locate2/CartView/total_prices_view.dart';
import 'package:liquor_locate2/Functions/drink_value_to_index.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:badges/badges.dart' as badges;

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final List<String> _selectedDrinkIds = [];
  final List<int> numberDrinksSelected = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  final _beerKey = GlobalKey<FormFieldState>();
  final _wineKey = GlobalKey<FormFieldState>();
  final _vodkaKey = GlobalKey<FormFieldState>();
  final _tequilaKey = GlobalKey<FormFieldState>();
  final _whiskeyKey = GlobalKey<FormFieldState>();
  final _seltzerKey = GlobalKey<FormFieldState>();
  final _otherKey = GlobalKey<FormFieldState>();

  static final List<MultiSelectItem> _beers = [
    MultiSelectItem("Corona - 6 Pack", "lib/assets/BeerImages/Coronas.png"),
    MultiSelectItem(
        "Miller Light - 6 Pack", "lib/assets/BeerImages/miller_light.png"),
    MultiSelectItem(
        "Bud Light - 6 Pack", "lib/assets/BeerImages/bud_light.png"),
    MultiSelectItem("Coors - 6 Pack", "lib/assets/BeerImages/coors.png"),
    MultiSelectItem("Heineken - 6 Pack", "lib/assets/BeerImages/heineken.png"),
  ];

  static final List<MultiSelectItem> _wines = [
    MultiSelectItem("Barefoot - Bottle", "lib/assets/WineImages/Barefoot.png"),
    MultiSelectItem("Franzia - Box", "lib/assets/WineImages/Franzia.png"),
    MultiSelectItem(
        "Sutter Home - Bottle", "lib/assets/WineImages/Sutter_Home.png"),
    MultiSelectItem(
        "[yellow tail] - Bottle", "lib/assets/WineImages/Yellow_Tail.png"),
    MultiSelectItem("Apothic - Bottle", "lib/assets/WineImages/Apothic.png"),
  ];

  static final List<MultiSelectItem> _vodkas = [
    MultiSelectItem("Titos - Fifth", "lib/assets/VodkaImages/titos.png"),
    MultiSelectItem("Smirnoff - Fifth", "lib/assets/VodkaImages/Smirnoff.png"),
    MultiSelectItem("Absolut - Fifth", "lib/assets/VodkaImages/Absolut.png"),
    MultiSelectItem("Svedka - Fifth", "lib/assets/VodkaImages/Svedka.png"),
    MultiSelectItem(
        "Grey Goose - Fifth", "lib/assets/VodkaImages/Grey_Goose.png"),
  ];

  static final List<MultiSelectItem> _tequilas = [
    MultiSelectItem(
        "Jose Cuervo - Fifth", "lib/assets/TequilaImages/Jose_Cuervo.png"),
    MultiSelectItem("Patrón - Fifth", "lib/assets/TequilaImages/Patron.png"),
    MultiSelectItem(
        "Casamigos - Fifth", "lib/assets/TequilaImages/Casamigos.png"),
    MultiSelectItem("Espolón - Fifth", "lib/assets/TequilaImages/Espolon.png"),
    MultiSelectItem("1800 - Fifth", "lib/assets/TequilaImages/1800.png"),
  ];

  static final List<MultiSelectItem> _whiskeys = [
    MultiSelectItem(
        "Jack Daniels - Fifth", "lib/assets/WhiskeyImages/Jack_Daniels.png"),
    MultiSelectItem(
        "Jim Beam - Fifth", "lib/assets/WhiskeyImages/Jim_Beam.png"),
    MultiSelectItem("Jameson - Fifth", "lib/assets/WhiskeyImages/Jameson.png"),
    MultiSelectItem(
        "Fireball - Fifth", "lib/assets/WhiskeyImages/fireball.png"),
    MultiSelectItem(
        "Screwball - Fifth", "lib/assets/WhiskeyImages/Screwball.png"),
  ];

  static final List<MultiSelectItem> _seltzers = [
    MultiSelectItem(
        "White Claw - 6 Pack", "lib/assets/SeltzerImages/White_Claw.png"),
    MultiSelectItem("Truly - 6 Pack", "lib/assets/SeltzerImages/Truly.png"),
    MultiSelectItem("Bud Light Seltzer - 6 Pack",
        "lib/assets/SeltzerImages/Bud_Light_Seltzer.png"),
    MultiSelectItem(
        "High Noon - 6 Pack", "lib/assets/SeltzerImages/High_Noon.png"),
    MultiSelectItem(
        "Long Drink - 6 Pack", "lib/assets/SeltzerImages/Long_Drink.png"),
  ];

  static final List<MultiSelectItem> _others = [
    MultiSelectItem("Malibu - Fifth", "lib/assets/OtherImages/Malibu.png"),
    MultiSelectItem("Baileys - Fifth", "lib/assets/OtherImages/Baileys.png"),
    MultiSelectItem(
        "Beefeaters - Fifth", "lib/assets/OtherImages/Beefeaters.png"),
    MultiSelectItem("Hennessey - Fifth", "lib/assets/OtherImages/Hennessy.png"),
    MultiSelectItem(
        "Jägermeister - Fifth", "lib/assets/OtherImages/jagermeister.png"),
    MultiSelectItem(
        "Captain Morgan - Fifth", "lib/assets/OtherImages/Captain_Morgan.png"),
  ];

  showLoaderDialog(BuildContext context) {
    //set up the AlertDialog
    AlertDialog alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
    showDialog(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 236, 87, 95),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MultiSelectChipField(
                    height: 165,
                    items: _beers,
                    initialValue: const [],
                    key: _beerKey,
                    title: const Text(
                      "Beers",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _beerKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value)
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _wines,
                    initialValue: const [],
                    key: _wineKey,
                    title: const Text(
                      "Wines",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _wineKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value),
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _vodkas,
                    initialValue: const [],
                    key: _vodkaKey,
                    title: const Text(
                      "Vodkas",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _vodkaKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value)
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _tequilas,
                    initialValue: const [],
                    key: _tequilaKey,
                    title: const Text(
                      "Tequilas",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _tequilaKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value),
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _whiskeys,
                    initialValue: const [],
                    key: _whiskeyKey,
                    title: const Text(
                      "Whiskeys",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _whiskeyKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value)
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _seltzers,
                    initialValue: const [],
                    key: _seltzerKey,
                    title: const Text(
                      "Seltzers",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _seltzerKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value)
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  MultiSelectChipField(
                    height: 165,
                    items: _others,
                    initialValue: const [],
                    key: _otherKey,
                    title: const Text(
                      "Other",
                      style: TextStyle(fontSize: 22),
                    ),
                    headerColor: const Color.fromARGB(255, 255, 231, 231),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 231, 231),
                          width: 1.8),
                    ),
                    selectedChipColor: Colors.blue.withOpacity(0.5),
                    selectedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 231, 231)),
                    itemBuilder: (item, state) {
                      // return your custom widget here
                      return InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          splashColor: const Color.fromARGB(255, 255, 231, 231)
                              .withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              _selectedDrinkIds.contains(item.value)
                                  ? numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 0
                                  : numberDrinksSelected[
                                      drinkValueToIndex(item.value)] = 1;
                              _selectedDrinkIds.contains(item.value)
                                  ? _selectedDrinkIds.remove(item.value)
                                  : _selectedDrinkIds.add(item.value);
                              state.didChange(_selectedDrinkIds);
                              _otherKey.currentState?.validate();
                            });
                          },
                          child: Column(
                            children: [
                              if (_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 170, 164, 164),
                                        width: 0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color:
                                        const Color.fromRGBO(221, 239, 255, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(
                                        item.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      InputQty(
                                        maxVal: 10,
                                        initVal: 1,
                                        minVal: 1,
                                        steps: 1,
                                        onQtyChanged: (val) {
                                          numberDrinksSelected[
                                              drinkValueToIndex(
                                                  item.value)] = val.round();
                                          print(numberDrinksSelected);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              if (!_selectedDrinkIds.contains(item.value))
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image(
                                            image: AssetImage(item.label)),
                                      ),
                                      Text(item.value)
                                    ],
                                  ),
                                )
                            ],
                          ));
                    },
                    onTap: (values) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  const SizedBox(
                    height: 75,
                  )
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: badges.Badge(
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      _selectedDrinkIds.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TotalPricesView(
                                numberDrinksSelected: numberDrinksSelected,
                              ),
                            ));
                      },
                      label: const Text(
                        'See Total For Stores',
                        style: TextStyle(fontSize: 16),
                      ),
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  )),
            ),
          ],
        ));
  }
}
