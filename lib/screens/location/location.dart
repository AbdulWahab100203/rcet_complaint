import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _position;
  String _message = '';
  int? _intLatitude;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _message = 'Location services are disabled.');
      return;
    }

    // Request permission if needed
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _message = 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _message = 'Location permissions are permanently denied.');
      return;
    }

    Position loc = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        timeLimit: Duration(seconds: 10),
      ),
    );

    setState(() {
      _position = loc;
      _intLatitude = loc.latitude.toInt();
      _message = 'Lat long: ${loc.latitude}, ${loc.longitude}';
    });

    print(_message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Location')),
      body: RefreshIndicator(
        onRefresh: () async {
          await getLocation();
        },
        child: ListView(
          children: [
            SizedBox(height: 100),
            Center(child: Text('Latitude (int): $_intLatitude')),
            Center(child: Text('Message: $_message')),
          ],
        ),
      ),
    );
  }
}
