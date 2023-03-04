import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:amala/constants/core_data.dart';

class LocationService {
  //Base Position tracking and permission granting
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 20));
  }

  Future getLocation() async {
    var lat = await determinePosition().then((value) => value.latitude);
    var lon = await determinePosition().then((value) => value.longitude);
    try {
      Response response = await get(Uri.parse(
          'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=id'));
      Map map = jsonDecode(response.body);
      CoreData.kota = map['city'];
      CoreData.wilayah = map['locality'];
      CoreData.lat = lat;
      CoreData.lon = lon;
    } catch (e) {
      return;
    }
  }
}
