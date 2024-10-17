import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key, required String location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: const BangkokMap(),
    );
  }
}

class BangkokMap extends StatefulWidget {
  const BangkokMap({Key? key}) : super(key: key);

  @override
  _BangkokMapState createState() => _BangkokMapState();
}

class _BangkokMapState extends State<BangkokMap> {
  late GoogleMapController mapController;

  final LatLng _bangkokLocation = const LatLng(13.7563, 100.5018); // Bangkok coordinates

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _bangkokLocation,
        zoom: 10,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('bangkok'),
          position: _bangkokLocation,
          infoWindow: const InfoWindow(title: 'Bangkok'),
        ),
      },
    );
  }
}
