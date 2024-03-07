import 'package:url_launcher/url_launcher.dart';

void openAppleMaps(double latitude, double longitude, String storeName) async {
  final url = Uri.https('maps.apple.com', '', {'q': '$storeName,$latitude,$longitude'});
  
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch Apple Maps.';
  }
}