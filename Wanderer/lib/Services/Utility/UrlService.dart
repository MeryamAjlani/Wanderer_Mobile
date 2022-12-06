import 'package:url_launcher/url_launcher.dart';
import 'package:latlong/latlong.dart';

class UrlService {
  static void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void getDirection(LatLng location) {
    openUrl(
        "https://www.google.com/maps/dir/?api=1&destination=${location.latitude},${location.longitude}");
  }
}
