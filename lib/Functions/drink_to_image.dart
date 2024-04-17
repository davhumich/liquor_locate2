

import 'package:flutter/material.dart';

Image drinkToImage(String drinkName){
  if (drinkName == "Corona - 6 Pack"){
    return Image.asset("lib/assets/BeerImages/Coronas.png");
  } else if (drinkName == "Miller Light - 6 Pack"){
    return Image.asset("lib/assets/BeerImages/miller_light.png");
  } else if (drinkName == "Bud Light - 6 Pack"){
    return Image.asset("lib/assets/BeerImages/bud_light.png");
  } else if (drinkName == "Coors - 6 Pack"){
    return Image.asset("lib/assets/BeerImages/coors.png");
  } else if (drinkName == "Heineken - 6 Pack"){
    return Image.asset("lib/assets/BeerImages/heineken.png");
  } else if (drinkName == "Barefoot - Bottle"){
    return Image.asset("lib/assets/WineImages/Barefoot.png");
  } else if (drinkName == "Franzia - Box"){
    return Image.asset("lib/assets/WineImages/Franzia.png");
  } else if (drinkName == "Sutter Home - Bottle"){
    return Image.asset("lib/assets/WineImages/Sutter_Home.png");
  } else if (drinkName == "[yellow tail] - Bottle"){
    return Image.asset("lib/assets/WineImages/Yellow_Tail.png");
  } else if (drinkName == "Apothic - Bottle"){
    return Image.asset("lib/assets/WineImages/Apothic.png");
  } else if (drinkName == "Titos - Fifth"){
    return Image.asset("lib/assets/VodkaImages/titos.png");
  } else if (drinkName == "Smirnoff - Fifth"){
    return Image.asset("lib/assets/VodkaImages/Smirnoff.png");
  } else if (drinkName == "Absolut - Fifth"){
    return Image.asset("lib/assets/VodkaImages/Absolut.png");
  } else if (drinkName == "Svedka - Fifth"){
    return Image.asset("lib/assets/VodkaImages/Svedka.png");
  } else if (drinkName == "Grey Goose - Fifth"){
    return Image.asset("lib/assets/VodkaImages/Grey_Goose.png");
  } else if (drinkName == "Jose Cuervo - Fifth"){
    return Image.asset("lib/assets/TequilaImages/Jose_Cuervo.png");
  } else if (drinkName == "Patrón - Fifth"){
    return Image.asset("lib/assets/TequilaImages/Patron.png");
  } else if (drinkName == "Casamigos - Fifth"){
    return Image.asset("lib/assets/TequilaImages/Casamigos.png");
  } else if (drinkName == "Espolón - Fifth"){
    return Image.asset("lib/assets/TequilaImages/Espolon.png");
  } else if (drinkName == "1800 - Fifth"){
    return Image.asset("lib/assets/TequilaImages/1800.png");
  } else if (drinkName == "Jack Daniels - Fifth"){
    return Image.asset("lib/assets/WhiskeyImages/Jack_Daniels.png");
  } else if (drinkName == "Jim Beam - Fifth"){
    return Image.asset("lib/assets/WhiskeyImages/Jim_Beam.png");
  } else if (drinkName == "Jameson - Fifth"){
    return Image.asset("lib/assets/WhiskeyImages/Jameson.png");
  } else if (drinkName == "Fireball - Fifth"){
    return Image.asset("lib/assets/WhiskeyImages/fireball.png");
  } else if (drinkName == "Screwball - Fifth"){
    return Image.asset("lib/assets/WhiskeyImages/Screwball.png");
  } else if (drinkName == "White Claw - 6 Pack"){
    return Image.asset("lib/assets/SeltzerImages/White_Claw.png");
  } else if (drinkName == "Truly - 6 Pack"){
    return Image.asset("lib/assets/SeltzerImages/Truly.png");
  } else if (drinkName == "Bud Light Seltzer - 6 Pack"){
    return Image.asset("lib/assets/SeltzerImages/Bud_Light_Seltzer.png");
  } else if (drinkName == "High Noon - 6 Pack"){
    return Image.asset("lib/assets/SeltzerImages/High_Noon.png");
  } else if (drinkName == "Long Drink - 6 Pack"){
    return Image.asset("lib/assets/SeltzerImages/Long_Drink.png");
  } else if (drinkName == "Malibu - Fifth"){
    return Image.asset("lib/assets/OtherImages/Malibu.png");
  } else if (drinkName == "Baileys - Fifth"){
    return Image.asset("lib/assets/OtherImages/Baileys.png");
  } else if (drinkName == "Beefeaters - Fifth"){
    return Image.asset("lib/assets/OtherImages/Beefeaters.png");
  } else if (drinkName == "Hennessey - Fifth"){
    return Image.asset("lib/assets/OtherImages/Hennessy.png");
  } else if (drinkName == "Jägermeister - Fifth"){
    return Image.asset("lib/assets/OtherImages/Hennessy.png");
  } else if (drinkName == "Captain Morgan - Fifth"){
    return Image.asset("lib/assets/OtherImages/Captain_Morgan.png");
  }
  return Image.asset("lib/assets/BeerImages/Coronas.png");
}