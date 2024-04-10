import 'package:url_launcher/url_launcher.dart';

void openAppleMaps(double latitude, double longitude, String storeName) async {
  // final url = Uri.https('maps.apple.com', '', {'q': '$storeName,$latitude,$longitude'});

  late Uri url;
  
  if (storeName[0] == 'T') {
    // Total wine will use old query as above
    url = Uri.https(
        'maps.apple.com', '', {'q': '$storeName,$latitude,$longitude'});
  } else {
    // All other stores queried exactly to store, not just long,lat
    url = Uri.https('maps.apple.com', '',
        {'q': storeName, 'sll': '$latitude,$longitude'});
  }

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch Apple Maps.';
  }
}
