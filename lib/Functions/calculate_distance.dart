import 'package:geolocator/geolocator.dart';
import 'package:liquor_locate2/globals.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> openSettings() async {
  await openAppSettings();
}

Future<String> getDistance(Position storeLocation) async{
  try {

    // Calculate the distance between the user's location and the store's location
    double distanceInMeters = Geolocator.distanceBetween(
      userLocation.latitude, userLocation.longitude,
      storeLocation.latitude, storeLocation.longitude,
    );

    double distanceInMiles = distanceInMeters * 0.000621371;

    // Return the formatted distance as a string
    return '${distanceInMiles.toStringAsFixed(2)} miles away';
  } catch (e) {
    return 'Error getting distance: $e';
  }
}

double getDistanceDouble(Position storeLocation) {
  try {

    // Calculate the distance between the user's location and the store's location
    double distanceInMeters = Geolocator.distanceBetween(
      userLocation.latitude, userLocation.longitude,
      storeLocation.latitude, storeLocation.longitude,
    );

    double distanceInMiles = distanceInMeters * 0.000621371;

    // Return the formatted distance as a string
    return distanceInMiles;
  } catch (e) {
    return -1;
  }
}
