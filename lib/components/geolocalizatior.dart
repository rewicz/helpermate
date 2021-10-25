import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class Geolocalizator extends StatefulWidget {
  bool isLocated;
  bool editMode;

  Location location = new Location();

  Geolocalizator({
    required this.isLocated,
    required this.editMode,
  });

  @override
  _GeolocalizatorState createState() => _GeolocalizatorState();
}

class _GeolocalizatorState extends State<Geolocalizator> {
  String myPosition = 'nic';

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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

    setState(() {
      myPosition = position.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          widget.isLocated
              ? Text('Lokalizacja jest pobrana')
              : Text('Zaaktualizuj lokalizacje'),
          Text(myPosition),
          Visibility(
              visible: widget.editMode,
              child: TextButton(
                onPressed: () {
                  _handlePermission();
                },
                child: Text('pobierz'),
              )),
        ],
      ),
    );
  }
}
