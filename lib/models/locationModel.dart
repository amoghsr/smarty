import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  Position position;

  Future<void> getCurrentLocation() async {
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      latitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
