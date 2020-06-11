import 'package:geolocator/geolocator.dart';

class Location {
  String countryName;

  Future<bool> isLoactionEnabled() async {
    return await Geolocator().isLocationServiceEnabled();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      List<Placemark> p = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      countryName = p[0].country;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
