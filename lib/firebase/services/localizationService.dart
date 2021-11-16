import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationService {
   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // enabled
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // not permission
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // not permission
      return false;
    }
    // jest ok
    return true;
  }

  double distanceBetween(GeoPoint first, GeoPoint second) {
    return _geolocatorPlatform.distanceBetween(first.latitude, second.latitude, second.longitude, second.longitude);
  }

  Future<GeoPoint?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return null;
    }
    Position position = await _geolocatorPlatform.getCurrentPosition();
    GeoPoint geoPoint  = GeoPoint(position.latitude, position.longitude) ;
    return geoPoint;

  }
}
