import 'package:flutter/material.dart';

AssetImage storeToHeaderImage(String storeId){
  if (storeId == "4jzwzudEmlcNbTQMR2Sl"){
    return AssetImage("lib/assets/stadiumMarketBG.jpg");
  } else if (storeId == "AXHqSDExs8FUkNCjcZ8K"){
    return AssetImage("lib/assets/championsBG.jpg");
  } else if (storeId == "aimeGAEFhlUmzty9ERYI"){
    return AssetImage("lib/assets/stricklandsBG.jpg");
  } else if (storeId == "nKmCb07Heh32gMgdonXc"){
    return AssetImage("lib/assets/mainStreetPartyBG.jpg");
  } else if (storeId == "sGHiRnmXimv1tMb2Q11c"){
    return AssetImage("lib/assets/totalWineBG.jpg");
  } else {
    return AssetImage("lib/assets/storeBackgroundImage.jpg");
  }
}