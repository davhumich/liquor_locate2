

int drinkValueToIndex(String value){
  if (value == "Corona - 6 Pack"){
    return 0;
  } else if (value == "Miller Light - 6 Pack"){
    return 1;
  } else if (value == "Bud Light - 6 Pack"){
    return 2;
  } else if (value == "Coors - 6 Pack"){
    return 3;
  } else if (value == "Heineken - 6 Pack"){
    return 4;
  } else if (value == "Barefoot - Bottle"){
    return 5;
  } else if (value == "Franzia - Box"){
    return 6;
  } else if (value == "Sutter Home - Bottle"){
    return 7;
  } else if (value == "[yellow tail] - Bottle"){
    return 8;
  } else if (value == "Apothic - Bottle"){
    return 9;
  } else if (value == "Titos - Fifth"){
    return 10;
  } else if (value == "Smirnoff - Fifth"){
    return 11;
  } else if (value == "Absolut - Fifth"){
    return 12;
  } else if (value == "Svedka - Fifth"){
    return 13;
  } else if (value == "Grey Goose - Fifth"){
    return 14;
  } else if (value == "Jose Cuervo - Fifth"){
    return 15;
  } else if (value == "Patrón - Fifth"){
    return 16;
  } else if (value == "Casamigos - Fifth"){
    return 17;
  } else if (value == "Espolón - Fifth"){
    return 18;
  } else if (value == "1800 - Fifth"){
    return 19;
  } else if (value == "Jack Daniels - Fifth"){
    return 20;
  } else if (value == "Jim Beam - Fifth"){
    return 21;
  } else if (value == "Jameson - Fifth"){
    return 22;
  } else if (value == "Fireball - Fifth"){
    return 23;
  } else if (value == "Screwball - Fifth"){
    return 24;
  } else if (value == "White Claw - 6 Pack"){
    return 25;
  } else if (value == "Truly - 6 Pack"){
    return 26;
  } else if (value == "Bud Light Seltzer - 6 Pack"){
    return 27;
  } else if (value == "High Noon - 6 Pack"){
    return 28;
  } else if (value == "Long Drink - 6 Pack"){
    return 29;
  } else if (value == "Malibu - Fifth"){
    return 30;
  } else if (value == "Baileys - Fifth"){
    return 31;
  } else if (value == "Beefeaters - Fifth"){
    return 32;
  } else if (value == "Hennessey - Fifth"){
    return 33;
  } else if (value == "Jägermeister - Fifth"){
    return 34;
  } else if (value == "Captain Morgan - Fifth"){
    return 35;
  }
  else{
    return 0;
  }
}

String drinkIndexToValue(int index){
  if (index == 0){
    return "Corona - 6 Pack";
  } else if (index == 1){
    return "Miller Light - 6 Pack";
  } else if (index == 2){
    return "Bud Light - 6 Pack";
  } else if (index == 3){
    return "Coors - 6 Pack";
  } else if (index == 4){
    return "Heineken - 6 Pack";
  } else if (index == 5){
    return "Barefoot - Bottle";
  } else if (index == 6){
    return "Franzia - Box";
  } else if (index == 7){
    return "Sutter Home - Bottle";
  } else if (index == 8){
    return "[yellow tail] - Bottle";
  } else if (index == 9){
    return "Apothic - Bottle";
  } else if (index == 10){
    return "Titos - Fifth";
  } else if (index == 11){
    return "Smirnoff - Fifth";
  } else if (index == 12){
    return "Absolut - Fifth";
  } else if (index == 13){
    return "Svedka - Fifth";
  } else if (index == 14){
    return "Grey Goose - Fifth";
  } else if (index == 15){
    return "Jose Cuervo - Fifth";
  } else if (index == 16){
    return "Patrón - Fifth";
  } else if (index == 17){
    return "Casamigos - Fifth";
  } else if (index == 18){
    return "Espolón - Fifth";
  } else if (index == 19){
    return "1800 - Fifth";
  } else if (index == 20){
    return "Jack Daniels - Fifth";
  } else if (index == 21){
    return "Jim Beam - Fifth";
  } else if (index == 22){
    return "Jameson - Fifth";
  } else if (index == 23){
    return "Fireball - Fifth";
  } else if (index == 24){
    return "Screwball - Fifth";
  } else if (index == 25){
    return "White Claw - 6 Pack";
  } else if (index == 26){
    return "Truly - 6 Pack";
  } else if (index == 27){
    return "Bud Light Seltzer - 6 Pack";
  } else if (index == 28){
    return "High Noon - 6 Pack";
  } else if (index == 29){
    return "Long Drink - 6 Pack";
  } else if (index == 30){
    return "Malibu - Fifth";
  } else if (index == 31){
    return "Baileys - Fifth";
  } else if (index == 32){
    return "Beefeaters - Fifth";
  } else if (index == 33){
    return "Hennessey - Fifth";
  } else if (index == 34){
    return "Jägermeister - Fifth";
  } else if (index == 35){
    return "Captain Morgan - Fifth";
  }
  else{
    return "";
  }
}